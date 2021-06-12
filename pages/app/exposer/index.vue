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
        dense
        class="ml-auto mr-5"
        @click="sidebarOpen = !sidebarOpen"
      >
        <v-icon>
          {{ sidebarOpen ? 'mdi-arrow-collapse' : 'mdi-arrow-expand' }}
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
                  width="0"
                  height="0"
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
        <v-col v-show="sidebarOpen" sm="auto" class="full-height secondary scrollable px-10">
          <v-tabs v-model="rightTabs" dark background-color="secondary" class="secondary" height="2rem">
            <v-tab class="secondary text-caption">
              Channel Spread
            </v-tab>
            <v-tab class="text-caption">
              Adjustments
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="rightTabs" class="secondary white--text" dark>
            <!-- Histogram items -->
            <v-tab-item class="py-2" eager>
              <v-form :disabled="!channelControlsEnabled">
                <v-row no-gutters class="d-flex justify-end">
                  <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickAutoChannels">
                    auto
                  </v-btn>
                  <v-text-field
                    v-model="channelControls.shiftAutoClip"
                    dense
                    class="ma-0 pa-0 text-caption align-center"
                    type="number"
                    hide-details
                  />
                  <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickResetChannels">
                    reset
                  </v-btn>
                </v-row>
                <template v-for="(index) in [0, 1, 2]">
                  <v-col :key="index" sm="auto">
                    <h6 class="text-caption">
                      {{ channelControls.titles[index] }}
                    </h6>
                    <v-col sm="" class="pa-0">
                      <canvas :ref="channelControls.names[index]" width="256" height="100" class="grey darken-4" />
                    </v-col>
                    <v-col sm="" class="d-flex justify-space-between pa-0 mt-1">
                      <small>{{ channelControls.blackCount[index].toLocaleString() }}</small>
                      <small>{{ channelControls.whiteCount[index].toLocaleString() }}</small>
                    </v-col>

                    <!-- Shift -->
                    <v-row no-gutters>
                      <v-col sm="1">
                        <small class="text-caption">Shift</small>
                      </v-col>
                      <v-spacer />
                      <v-col sm="auto">
                        <v-text-field
                          v-model="channelControls.shift[index].value"
                          dense
                          class="ma-0 pa-0 text-caption align-center"
                          type="number"
                          height="1rem"
                          hide-details
                          style="width: 3rem;"
                        />
                      </v-col>
                      <v-col sm="12">
                        <v-slider
                          v-model="channelControls.shift[index].value"
                          :min="-128"
                          :max="128"
                          class="align-center"
                          hide-details
                          dense
                          height="1rem"
                          @input="onValueChangeChannel"
                        />
                      </v-col>
                    </v-row>
                    <!--  -->
                    <!-- Spread -->
                    <v-row no-gutters>
                      <v-col sm="1">
                        <small class="text-caption">Spread</small>
                      </v-col>
                      <v-spacer />
                      <v-col sm="auto">
                        <v-text-field
                          v-model="channelControls.spread[index].value"
                          dense
                          class="ma-0 pa-0 text-caption align-center"
                          type="number"
                          height="1rem"
                          hide-details
                          style="width: 3rem;"
                        />
                      </v-col>
                      <v-col sm="12">
                        <v-slider
                          v-model="channelControls.spread[index].value"
                          :min="0"
                          :max="512"
                          class="align-center"
                          hide-details
                          dense
                          height="1rem"
                          @input="onValueChangeChannel"
                        />
                      </v-col>
                    </v-row>
                    <!--  -->
                  </v-col>
                </template>
              </v-form>
            </v-tab-item>

            <v-tab-item>
              <canvas width="256" height="100" />
            </v-tab-item>
          </v-tabs-items>
        </v-col>
      </v-row>
    </div>
    <!-- End Working Area -->

    <!-- Info Bar -->
    <v-sheet color="secondary white--text h-3-p mh-3-p ma-0 pa-0">
      <v-row no-gutters justify="start">
        <v-col sm="auto">
          <div class="text-caption">
            Zoom: {{ zoomPercent }}
          </div>
        </v-col>
        <v-col sm="auto" class="ml-12">
          <div class="text-caption">
            {{ width }} x {{ height }} pixels
          </div>
        </v-col>
        <v-col sm="auto" class="ml-12">
          <div class="text-caption">
            Best clip: {{ Math.round((width * height * 0.001)).toLocaleString() }}
          </div>
        </v-col>
      </v-row>
    </v-sheet>
  </div>
</template>

