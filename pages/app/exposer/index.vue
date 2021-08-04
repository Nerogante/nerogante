<template>
  <!-- Root -->
  <div class="">
    <!-- App container -->
    <v-row no-gutters class="grey darken-4 app-container">
      <!-- Top menu -->
      <v-app-bar
        dark
        dense
        class="pl-15 appbar"
        color=""
      >
        <v-btn @click="clickOpenImage">
          <v-icon left>
            mdi-upload
          </v-icon>
          Open
        </v-btn>
        <v-spacer />
        <v-btn icon :color="switches.histograms ? 'green accent-4' : 'white'" @click="switches.histograms = !switches.histograms">
          <v-icon>mdi-chart-histogram</v-icon>
        </v-btn>
        <v-menu
          offset-y
          :close-on-content-click="false"
        >
          <template #activator="{ on, attrs }">
            <v-btn
              icon
              v-bind="attrs"
              v-on="on"
            >
              <v-icon>mdi-dots-vertical</v-icon>
            </v-btn>
          </template>

          <v-list dense dark>
            <v-list-item @click="clickExportImage">
              <v-list-item-title>
                <v-icon left>
                  mdi-content-save
                </v-icon>
                Save Image
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
        <!-- <v-menu v-for="(menu, index) of menus" :key="index" offset-y tile>
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
          <v-list class="py-0" dense dark color="secondary">
            <v-list-item
              v-for="(submenu, jIndex) of menu.submenus"
              :key="jIndex"
              @click="submenu.click"
            >
              <v-list-item-icon>
                <v-icon v-text="submenu.icon" />
              </v-list-item-icon>
              <v-list-item-title class="">
                {{ submenu.title }}
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu> -->
      </v-app-bar>
      <!--              End top menu -->

      <!-- Histograms -->
      <v-sheet
        elevation="2"
        class="white--text justify-center justify-md-start align-center histograms"
        :class="switches.histograms ? 'd-flex flex-md-column flex-row px-2' : 'd-one'"
      >
        <div class="d-none">
          <h6 class="text-caption">
            RGB
          </h6>
          <div
            :style="{
              width: 0 + '%',
              height: '.5rem'
            }"
          />
          <div class="d-flex justify-center align-center">
            <canvas ref="histogramRGB" width="256" height="100" class="secondary darken-2" />
          </div>
          <div
            :style="{
              width: 0 + '%',
              height: '.5rem'
            }"
          />
        </div>
        <div v-for="(value, index) in ['#D32F2F', '#388E3C', '#1976D2']" :key="index" class="d-flex justify-center align-center mx-1 my-2">
          <canvas :ref="channelControls.names[index]" width="256" height="100" class="secondary darken-2 h-100-p w-100-p" />

          <!-- <h6 class="text-caption">
            {{ channelControls.titles[index] }}
          </h6> -->
          <!-- <v-col sm="auto" class="pa-0">
            <div
              :style="{
                width: histogramsLevels.black[index] + '%',
                height: '.5rem',
                backgroundColor: value
              }"
            />
            <div
              :style="{
                width: histogramsLevels.white[index] + '%',
                height: '.5rem',
                backgroundColor: value
              }"
            />
          </v-col> -->
        <!-- BW Info -->
        <!-- <v-col cols="auto" class="pa-0">
          <v-row justify="space-between" align="center">
            <v-col cols="" class="grey--text text--lighten-2">
              <small>{{ channelControls.blackCount[index].toLocaleString() }}</small>
            </v-col>
            <v-col cols="" class="text-right grey--text text--lighten-2">
              <small>{{ channelControls.whiteCount[index].toLocaleString() }}</small>
            </v-col>
          </v-row>
        </v-col> -->
        <!--  -->
        </div>
      </v-sheet>
      <!--  -->

      <!-- Window -->
      <div
        id="canvasContainer"
        cols=""
        class="overflow-hidden mh-100-p mw-100-p pa-2"
        @wheel="viewportZoom"
        @mousedown="canvasMouseDown"
        @mousemove="canvasMouseMove"
        @mouseleave="canvasMouseLeave"
        @mouseup="canvasMouseUp"
        @mouseout="canvasMouseOut"
        @dblclick="canvasDoubleClick"
        @resize="canvasContainerResize"
      >
        <canvas
          ref="mainCanvas"
          width="0"
          height="0"
          class="work-canvas"
          :style="{
            //position: 'absolute',
            //left: '0%',
            //top: '0%',
            transform: 'scale(' + zoom + ') translate(' + offsetX + 'px, ' + offsetY + 'px)'
          }"
        />
        <!-- <div id="canvasContainer" sm="" class="mw-100-p mh-100-p">
        </div> -->
      </div>
      <!--          End Window -->

      <!-- Adjustments Sidebar -->
      <v-sheet cols="auto" class="mh-100-p d-flex flex-column justify-start adjustments">
        <!-- Tabs container -->
        <div class="d-flex flex-column flex-md-column-reverse">
          <v-tabs-items v-model="adjustmentTabs" dark style="overflow: visible;" class="transparent pt-md-10">
            <!-- Spread -->
            <v-tab-item value="tab-1" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-slider
                  v-model="controls.spread.limit"
                  dense
                  min="0"
                  max="20"
                  thumb-label="always"
                  thumb-size=""
                  hide-details=""
                  thumb-color="blue darken-3"
                  append-icon="mdi-plus"
                  prepend-icon="mdi-minus"
                  @click:append="clickAddSpreadLimit(1)"
                  @click:prepend="clickAddSpreadLimit(-1)"
                  @input="inputSpread()"
                />
                <v-checkbox
                  v-model="controls.spread.keepBalance"
                  label="Keep Balance"
                  color="blue"
                  hide-details
                  dense
                  @click="inputSpread()"
                />
                <div class="d-flex justify-end pt-2">
                  <!-- <v-btn dark :disabled="!channelControlsEnabled" @click="clickApplySpread">
                    <v-icon left>mdi-check</v-icon>
                    Apply
                  </v-btn> -->
                  <v-btn dark :disabled="!channelControlsEnabled" @click="clickResetSpread">
                    <v-icon left>mdi-undo-variant</v-icon>
                    Reset
                  </v-btn>
                </div>
              </v-col>
            </v-tab-item>
            <!--  -->

            <!-- Balance -->
            <v-tab-item value="tab-2" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-slider
                  v-model="controls.balance.strength"
                  dense
                  min="0"
                  max="20"
                  thumb-label="always"
                  thumb-size=""
                  hide-details=""
                  thumb-color="blue darken-3"
                  append-icon="mdi-plus"
                  prepend-icon="mdi-minus"
                  @click:append="clickAddBalanceStrength(1)"
                  @click:prepend="clickAddBalanceStrength(-1)"
                  @input="inputBalance()"
                />
                <div class="d-flex justify-end pt-2">
                  <!-- <v-btn dark :disabled="!channelControlsEnabled" @click="clickApplySpread">
                    <v-icon left>mdi-check</v-icon>
                    Apply
                  </v-btn> -->
                  <v-btn dark :disabled="!channelControlsEnabled" @click="clickResetSpread">
                    <v-icon left>mdi-undo-variant</v-icon>
                    Reset
                  </v-btn>
                </div>
              </v-col>
            </v-tab-item>
            <!--  -->

            <!-- Intensity -->
            <v-tab-item value="tab-3" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <div class="d-flex justify-space-between">
                <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickAutoIntensity">
                  auto
                </v-btn>
                <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickResetIntensity">
                  reset
                </v-btn>
              </div>
              <v-row no-gutters>
                <v-col class="">
                  <template v-for="(value, index) in ['Mids', 'Darks', 'Lights', 'Blacks', 'Whites']">
                    <v-col :key="index" cols="12" class="px-0">
                      <h6 class="text-caption">
                        {{ value }}
                      </h6>
                      <v-slider
                        v-model="intensityControls[index].value"
                        min="-100"
                        max="100"
                        thumb-color="grey"
                        thumb-label=""
                        hide-details
                        height="1rem"
                        color=""
                        @input="changeSliderIntensity(index)"
                      />
                    </v-col>
                  </template>
                </v-col>
              </v-row>
            </v-tab-item>
          </v-tabs-items>
          <v-tabs
            v-model="adjustmentTabs"
            background-color="transparent"
            centered
            icons-and-text
            dark
            height=""
          >
            <!-- <v-tabs-slider /> -->
            <v-tab href="#tab-1" :disabled="!imageLoaded">
              Spread
              <v-icon>mdi-chart-bar</v-icon>
            </v-tab>
            <v-tab href="#tab-2" :disabled="!imageLoaded">
              Balance
              <v-icon>mdi-palette</v-icon>
            </v-tab>
            <v-tab href="#tab-3" :disabled="!imageLoaded">
              Levels
              <v-icon>mdi-chart-bell-curve</v-icon>
            </v-tab>
          </v-tabs>
        </div>
      </v-sheet>
      <!--  -->

      <v-footer class="footer d-none d-md-block" dark elevation="6">
        Hello
      </v-footer>
    </v-row>
    <!-- <p>Ola ke tal</p> -->
    <!-- Hidden inputs -->
    <input v-show="false" ref="imageInput" type="file" accepts="image/*" @change="loadImage">
  </div>
