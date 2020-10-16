<template>
  <div>
    <section>
      <input v-show="false" ref="imageInput" type="file" accepts="image/*" @change="loadImage">
      <v-container fluid class="pa-0 secondary vh-100">
        <!-- Modal Brightness -->
        <v-card v-show="modalBrightness.open" dark class="fixed overlay" width="600px" style="right: 0">
          <v-card-title>
            <h5>
              Brightness Adjustment
            </h5>
            <v-btn right fab x-small class="px-0 mx-0" @click="modalBrightness.open = false">
              <v-icon small class="mx-0 px-0">
                mdi-close
              </v-icon>
            </v-btn>
          </v-card-title>
          <v-card-text>
            <div v-for="(control, index) of modalBrightness.controls" :key="index">
              <v-subheader class="py-0 my-0">
                {{ control.title }}
              </v-subheader>
              <v-slider
                v-model="control.value"
                :min="control.min"
                :max="control.max"
                hide-details
                class="py-0 my-0"
                @change="previewFast"
              >
                <template v-slot:append>
                  <v-text-field
                    v-model="control.value"
                    class="mt-0 pt-0"
                    hide-details
                    single-line
                    type="number"
                    style="width: 60px"
                    @change="previewFast"
                  />
                </template>
              </v-slider>
            </div>
          </v-card-text>
          <v-card-actions>
            <v-spacer />
            <v-btn @click="clickApplyBrightness">
              Ok
            </v-btn>
            <v-btn @click="clickResetBrightness">
              Reset
            </v-btn>
            <v-btn @click="modalBrightness.open = false">
              Cancel
            </v-btn>
          </v-card-actions>
        </v-card>
        <!-- Menu -->
        <v-sheet class="d-flex" color="secondary" elevation="1">
          <v-btn small dark color="secondary" @click="toggleAppBarVisibility">
            <v-icon small>
              {{ appBarVisible ? 'mdi-arrow-collapse-up' : 'mdi-arrow-expand-down' }}
            </v-icon>
          </v-btn>
          <v-menu v-for="(menu, index) of menus" :key="index" offset-y tile>
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="secondary"
                v-bind="attrs"
                small
                class="text-capitalize"
                tile=""
                v-on="on"
              >
                {{ menu.title }}
              </v-btn>
            </template>
            <v-list class="py-0" dense>
              <v-list-item
                v-for="(submenu, jIndex) of menu.submenus"
                :key="jIndex"
                @click="submenu.click"
              >
                <v-list-item-title>
                  {{ submenu.title }}
                </v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
          <v-btn small class="secondary" @click="zoom+=0.1">
            <v-icon>
              mdi-plus
            </v-icon>
          </v-btn>
          <v-btn small class="secondary" :disabled="zoom <= 0.1" @click="zoom-=0.1">
            <v-icon>
              mdi-minus
            </v-icon>
          </v-btn>
          <v-btn
            text
            dark
            small
            class="ml-auto mr-5"
            @click="sidebarOpen = !sidebarOpen"
          >
            <v-icon>
              {{ sidebarOpen ? 'mdi-arrow-collapse-right' : 'mdi-arrow-expand-left' }}
            </v-icon>
          </v-btn>
        </v-sheet>
        <!-- Submenu -->
        <v-sheet class="secondary mt-1" elevation="1">
          <v-btn class="secondary">
            <v-icon>
              mdi-home
            </v-icon>
          </v-btn>
        </v-sheet>
        <!-- Work Area -->
        <v-sheet class="h-90-p">
          <v-row justify="center" align="stretch" no-gutters class="h-100-p">
            <v-col id="viewportContainer" sm="" class="grey darken-4 max-100-p" style="overflow: scroll;">
              <div
                id="viewport"
                :style="{
                  height: canvasSize.y + 'px',
                  width: canvasSize.x + 'px',
                  transform: 'translate(0%, 0%) scale(' + zoom + ')',
                  top: '0%',
                  left: '0%',
                  position: 'relative',
                  marginLeft: (zoom * 0) + '%',
                  marginTop: (zoom * 0) + '%',
                  marginBottom: (zoom * 0) + '%',
                  marginRight: (zoom * 0) + '%',
                  overflow: 'visible',
                  transformOrigin: '0% 0%'
                }"
              >
                <canvas
                  v-for="canvas of canvasLayers"
                  :key="canvas.id"
                  ref="canvases"
                  class=""
                  style="position: absolute;
                  left: 0%;
                  top: 0%;
                  transform: translate(0%, 0%)"
                />
              </div>
            </v-col>
            <!-- Sidebar -->
            <v-col v-show="sidebarOpen" sm="3" class="grey darken-3">
              olap
            </v-col>
          </v-row>
        </v-sheet>
      </v-container>
    </section>
  </div>
</template>