<script>
// import util from 'assets/util'
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
      width: 0,
      height: 0,
      sidebarOpen: true,
      workTabs: null,
      rightTabs: null,
      histograms: [],
      canvasMain: null,
      ctxMain: null,
      finalView8: null,
      finalView32: null,
      originalChannels: [],
      channelsResult: null,
      channelControls: {
        titles: ['Red', 'Green', 'Blue'],
        names: ['histR', 'histG', 'histB'],
        blackCount: [0, 0, 0],
        whiteCount: [0, 0, 0],
        shift: [{ value: 0 }, { value: 0 }, { value: 0 }],
        shiftAutoClip: 0,
        spread: [{ value: 0 }, { value: 0 }, { value: 0 }],
        spreadAutoClip: 0
      }
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
    },
    channelControlsEnabled () {
      return this.originalChannels[0]
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
        if (this.canvasMain.width > 0) {
          this.hardReset()
        }
        this.canvasMain.width = img.naturalWidth
        this.canvasMain.height = img.naturalHeight
        this.width = img.naturalWidth
        this.height = img.naturalHeight
        this.ctxMain.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        const imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
        this.originalChannels = histogram.separateChannels(imageData.data)
        this.channelsResult = this.originalChannels
        this.finalView8 = new Uint8ClampedArray(imageData.data)
        this.finalView32 = new Uint32Array(this.finalView8.buffer)
        this.updateHistograms()
      }
    },
    hardReset () {
      this.clickResetChannels()
      this.ctxMain.clearRect(0, 0, this.canvasMain.width, this.canvasMain.height)
    },
    processModifiers () {
      // Cache
      // eslint-disable-next-line no-unreachable
      const width = this.canvasMain.width
      const height = this.canvasMain.height
      const finalView32 = this.finalView32
      const shiftR = this.channelControls.shift[0].value
      const shiftG = this.channelControls.shift[1].value
      const shiftB = this.channelControls.shift[2].value
      const spreadR = this.channelControls.spread[0].value
      const spreadG = this.channelControls.spread[1].value
      const spreadB = this.channelControls.spread[2].value

      const channelR = new Uint8ClampedArray(this.originalChannels[0])
      const channelG = new Uint8ClampedArray(this.originalChannels[1])
      const channelB = new Uint8ClampedArray(this.originalChannels[2])
      const channelLength = channelR.length

      // Shift
      if (shiftR !== 0) {
        histogram.shiftChannel(channelR, shiftR)
      }
      if (shiftG !== 0) {
        histogram.shiftChannel(channelG, shiftG)
      }
      if (shiftB !== 0) {
        histogram.shiftChannel(channelB, shiftB)
      }

      // Spread
      if (spreadR !== 0) {
        histogram.spread(channelR, spreadR)
      }
      if (spreadG !== 0) {
        histogram.spread(channelG, spreadG)
      }
      if (spreadB !== 0) {
        histogram.spread(channelB, spreadB)
      }

      // Combine channels
      for (let i = 0; i < channelLength; i++) {
        finalView32[i] =
        (255 << 24) | // alpha
        (channelB[i] << 16) | // blue
        (channelG[i] << 8) | // green
          channelR[i] // red
      }
      this.updateCanvas(width, height)
      this.updateHistograms()
    },
    onValueChangeChannel () {
      this.processModifiers()
    },
    updateCanvas (width, height) {
      const imageData = this.ctxMain.getImageData(0, 0, width, height)
      imageData.data.set(this.finalView8)
      this.ctxMain.putImageData(imageData, 0, 0)
    },
    updateHistograms () {
      // eslint-disable-next-line no-unreachable
      const histdata = histogram.getHistograms(this.finalView8)
      for (let i = 0, j = 0; i < 3; i++, j += 2) {
        this.channelControls.blackCount[i] = histdata[3][j]
        this.channelControls.whiteCount[i] = histdata[3][j + 1]
      }

      for (let i = 0; i < 3; i++) {
        this.histograms[i].clearRect(0, 0, 256, 100)
        histogram.drawHistogram(this.histograms[i], histdata[i])
      }
    },
    clickAutoChannels () {
      // Cache
      const width = this.canvasMain.width
      const height = this.canvasMain.height
      const finalView32 = this.finalView32
      const channelR = new Uint8ClampedArray(this.originalChannels[0])
      const channelG = new Uint8ClampedArray(this.originalChannels[1])
      const channelB = new Uint8ClampedArray(this.originalChannels[2])

      const shiftAutoClip = this.channelControls.shiftAutoClip
      const [shiftR, leftR, rightR, gapR] = histogram.getShiftAuto(channelR, shiftAutoClip)
      const [shiftG, leftG, rightG, gapG] = histogram.getShiftAuto(channelG, shiftAutoClip)
      const [shiftB, leftB, rightB, gapB] = histogram.getShiftAuto(channelB, shiftAutoClip)

      this.channelControls.shift[0].value = shiftR
      this.channelControls.shift[1].value = shiftG
      this.channelControls.shift[2].value = shiftB

      this.channelControls.spread[0].value = histogram.getSpreadAuto(gapR)
      this.channelControls.spread[1].value = histogram.getSpreadAuto(gapG)
      this.channelControls.spread[2].value = histogram.getSpreadAuto(gapB)

      // console.log(this.channelControls.shift[0].value, this.channelControls.shift[1].value, this.channelControls.shift[2].value)
      this.onValueChangeChannel()
    },
    clickResetChannels () {
      for (let i = 0; i < 3; i++) {
        this.channelControls.shift[i].value = 0
        this.channelControls.spread[i].value = 0
      }
      this.onValueChangeChannel()
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
