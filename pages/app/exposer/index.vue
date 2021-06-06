<template>
  <!-- App container -->
  <div class="h-100-v secondary">
    <!-- Hidden inputs -->
    <input v-show="false" ref="imageInput" type="file" accepts="image/*" @change="loadImage">
    <!-- Top menu -->
    <v-sheet class="d-flex h-7-p" color="secondary" elevation="1">
      <div class="mx-10 my-6  " />
      <v-menu v-for="(menu, index) of menus" :key="index" offset-y tile absolute>
        <template #activator="{ on, attrs }">
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
      <v-btn
        fab
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
    <!-- End top menu -->

    <!-- <v-sheet class="secondary mt-1" elevation="1">
          <v-btn class="secondary">
            <v-icon>
              mdi-home
            </v-icon>
          </v-btn>
        </v-sheet> -->

    <!-- Working area and sidebar -->
    <div class="h-90-p mh-90-p green">
      <v-row no-gutters class="yellow h-100-p mh-100-p">
        <!-- Left Window -->
        <v-col class="h-100-p mh-100-p purple">
          <v-tabs
            v-model="workTabs"
            dark
            background-color="secondary"
            class="h-5-p"
            height="100%"
            hide-slider
          >
            <v-tab class="text-caption">
              {{ documentName }}
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="workTabs" class="h-100-p mh-95-p">
            <!-- Working Area -->
            <v-tab-item class="blue full-size" eager>
              <div id="viewportContainer" sm="" class="grey darken-4 h-100-p d-flex justify-center overflow-scroll pa-4" @wheel="viewportZoom">
                <canvas
                  ref="mainCanvas"
                  class="mw-100-p mh-100-p"
                  :style="{
                    //position: 'absolute',
                    //left: '0%',
                    //top: '0%',
                    transform: 'scale(' + zoom + ') translate(0%, 0%)'
                  }"
                />
              </div>
            </v-tab-item>
          </v-tabs-items>
        </v-col>
        <!-- Sidebar -->
        <v-col v-show="sidebarOpen" sm="3" class="full-height secondary scrollable px-5">
          <v-tabs v-model="rightTabs" dark background-color="secondary" class="secondary" height="2rem">
            <v-tab class="secondary text-caption">
              Histograms
            </v-tab>
            <v-tab class="text-caption">
              Otra cosa
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="rightTabs" class="secondary white--text" dark>
            <!-- Histogram items -->
            <v-tab-item class="py-2" eager>
              <v-form :disabled="!dataOriginal">
                <template v-for="(block, index) in controlBlocks">
                  <v-col :key="index" sm="auto" style="width: 256px">
                    <div class="text-caption">
                      {{ block.title }}
                    </div>
                    <canvas :ref="block.name" width="256" height="100" class="grey darken-4" />
                    <div class="mt-3">
                      <v-row
                        v-for="control in block.controls"
                        :key="control.title"
                        no-gutters
                      >
                        <v-col sm="1">
                          <small class="text-caption">{{ control.title }}</small>
                        </v-col>
                        <v-spacer />
                        <v-col sm="2">
                          <v-text-field
                            v-model="control.value"
                            dense
                            class="ma-0 pa-0 text-caption align-center"
                            type="number"
                            height="1rem"
                            hide-details
                          />
                        </v-col>
                        <v-col sm="12">
                          <v-slider
                            v-model="control.value"
                            :min="control.min"
                            :max="control.max"
                            class="align-center"
                            hide-details
                            dense
                            height="1rem"
                            style="width: 256px;"
                            @input="onValueChange"
                          />
                        </v-col>
                      </v-row>
                    </div>
                  </v-col>
                </template>
              </v-form>
            </v-tab-item>

            <v-tab-item>
              Otra cosa
            </v-tab-item>
          </v-tabs-items>
        </v-col>
      </v-row>
    </div>
    <!-- End Working Area -->

    <!-- Info Bar -->
    <v-sheet color="secondary white--text h-3-p mh-3-p ma-0 pa-0">
      <div class="text-caption">
        Zoom: {{ zoomPercent }}
      </div>
    </v-sheet>
  </div>