<script>
// import * as tf from '@tensorflow/tfjs'
// import * as vis from '@tensorflow/tfjs-vis'
import util from 'assets/util'
import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      menus: [
        {
          title: 'File',
          submenus: [
            {
              title: 'Open Image',
              click: this.clickOpenImage
            },
            {
              title: 'Save Image',
              click: () => {
                console.log(this.originalData)
                console.log(this.tempData)
              }
            }
          ]
        },
        {
          title: 'Adjustments',
          submenus: [
            {
              title: 'Brightness',
              click: this.clickOpenBrightness
            }
          ]
        }
      ],
      originalFile: null,
      originalData: {},
      tempData: {},
      previewData: {},
      canvasLayers: [{
        id: 1
      }],
      currentCanvas: 0,
      sidebarOpen: true,
      zoom: 1,
      canvasSize: {
        x: 0,
        y: 0
      },
      lowestPixel: 0,
      highestPixel: 255,
      modalBrightness: {
        open: false,
        controls: [
          {
            title: 'Shadows',
            value: 0,
            initialValue: 0,
            min: -64,
            max: 64
          },
          {
            title: 'Darks',
            value: 0,
            initialValue: 0,
            min: -64,
            max: 64
          },
          {
            title: 'Neutrals',
            value: 0,
            initialValue: 0,
            min: -64,
            max: 64
          },
          {
            title: 'Brights',
            value: 0,
            initialValue: 0,
            min: -64,
            max: 64
          },
          {
            title: 'Highlights',
            value: 0,
            initialValue: 0,
            min: -64,
            max: 64
          }
        ]
      }
    }
  },
  computed: {
    appBarVisible () {
      return !this.$store.state.general.appBarHidden
    }
  },
  mounted () {
    this.hideAppBar()
  },
  methods: {
    clickOpenImage () {
      this.$refs.imageInput.click()
    },
    clickOpenBrightness () {
      this.resetModalBrightness()
      const canvas = this.getCurrentCanvas()
      const context = canvas.getContext('2d')
      this.tempData = context.getImageData(0, 0, canvas.width, canvas.height)

      let minAvg = 255
      let maxAvg = 0
      for (let i = 0; i < this.tempData.data.length; i += 4) {
        const r = this.tempData.data[i]
        const g = this.tempData.data[i + 1]
        const b = this.tempData.data[i + 2]
        const average = (r + g + b) / 3
        if (average < minAvg) {
          minAvg = average
        }
        if (average > maxAvg) {
          maxAvg = average
        }
      }
      this.lowestPixel = minAvg
      this.highestPixel = maxAvg
      console.log('MinAvg: ' + minAvg + ', MaxAvg: ' + maxAvg)
      this.modalBrightness.open = true
    },
    clickApplyBrightness () {
      const canvas = this.getCurrentCanvas()
      const context = canvas.getContext('2d')
      context.clearRect(0, 0, canvas.width, canvas.height)
      context.putImageData(this.previewData)
    },
    previewFast () {
      console.log('prev')
      const lowestPixel = this.lowestPixel
      const highestPixel = this.highestPixel

      const tempdata = this.tempData.data

      const canvas = this.getCurrentCanvas()
      const context = canvas.getContext('2d')
      const imageData = context.createImageData(canvas.width, canvas.height)
      const length = imageData.data.length

      const buf = new ArrayBuffer(length)
      const buf8 = new Uint8ClampedArray(buf)
      const data = new Uint32Array(buf)

      const shadowsValue = this.modalBrightness.controls[0].value
      const shadowsPeak = 0
      const shadowsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

      const darksValue = this.modalBrightness.controls[1].value
      const darksPeak = 0.25
      const darksOffset = (highestPixel - lowestPixel) / 5 / highestPixel

      const midsValue = this.modalBrightness.controls[2].value
      const midsPeak = 0.5
      const midsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

      const brightsValue = this.modalBrightness.controls[3].value
      const brightsPeak = 0.75
      const brightsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

      const highlightsValue = this.modalBrightness.controls[4].value
      const highlightsPeak = 1
      const highlightsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

      const divisor = 1 / 3 / highestPixel

      let r, g, b, average
      let shadowsToAdd, darksToAdd, midsToAdd, brightsToAdd, highlightsToAdd

      for (let i = 0, j = 0; i < length; i += 4, j++) {
        r = tempdata[i]
        g = tempdata[i + 1]
        b = tempdata[i + 2]

        average = (r + g + b) * divisor

        shadowsToAdd = this.calculateStrength(average, shadowsPeak, shadowsOffset) * shadowsValue
        darksToAdd = this.calculateStrength(average, darksPeak, darksOffset) * darksValue
        midsToAdd = this.calculateStrength(average, midsPeak, midsOffset) * midsValue
        brightsToAdd = this.calculateStrength(average, brightsPeak, brightsOffset) * brightsValue
        highlightsToAdd = this.calculateStrength(average, highlightsPeak, highlightsOffset) * highlightsValue

        const finalSum = shadowsToAdd + darksToAdd + midsToAdd + brightsToAdd + highlightsToAdd
        r += finalSum
        g += finalSum
        b += finalSum

        r = util.clamp(r, 0, 255)
        g = util.clamp(g, 0, 255)
        b = util.clamp(b, 0, 255)

        data[j] =
        (255 << 24) | // alpha
        (b << 16) | // blue
        (g << 8) | // green
          r // red
      }
      imageData.data.set(buf8)
      context.putImageData(imageData, 0, 0)
    },
    calculateStrength (average, peak, offset) {
      let strength
      if (average > peak) {
        if (average > peak + offset) {
          strength = 0
        } else {
          strength = util.findPercentage(average, peak + offset, peak)
        }
      } else if (average < peak) {
        if (average < peak - offset) {
          strength = 0
        } else {
          strength = util.findPercentage(average, peak - offset, peak)
        }
      } else {
        strength = 1
      }
      return util.clamp(Math.abs(strength), 0, 1)
    },
    clickResetBrightness () {
      this.resetModalBrightness()
      const canvas = this.getCurrentCanvas()
      const context = canvas.getContext('2d')
      const imageData = this.tempData
      context.clearRect(0, 0, canvas.width, canvas.height)
      context.putImageData(imageData, 0, 0)
    },
    loadImage () {
      this.originalFile = this.$refs.imageInput.files[0]
      const img = new Image()
      img.src = URL.createObjectURL(this.originalFile)
      const canvas = this.$refs.canvases[0]

      const context = canvas.getContext('2d')
      context.clearRect(0, 0, canvas.width, canvas.height)

      img.onload = () => {
        this.canvasSize.x = img.naturalWidth
        this.canvasSize.y = img.naturalHeight
        canvas.width = img.naturalWidth
        canvas.height = img.naturalHeight
        context.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        this.originalData = context.getImageData(0, 0, canvas.width, canvas.height)
      }
    },
    fireTransform () {
      const canvas = document.getElementById('canvasLarge')
      const context = canvas.getContext('2d')
      const imageData = context.getImageData(0, 0, canvas.width, canvas.height)
      console.log(imageData.data)
      if (this.grayscale) {
        for (let i = 0; i < imageData.data.length; i += 4) {
          const r = imageData.data[i]
          const g = imageData.data[i + 1]
          const b = imageData.data[i + 2]

          const avg = (((r * 100 / 255) + (g * 100 / 255) + (b * 100 / 255)) + ((r + g + b) / 3)) / 2
          imageData.data[i] = avg
          imageData.data[i + 1] = avg
          imageData.data[i + 2] = avg
        }
      }
      for (let i = 0; i < imageData.data.length; i++) {
        if ((i + 1) % 4 !== 0) {
          let newValue = imageData.data[i]
          let weight = 0
          if (this.brightness > 0) {
            weight = 1 - newValue / 510
          } else if (this.brightness < 0) {
            weight = 0.5 - newValue / 255
            // console.log(weight)
          }
          newValue += weight * this.brightness
          imageData.data[i] = newValue
        }
      }

      context.clearRect(0, 0, canvas.width, canvas.height)
      context.putImageData(imageData, 0, 0)

      console.log(imageData.data)
    //   const dataURL = canvas.toDataURL('image/png')
    },
    resetModalBrightness () {
      for (let i = 0; i < this.modalBrightness.controls.length; i++) {
        this.modalBrightness.controls[i].value = this.modalBrightness.controls[i].initialValue
      }
    },
    getCurrentCanvas () {
      return this.$refs.canvases[this.currentCanvas]
    },
    ...mapMutations({
      collapseAppBar: 'general/collapseAppBar',
      toggleAppBarVisibility: 'general/toggleAppBarVisibility',
      hideAppBar: 'general/hideAppBar'
    })
  },
  head () {
    return {
      title: 'Photo Editor',
      meta: [
        { hid: 'description', name: 'description', content: 'Photo Editor' }
      ]
    }
  }
}
</script>

<style>
:root{
  --grey: #9E9E9E;
  --grey-lighten-5: #FAFAFA;
  --grey-lighten-4: #F5F5F5;
  --grey-lighten-3: #F5F5F5;
  --grey-lighten-2: #F5F5F5;
  --grey-lighten-1: #F5F5F5;
}
.vh-100{
  height: 100vh;
  max-height: 100vh;
}
.max-100-p{
  max-height: 100%;
  max-width: 100%;
}
.h-90-p{
  height: 90%;
}
.h-100-p{
  height: 100%;
}
.fixed{
  position: fixed;
}
.overlay{
  z-index: 2;
}
#viewportContainer::-webkit-scrollbar {
  width: auto;
}
#viewportContainer::-webkit-scrollbar-track {
  background: #424242;
}
#viewportContainer::-webkit-scrollbar-thumb {
  background: #616161;
}
</style>