</template>

<script>
import util from 'assets/util'
import histogram from 'assets/histogram'
import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      switches: {
        histograms: true
      },
      imageLoaded: false,
      documentName: 'Untitled',
      adjustmentTabs: null,
      tabsTransition: 'a',
      pressing: false,
      startPosition: [0, 0],
      offsetX: 0,
      offsetY: 0,
      zoom: 1,
      width: 0,
      height: 0,
      sidebarOpen: true,
      histograms: [],
      histogramsLevels: {
        black: [0, 0, 0],
        white: [0, 0, 0]
      },
      histogramRGB: null,
      canvasMain: null,
      ctxMain: null,
      imageData: null,
      finalView8: null,
      finalView32: null,
      previewView8: null,
      previewView32: null,
      originalChannels: Array(3),
      originalCounts: Array(3),
      hsl: Array(3),
      checkPoints: [],
      channelControls: {
        titles: ['Red', 'Green', 'Blue'],
        names: ['histR', 'histG', 'histB'],
        blackCount: [0, 0, 0],
        whiteCount: [0, 0, 0],
        spreadClip: [{ value: [0, 255] }, { value: [0, 255] }, { value: [0, 255] }],
        prevSpreadClip: [{ value: [0, 255] }, { value: [0, 255] }, { value: [0, 255] }]
      },
      colorBalanceControls: {
        colorBalance: [
          { value: 0 }, { value: 0 }, { value: 0 }
        ],
        prevColorBalance: [
          { value: 0 }, { value: 0 }, { value: 0 }
        ]
      },
      intensityControls: [
        { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }
      ],
      prevIntensityControls: [
        { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }, { value: 0 }
      ],
      controls: {
        spread: {
          limit: 0,
          keepBalance: false
        },
        balance: {
          strength: 0
        }
      }
    }
  },
  head () {
    return {
      title: 'Exposer - Nerogante',
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
    this.histogramRGB = this.$refs.histogramRGB.getContext('2d')
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
    clickExportImage () {
      console.log('Export Image')
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
        if (this.canvasMain.width > 0) {
          this.hardReset()
        }
        this.canvasMain.width = img.naturalWidth
        this.canvasMain.height = img.naturalHeight
        this.width = img.naturalWidth
        this.height = img.naturalHeight
        this.canvasContainerResize()
        this.ctxMain.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        this.imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
        this.originalChannels = histogram.separateChannels(this.imageData.data)
        this.checkPoints[0] = this.originalChannels.map(chan => new Uint8ClampedArray(chan))
        this.checkPoints[1] = this.originalChannels.map(chan => new Uint8ClampedArray(chan))
        this.finalView8 = this.imageData.data
        this.finalView32 = new Uint32Array(this.finalView8.buffer)
        this.previewView8 = new Uint8ClampedArray(this.imageData.data)
        this.previewView32 = new Uint32Array(this.previewView8.buffer)
        this.originalCounts = this.originalChannels.map(chan => histogram.getCount(chan))
        this.imageLoaded = true
        this.updateHistograms()
      }
    },
    // Levels
    previewSpread () {
      const levelsLimit = this.controls.spread.limit - 1
      const keepBalance = this.controls.spread.keepBalance
      const channels = this.originalChannels.map(chan => new Uint8ClampedArray(chan))
      const limit = (this.width * this.height * 0.0001) * levelsLimit * (keepBalance ? 4 : 2)

      const previewView32 = this.previewView32
      const len = this.originalChannels[0].length

      const clips = Array(3)
      for (let i = 0; i < 3; i++) {
        clips[i] = histogram.getAutoClips(channels[i], limit, this.originalCounts[i])
      }

      let clipL = clips[0][0]
      let clipR = clips[0][1]

      for (let i = 1; i < 3; i++) {
        if (clips[i][0] < clipL) {
          clipL = clips[i][0]
        }
        if (clips[i][1] > clipR) {
          clipR = clips[i][1]
        }
      }

      for (let i = 0; i < 3; i++) {
        if (!keepBalance) {
          histogram.percentileStretch(channels[i], clips[i][0], clips[i][1])
        } else {
          histogram.percentileStretch(channels[i], clipL, clipR)
        }
      }

      for (let i = 0; i < len; i++) {
        previewView32[i] =
        (0b11111111000000000000000000000000) | // alpha 255 << 24
        (channels[2][i] << 16) | // blue
        (channels[1][i] << 8) | // green
          channels[0][i] // red
      }
      this.updateCanvasPreview()
      this.updateHistogramsPreview()
    },
    clickApplySpread () {

    },
    clickResetSpread () {
      this.controls.spread.keepBalance = false
      this.controls.spread.limit = 0
      this.inputSpread()
    },
    processModifiers () {
      // Cache
      const finalView32 = this.finalView32
      // Controls
      const levelsLimit = this.controls.levelsLimit
      const spreadClip = this.channelControls.spreadClip.map(a => a.value)
      const prevSpreadClip = this.channelControls.prevSpreadClip.map(a => a.value)
      const colorBalance = this.colorBalanceControls.colorBalance.map(a => a.value)
      const prevColorBalance = this.colorBalanceControls.prevColorBalance.map(a => a.value)
      const intensity = this.intensityControls.map(a => a.value)
      const prevIntensity = this.prevIntensityControls.map(a => a.value)
      const he = this.controls.adaptativeSpread.value

      const channels = Array(3)
      const hsl = this.hsl

      let changedSpread, changedBalance
      for (let i = 0; i < 3; i++) {
        spreadClip[i] = histogram.getAutoClips(channels)

        changedSpread = (spreadClip[i][0] !== prevSpreadClip[i][0] || spreadClip[i][1] !== prevSpreadClip[i][1])
        // changedBalance = (colorBalance[i] !== prevColorBalance[i])

        // Spread
        if (changedSpread) {
          channels[i] = new Uint8ClampedArray(this.originalChannels[i])
          histogram.percentileStretch(channels[i], spreadClip[i][0], spreadClip[i][1])
          this.checkPoints[0][i] = new Uint8ClampedArray(channels[i])
        } else {
          channels[i] = new Uint8ClampedArray(this.checkPoints[0][i])
        }
        // Color Balance
        // if (changedSpread || changedBalance) {
        //   histogram.moveSection(channels[i], colorBalance[i], histogram.range.MID, histogram.interpolation.LINEAR)
        //   this.checkPoints[1][i] = new Uint8ClampedArray(channels[i])
        // } else {
        //   channels[i] = new Uint8ClampedArray(this.checkPoints[1][i])
        // }

        // histogram.moveSection(channels[i], 128, colorBalance[i])
        // Color Balance

        // Adaptative Spread
        // console.log('Spread:', changedSpread, 'new:', spreadClip[i][0], spreadClip[i][1], 'old:', prevSpreadClip[i][0], prevSpreadClip[i][1])
        // console.log('Balance:', changedBalance, 'new:', colorBalance[i], 'old:', prevColorBalance[i])
      }
      const channelLength = channels[0].length

      // const limit = Math.round(this.width * this.height * 0.001)
      // histogram.minMaxStretch(channels, limit)

      const channelBW = new Uint8ClampedArray(channelLength)
      const channelBWClone = new Uint8ClampedArray(channelLength)

      // const Rfactor = 0.2126
      // const Gfactor = 0.7152
      // const Bfactor = 0.0722
      const Rfactor = 1 / 3
      const Gfactor = 1 / 3
      const Bfactor = 1 / 3
      // for (let i = 0; i < channelLength; i++) {
      //   channelBW[i] = channels[0][i] * Rfactor + channels[1][i] * Gfactor + channels[2][i] * Bfactor
      //   channelBWClone[i] = channelBW[i]
      // }
      // histogram.exposure(channelBW, intensity[0])
      // histogram.moveSection(channelBW, intensity[0], histogram.range.MID, histogram.interpolation.SPHERICAL)
      // histogram.moveSection(channelBW, intensity[1], histogram.range.DARK, histogram.interpolation.SPHERICAL)
      // histogram.moveSection(channelBW, intensity[2], histogram.range.LIGHT, histogram.interpolation.SPHERICAL)
      // histogram.moveSection(channelBW, intensity[3], histogram.range.BLACK, histogram.interpolation.SPHERICAL)
      // histogram.moveSection(channelBW, intensity[4], histogram.range.WHITE, histogram.interpolation.SPHERICAL)

      // histogram.adaptativeSpread(channelBW, this.width, this.height, he)

      // for (let i = 0; i < channelLength; i++) {
      //   channels[0][i] += channelBW[i] - channelBWClone[i]
      //   channels[1][i] += channelBW[i] - channelBWClone[i]
      //   channels[2][i] += channelBW[i] - channelBWClone[i]
      // }

      // RGB to HSL
      // hsl[0] = Array(channelLength)
      // hsl[1] = Array(channelLength)
      // hsl[2] = Array(channelLength)
      // let h, s, l
      // for (let i = 0; i < channelLength; i++) {
      //   //
      //   [h, s, l] = histogram.RGBToHSL(channels[0][i], channels[1][i], channels[2][i])
      //   hsl[0][i] = h
      //   hsl[1][i] = s
      //   hsl[2][i] = l
      // }
      // const channelsCompare = Array(3)
      // channelsCompare[0] = new Uint8ClampedArray(channelLength)
      // channelsCompare[1] = new Uint8ClampedArray(channelLength)
      // channelsCompare[2] = new Uint8ClampedArray(channelLength)

      // let r; let g; let b; let totalWrong = 0
      // for (let i = 0; i < channelLength; i++) {
      //   [r, g, b] = histogram.HSLToRGB(hsl[0][i], hsl[1][i], hsl[2][i])
      //   channelsCompare[0][i] = r
      //   channelsCompare[1][i] = g
      //   channelsCompare[2][i] = b

      //   if (channels[0][i] !== channelsCompare[0][i] || channels[1][i] !== channelsCompare[1][i] || channels[2][i] !== channelsCompare[2][i]) {
      //     totalWrong++
      //   }
      //   console.log('r:', channels[0][i], channelsCompare[0][i], 'g:', channels[1][i], channelsCompare[1][i], 'b:', channels[2][i], channelsCompare[2][i])
      // }
      // console.log('Total Wrong:', totalWrong, 'TotalCorrect:', channelLength - totalWrong)

      // Convert RGB to HSL
      // for (let i = 0; i < 5; i++) {
      //   histogram.moveSection()
      // }

      // histogram.grayWorld(channels)
      // histogram.grayWorldLevels(channels)

      // Previous values
      for (let i = 0; i < 3; i++) {
        prevSpreadClip[i][0] = spreadClip[i][0]
        prevSpreadClip[i][1] = spreadClip[i][1]
        this.colorBalanceControls.prevColorBalance[i].value = colorBalance[i]
      }
      for (let i = 0; i < intensity.length; i++) {
        prevIntensity[i] = intensity[i]
      }

      // Combine channels
      for (let i = 0; i < channelLength; i++) {
        finalView32[i] =
        (0b11111111000000000000000000000000) | // alpha 255 << 24
        (channels[2][i] << 16) | // blue
        (channels[1][i] << 8) | // green
          channels[0][i] // red
        // finalView32[i] =
        // (0b11111111000000000000000000000000) | // alpha 255 << 24
        // (channelBW[i] << 16) | // blue
        // (channelBW[i] << 8) | // green
        //   channelBW[i] // red
      }
      this.updateCanvas()
      this.updateHistograms()
    },
    onValueChangeChannel () {
      this.processModifiers()
    },
    updateCanvasPreview () {
      this.imageData.data.set(this.previewView8)
      this.ctxMain.putImageData(this.imageData, 0, 0)
    },
    updateCanvas () {
      this.imageData.data.set(this.finalView8)
      this.ctxMain.putImageData(this.imageData, 0, 0)
    },
    updateHistogramsPreview () {
      const histdata = histogram.getHistograms(this.previewView8)
      for (let i = 0, j = 0; i < 3; i++, j += 2) {
        this.channelControls.blackCount[i] = histdata[3][j]
        this.channelControls.whiteCount[i] = histdata[3][j + 1]
      }

      for (let i = 0; i < 3; i++) {
        this.histograms[i].clearRect(0, 0, 256, 100)
        this.histogramsLevels.black[i] = histdata[i][0]
        this.histogramsLevels.white[i] = histdata[i][255]
        histogram.drawHistogram(this.histograms[i], histdata[i])
      }

      this.histogramRGB.clearRect(0, 0, 256, 100)
      histogram.drawRGB(this.histogramRGB, histdata[0], histdata[1], histdata[2])
    },
    updateHistograms () {
      const histdata = histogram.getHistograms(this.finalView8)
      for (let i = 0, j = 0; i < 3; i++, j += 2) {
        this.channelControls.blackCount[i] = histdata[3][j]
        this.channelControls.whiteCount[i] = histdata[3][j + 1]
      }

      for (let i = 0; i < 3; i++) {
        this.histograms[i].clearRect(0, 0, 256, 100)
        this.histogramsLevels.black[i] = histdata[i][0]
        this.histogramsLevels.white[i] = histdata[i][255]
        histogram.drawHistogram(this.histograms[i], histdata[i])
      }

      this.histogramRGB.clearRect(0, 0, 256, 100)
      histogram.drawRGB(this.histogramRGB, histdata[0], histdata[1], histdata[2])
    },
    inputSpread (value) {
      // const limit = Math.round(this.width * this.height * 0.001)
      // for (let i = 0; i < 3; i++) {
      //   this.channelControls.spreadClip[i].value = histogram.getAutoClips(this.originalChannels[i], limit)
      // }
      this.previewSpread()
    },
    inputBalance (value) {

    },
    changeSliderClip (index) {
      this.onValueChangeChannel()
    },
    changeSliderHE (index) {
      this.onValueChangeChannel()
    },
    changeSliderColorBalance (index) {
      this.onValueChangeChannel()
    },
    changeSliderIntensity (index) {
      this.onValueChangeChannel()
    },
    // Levels
    clickAddSpreadLimit (amount) {
      this.controls.levels.limit += amount
      this.inputSpread()
    },
    clickAddBalanceStrength (amount) {
      this.controls.balance.limit += amount
      this.inputSpread()
    },
    clickAutoChannels () {

    },
    clickAutoBalance () {

    },
    clickAutoIntensity () {

    },
    clickResetColorBalance () {
      for (let i = 0; i < 3; i++) {
        this.colorBalanceControls.colorBalance[i].value = 0
      }
      this.onValueChangeChannel()
    },
    clickResetIntensity () {
      for (let i = 0; i < this.intensityControls.length; i++) {
        this.intensityControls[i].value = 0
      }
      this.onValueChangeChannel()
    },
    clickAutoHE () {
      const newChannels = this.originalChannels.map(a => new Uint8ClampedArray(a))
      const channelLength = this.originalChannels[0].length
      const finalView32 = this.finalView32
      for (let i = 0; i < 3; i++) {
        newChannels[i] = histogram.histogramEqualization(newChannels[i])
      }
      for (let i = 0; i < channelLength; i++) {
        finalView32[i] =
        (0b11111111000000000000000000000000) | // alpha 255 << 24
        (newChannels[2][i] << 16) | // blue
        (newChannels[1][i] << 8) | // green
          newChannels[0][i] // red
      }
      this.updateCanvas()
      this.updateHistograms()
    },
    clickResetHE () {
    },
    clickSwitchSidebar () {
      // this.sidebarOpen = !this.sidebarOpen
      const linearAbs = () => {
        const factors = Array(256)
        const sum = 128
        for (let i = 0; i < 128; i++) {
          factors[i] = (i - 0 + sum) / (127 - 0 + sum)
          factors[255 - i] = factors[i]
        }
        return factors
      }
      // Google
      const sphericalMid = () => {
        const factors = Array(256)
        for (let i = 0; i < 128; i++) {
          const degree = (i + 1) * (360 / 256)
          const radian = util.degrees_to_radians(degree)
          factors[i] = (1 - Math.cos(radian)) * 0.5
          factors[255 - i] = factors[i]
        }
        return factors
      }
      const sphericalDark = () => {
        const factors = Array(256)
        for (let i = 0; i < 255; i++, factors[i] = 0) {
          // a
        }
        for (let i = 0; i < 64; i++) {
          const degree = (i + 1) * (360 / 128)
          const radian = util.degrees_to_radians(degree)
          factors[i] = (1 - Math.cos(radian)) * 0.5
          factors[127 - i] = factors[i]
        }
        for (let i = 0; i < 192; i++) {
          // const degree = (i + 1) * (360 / 384)
          // const radian = util.degrees_to_radians(degree)
          // factors[255 - i] = (1 - Math.cos(radian)) * 0.5
        }
        return factors
      }
      const factorLOL = () => {
        const factors = Array(256)
        for (let i = 0; i <= 255; i++) {
          factors[i] = 0
        }
        let degFactor = 90 / 64
        let degree = 270
        for (let i = 0; i < 64; i++) {
          const radian = util.degrees_to_radians(degree)
          factors[i] = (Math.sin(radian) + 1) / 2 + 0.5
          degree += degFactor
        }
        degFactor = 90 / 192
        degree = 181
        for (let i = 64; i < 256; i++) {
          const radian = util.degrees_to_radians(degree)
          factors[i] = (Math.sin(radian) + 1) / 2 + 0.5
          degree += degFactor
        }
        // for (let i = 64, a = 256; i < 256; i++, a++) {
        //   const degree = (a) * (360 / 768)
        //   const radian = util.degrees_to_radians(degree)
        //   factors[i] = Math.cos(radian) + 1
        // }
        return factors
      }
      util.exportArray(factorLOL())
    },
    viewportZoom (e) {
      e.preventDefault()
      let wheelDirection = e.deltaY < 0 ? 1 : -1
      const zoomAmount = 0.1
      // alert(wheelDirection)
      if (wheelDirection === -1) {
        // alert(this.zoom)
        if (this.zoom + wheelDirection * zoomAmount <= 0) {
          wheelDirection = 0
        }
      }
      this.zoom += wheelDirection * zoomAmount
    },
    canvasMouseDown (e) {
      this.pressing = true
      const startX = (e.screenX / this.zoom) - this.offsetX
      const startY = (e.screenY / this.zoom) - this.offsetY
      this.startPosition = [startX, startY]
    },
    canvasMouseMove (e) {
      if (this.pressing) {
        const newX = (e.screenX / this.zoom) - this.startPosition[0]
        const newY = (e.screenY / this.zoom) - this.startPosition[1]
        this.offsetX = newX
        this.offsetY = newY
      }
    },
    canvasMouseLeave (e) {
      this.pressing = false
    },
    canvasMouseUp (e) {
      this.pressing = false
    },
    canvasMouseOut (e) {
      this.pressing = false
    },
    canvasDoubleClick (e) {
      this.zoom = 1
      this.offsetX = 0
      this.offsetY = 0
    },
    canvasContainerResize () {
      const container = document.getElementById('canvasContainer')
      const containerRatio = container.clientHeight / container.clientWidth
      const imgRatio = this.height / this.width

      if (containerRatio >= imgRatio) {
        this.canvasMain.style.width = '100%'
        this.canvasMain.style.height = 'unset'
      } else {
        this.canvasMain.style.width = 'unset'
        this.canvasMain.style.height = '100%'
      }
      console.log(containerRatio, imgRatio)
    },
    hardReset () {
      this.clickResetChannels()
      this.ctxMain.clearRect(0, 0, this.canvasMain.width, this.canvasMain.height)
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
.app-container {
  height: 100vh;
  display: grid;
  grid-template-rows: auto auto 1fr auto;
  grid-template-columns: 1fr;
}
.histograms {
  background-color: #272727 !important;
}
.adjustments {
  background-color: #272727 !important;
}
canvas {
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-crisp-edges;
  image-rendering: pixelated;
  image-rendering: crisp-edges;
  display: block;
}
#canvasContainer {
  display: grid;
  grid-template-rows: 100%;
  grid-template-columns: 100%;
  align-items: center;
  justify-items: center;
}
.work-canvas {
  object-fit: contain;
  grid-column: 1;
  grid-row: 1;
}
.work-canvas:hover {
  cursor: pointer;
}
.v-expansion-panel-header {
  min-height: unset;
  padding: 1rem 1.5rem;
}
.medidor {
  height: 0;
  width: 256px;
  display:hidden;
  padding: 0 1.5rem;
  box-sizing: content-box;
}
.gradient-track .g-red >>> .v-slider__track-container {
  background: linear-gradient(90deg, rgba(0,255,255,1) 0%, rgba(255,0,0,1) 100%);
}
.gradient-track .g-green >>> .v-slider__track-container {
  background: linear-gradient(90deg, rgba(255,0,255,1) 0%, rgba(0 ,255,0,1) 100%);
}
.gradient-track .g-blue >>> .v-slider__track-container {
  background: linear-gradient(90deg, rgba(255,255,0,1) 0%, rgba(0,0,255,1) 100%);
}
@media screen and (orientation: landscape) {
  .app-container {
    grid-template-rows: auto 1fr auto;
    grid-template-columns: auto 1fr auto;
  }
  .appbar {
    grid-column: 1 / 4;
    grid-row: 1;
  }
  .histograms {
    grid-row: 2 / 3;
    grid-column: 1 / 2;
  }
  #canvasContainer {
    grid-row: 2 / 3;
    grid-column: 2 / 3;
  }
  .adjustments {
    grid-row: 2 / 3;
    grid-column: 3 / 4;
  }
  .footer {
    grid-row: 3 / 4;
    grid-column: 1 / 4;
  }
}
</style>
<style>
</style>
