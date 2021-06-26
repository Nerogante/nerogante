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
    <div class="h-90-p mh-90-p green mw-100-p">
      <v-row no-gutters class="yellow h-100-p mh-100-p" dense>
        <!-- Left Window -->
        <v-col class="full-height purple">
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
        <!--  -->
        <!-- Right Window Sidebar -->
        <v-col v-show="sidebarOpen" cols="auto" class="h-100-p mh-100-p secondary">
          <v-tabs
            v-model="rightTabs"
            dark
            background-color="secondary"
            class="secondary h-5-p"
            height="100%"
          >
            <v-tab class="secondary text-caption">
              Channel Spread
            </v-tab>
            <v-tab class="text-caption">
              Adjustments
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="rightTabs" class="secondary white--text h-100-p mh-95-p" dark>
            <!-- Channel spread -->
            <v-tab-item class="py-2 full-height overflow-y-auto px-6 scrollbar-dense" eager>
              <v-row justify="center">
                <v-form :disabled="!channelControlsEnabled" class="">
                  <div class="d-flex justify-end">
                    <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickAutoChannels">
                      auto
                    </v-btn>
                    <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickResetChannels">
                      reset
                    </v-btn>
                  </div>
                  <template v-for="(index) in [0, 1, 2]">
                    <v-col :key="index" sm="auto">
                      <h6 class="text-caption">
                        {{ channelControls.titles[index] }}
                      </h6>
                      <v-col sm="" class="pa-0">
                        <!-- <v-slider
                          v-model="channelControls.newMidPoint[index].value"
                          min="0"
                          max="255"
                          thumb-color="blue"
                          thumb-label=""
                          hide-details
                          height="1rem"
                          @input="changeSliderClip(index)"
                        /> -->
                        <canvas :ref="channelControls.names[index]" width="256" height="100" class="grey darken-4" />
                        <v-range-slider
                          v-model="channelControls.spreadClip[index].value"
                          min="0"
                          max="255"
                          thumb-color="blue"
                          thumb-label=""
                          hide-details
                          height="1rem"
                          @input="changeSliderClip(index)"
                        />
                      </v-col>
                      <!-- BW Info -->
                      <v-col class="pa-0">
                        <v-row justify="space-between" align="center">
                          <v-col cols="" class="grey--text text--lighten-1">
                            <small>{{ channelControls.blackCount[index].toLocaleString() }}</small>
                          </v-col>
                          <v-col cols="" class="text-right grey--text text--lighten-1">
                            <small>{{ channelControls.whiteCount[index].toLocaleString() }}</small>
                          </v-col>
                        </v-row>
                      </v-col>
                      <!--  -->
                    </v-col>
                  </template>
                </v-form>
              </v-row>
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
      finalView64: null,
      originalChannels: [],
      channelsResult: null,
      channelControls: {
        titles: ['Red', 'Green', 'Blue'],
        names: ['histR', 'histG', 'histB'],
        blackCount: [0, 0, 0],
        whiteCount: [0, 0, 0],
        newMidPoint: [{ value: 127 }, { value: 127 }, { value: 127 }],
        spreadClip: [{ value: [0, 255] }, { value: [0, 255] }, { value: [0, 255] }]
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
      const finalView32 = this.finalView32
      const newMidPoint = this.channelControls.newMidPoint.map(a => a.value)
      const spreadClip = this.channelControls.spreadClip.map(a => a.value)
      const channels = this.originalChannels.map(a => new Uint8ClampedArray(a))

      const channelLength = channels[0].length
      for (let i = 0; i < 3; i++) {
        // Spread
        histogram.spread(channels[i], spreadClip[i][0], spreadClip[i][1])
        // Recenter
        // histogram.changeCenter(channels[i], newMidPoint[i])
      }

      // Combine channels
      for (let i = 0; i < channelLength; i++) {
        finalView32[i] =
        (0b11111111000000000000000000000000) | // alpha 255 << 24
        (channels[2][i] << 16) | // blue
        (channels[1][i] << 8) | // green
          channels[0][i] // red
      }
      this.updateCanvas()
      this.updateHistograms()
    },
    onValueChangeChannel () {
      this.processModifiers()
    },
    updateCanvas () {
      const imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
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
    changeSliderClip (index) {
      this.onValueChangeChannel()
    },
    clickAutoChannels () {
      const limit = Math.round(this.width * this.height * 0.001)
      for (let i = 0; i < 3; i++) {
        this.channelControls.spreadClip[i].value = histogram.getAutoClips(this.originalChannels[i], limit)
      }
      this.onValueChangeChannel()
    },
    clickResetChannels () {
      for (let i = 0; i < 3; i++) {
        this.channelControls.spreadClip[i].value = [0, 255]
        // this.channelControls.newMidPoint[i].value = 127
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