</template>

<script>
import util from 'assets/util'
import histogram from 'assets/histogram'
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
            },
            {
              title: 'Close Image',
              click: () => {
                console.log('close')
              }
            }
          ]
        }
      ],
      documentName: 'Untitled',
      zoom: 1,
      sidebarOpen: true,
      workTabs: null,
      rightTabs: null,
      histograms: [],
      canvasMain: null,
      ctxMain: null,
      dataOriginal: null,
      dataResult: null,
      controlBlocks: [
        // Red
        {
          name: 'histR',
          title: 'Red',
          controls: [
            {
              title: 'Shift',
              value: 0,
              min: -128,
              max: 128
            },
            {
              title: 'Spread',
              value: 0,
              min: -128,
              max: 128
            }
          ]
        },
        // Green
        {
          name: 'histG',
          title: 'Green',
          controls: [
            {
              title: 'Shift',
              value: 0,
              min: -128,
              max: 128
            },
            {
              title: 'Spread',
              value: 0,
              min: -128,
              max: 128
            }
          ]
        },
        // Blue
        {
          name: 'histB',
          title: 'Blue',
          controls: [
            {
              title: 'Shift',
              value: 0,
              min: -128,
              max: 128
            },
            {
              title: 'Spread',
              value: 0,
              min: -128,
              max: 128
            }
          ]
        }
      ]
    }
  },
  head () {
    return {
      title: 'Exposer',
      meta: [
        { hid: 'description', name: 'description', content: 'Exposer' }
      ]
    }
  },
  computed: {
    zoomPercent () {
      return (this.zoom * 100).toFixed(0) + '%'
    }
  },
  mounted () {
    this.isMounted = true
    this.hideAppBar()
    this.canvasMain = this.$refs.mainCanvas
    this.ctxMain = this.canvasMain.getContext('2d')

    this.histograms[0] = this.$refs.histR[0].getContext('2d')
    this.histograms[1] = this.$refs.histG[0].getContext('2d')
    this.histograms[2] = this.$refs.histB[0].getContext('2d')
    for (let i = 0; i < this.histograms.length; i++) {
      this.histograms[i].imageSmoothingEnabled = false
      this.histograms[i].strokeStyle = 'lightgrey'
    }
  },
  methods: {
    ...mapMutations({
      hideAppBar: 'appBar/hide'
    }),
    clickOpenImage () {
      this.$refs.imageInput.click()
    },
    loadImage () {
      if (this.$refs.imageInput.files.length === 0) {
        return
      }

      const file = this.$refs.imageInput.files[0]
      this.documentName = file.name
      const img = new Image()
      img.src = URL.createObjectURL(file)

      img.onload = () => {
        // const viewportHeight = document.getElementById('viewportContainer').clientHeight
        // const viewportWidth = document.getElementById('viewportContainer').clientWidth

        // const factorHeight = viewportHeight / img.naturalHeight
        // const factorWidth = viewportWidth / img.naturalWidth

        // if (factorHeight < factorWidth) {
        //   this.zoom = factorHeight - 0.01
        // } else {
        //   this.zoom = factorWidth - 0.01
        // }

        this.canvasMain.width = img.naturalWidth
        this.canvasMain.height = img.naturalHeight
        this.ctxMain.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        const imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
        this.dataOriginal = new Uint8ClampedArray(imageData.data)
        this.dataResult = new Uint8ClampedArray(this.dataOriginal)
        this.updateHistograms()
      }
    },
    processModifiers () {
      const width = this.canvasMain.width
      const height = this.canvasMain.height
      const dataOriginal = this.dataOriginal
      const len = dataOriginal.length

      const buf = new ArrayBuffer(dataOriginal.length)
      const view8 = new Uint8ClampedArray(buf)
      const view32 = new Uint32Array(buf)
      // Shift
      let r, g, b
      const shiftR = this.controlBlocks[0].controls[0].value
      const shiftG = this.controlBlocks[1].controls[0].value
      const shiftB = this.controlBlocks[2].controls[0].value

      for (let i = 0, j = 0; i < len; i += 4, j++) {
        r = util.clamp(dataOriginal[i] + shiftR, 0, 255)
        g = util.clamp(dataOriginal[i + 1] + shiftG, 0, 255)
        b = util.clamp(dataOriginal[i + 2] + shiftB, 0, 255)
        view32[j] =
        (255 << 24) | // alpha
        (b << 16) | // blue
        (g << 8) | // green
          r // red
      }

      // Spread
      const spreadtR = this.controlBlocks[0].controls[1].value
      const spreadtG = this.controlBlocks[1].controls[1].value
      const spreadtB = this.controlBlocks[2].controls[1].value
      let dir = 1
      let distance = 0

      for (let i = 0, j = 0; i < len; i += 4, j++) {
        dir = view8[i] < 128 ? -1 : 1
        distance = util.findPercentage(view8[i], 128, dir === 1 ? 255 : 0)
        r = util.clamp(view8[i] + (distance * dir * spreadtR), 0, 255)
        dir = view8[i + 1] < 128 ? -1 : 1
        distance = util.findPercentage(view8[i + 1], 128, dir === 1 ? 255 : 0)
        g = util.clamp(view8[i + 1] + (distance * dir * spreadtG), 0, 255)
        dir = view8[i + 2] < 128 ? -1 : 1
        distance = util.findPercentage(view8[i + 2], 128, dir === 1 ? 255 : 0)
        b = util.clamp(view8[i + 2] + (distance * dir * spreadtB), 0, 255)

        view32[j] =
        (255 << 24) | // alpha
        (b << 16) | // blue
        (g << 8) | // green
          r // red
      }

      const imageData = this.ctxMain.getImageData(0, 0, width, height)
      imageData.data.set(view8)
      this.ctxMain.putImageData(imageData, 0, 0)
      this.dataResult = view8
      this.updateHistograms()
    },
    onValueChange () {
      this.processModifiers()
    },
    updateCanvasf () {

    },
    updateHistograms () {
      const [redHistogram, greenHistogram, blueHistogram] = histogram.getHistograms(this.dataResult)

      for (let i = 0; i < 3; i++) {
        this.histograms[i].clearRect(0, 0, 256, 100)
      }
      histogram.drawHistogram(this.histograms[0], redHistogram)
      histogram.drawHistogram(this.histograms[1], greenHistogram)
      histogram.drawHistogram(this.histograms[2], blueHistogram)
    },
    viewportZoom (e) {
      if (e.altKey) {
        e.preventDefault()
        let wheelDirection = e.deltaY < 0 ? 1 : -1
        const zoomAmount = 0.05
        // alert(wheelDirection)
        if (wheelDirection === -1) {
          // alert(this.zoom)
          if (this.zoom + wheelDirection * zoomAmount <= 0) {
            wheelDirection = 0
          }
        }
        this.zoom += wheelDirection * zoomAmount
      }
    },
    debugArray (array, length) {
      const text = []
      for (let i = 0; i < length; i++) {
        text[i] = array[i]
      }
      console.log(text)
    }
  }
}
</script>

<style scoped>
#viewportContainer::-webkit-scrollbar {
  width: auto;
}
#viewportContainer::-webkit-scrollbar-track {
  background: #424242;
}
#viewportContainer::-webkit-scrollbar-thumb {
  background: #616161;
}
canvas {
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-crisp-edges;
  image-rendering: pixelated;
  image-rendering: crisp-edges;
  display: block;
}
</style>
