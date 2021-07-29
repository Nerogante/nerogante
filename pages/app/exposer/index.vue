<template>
  <!-- App container -->
  <v-row no-gutters class="h-100-v grey darken-4">
    <!-- Left Side -->
    <v-col class="full-height">
      <!-- Hidden inputs -->
      <input v-show="false" ref="imageInput" type="file" accepts="image/*" @change="loadImage">
      <!-- Top menu -->
      <v-sheet class="d-flex" color="transparent">
        <div class="mx-10" />
        <v-menu v-for="(menu, index) of menus" :key="index" offset-y tile>
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
        </v-menu>
      </v-sheet>
      <!-- End top menu -->

      <!-- Working area and sidebar -->
      <v-row no-gutters class="h-95-p full-width" dense justify="center" align="stretch">
        <!-- Histograms -->
        <v-col cols="auto" class="pa-5 mt-0 white--text" align-self="center">
          <template v-for="(value, index) in ['#D32F2F', '#388E3C', '#1976D2']">
            <v-col :key="index" cols="auto" class="px-0 pt-0">
              <h6 class="text-caption">
                {{ channelControls.titles[index] }}
              </h6>
              <v-col sm="auto" class="pa-0">
                <div
                  :style="{
                    width: histogramsLevels.black[index] + '%',
                    height: '.5rem',
                    backgroundColor: value
                  }"
                />
                <canvas :ref="channelControls.names[index]" width="256" height="100" class="secondary darken-2" />
                <div
                  :style="{
                    width: histogramsLevels.white[index] + '%',
                    height: '.5rem',
                    backgroundColor: value
                  }"
                />
                <!-- <v-range-slider
                  v-model="channelControls.spreadClip[index].value"
                  min="0"
                  max="255"
                  thumb-color="blue"
                  thumb-label=""
                  hide-details
                  height="1rem"
                  @input="changeSliderClip(index)"
                /> -->
              </v-col>
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
            </v-col>
          </template>
        </v-col>
        <!-- Window -->
        <v-col class="full-height purple">
          <div id="viewportContainer" sm="" class="grey darken-4 h-100-p d-flex justify-center align-center overflow-scroll pa-4" @wheel="viewportZoom">
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
        </v-col>
      </v-row>
      <!-- Info Bar -->
      <!-- <v-row no-gutters justify="space-between" align="center" class="white--text h-4-p ma-0 pa-0">
        <v-col sm="auto">
          <div class="text-caption">
            {{ width }} x {{ height }} pixels
          </div>
        </v-col>
        <v-col sm="auto">
          <div class="text-caption">
            Zoom: {{ zoomPercent }}
          </div>
        </v-col>
      </v-row> -->
      <!--  -->
    </v-col>
    <!--  -->
    <!-- Right Window Sidebar -->
    <v-col v-show="sidebarOpen" cols="auto" class="full-height secondary px-3">
      <div class="d-flex flex-column full-height">
        <v-row no-gutters justify="center" class="py-3 pr-3">
          <v-col cols="" class="">
            <canvas ref="histogramRGB" width="256" height="100" class="grey darken-4 w-100-p" />
          </v-col>
        </v-row>
        <!-- Adjustments -->
        <v-row no-gutters class="full-height pb-3 overflow-y-scroll scrollbar-dense" justify="center" align="stretch">
          <v-col cols="auto" class="">
            <div class="medidor" />
            <!-- Hidden expander -->
            <v-expansion-panels
              dark
              hover
              accordion
              multiple
              :disabled="!channelControlsEnabled"
              class="d-block"
            >
              <!-- Channel Spread -->
              <v-expansion-panel>
                <v-expansion-panel-header color="secondary darken-1">
                  Levels
                </v-expansion-panel-header>
                <v-expansion-panel-content eager color="secondary" class="pt-3">
                  <v-row no-gutters justify="center">
                    <v-col cols="">
                      <v-col cols="12" class="px-0">
                        <v-slider
                          v-model="controls.levels.limit"
                          dense
                          min="0"
                          max="20"
                          thumb-label="always"
                          :thumb-size="24"
                          thumb-color="deep-orange darken-1"
                          hint="Level Limit"
                          persistent-hint
                          append-icon="mdi-plus"
                          prepend-icon="mdi-minus"
                          @click:append="clickAddlevelsLimit(1)"
                          @click:prepend="clickAddlevelsLimit(-1)"
                          @input="inputLevels()"
                        />
                        <v-switch
                          v-model="controls.levels.keepBalance"
                          label="Keep Balance"
                          hide-details
                          dense
                          @click="inputLevels()"
                        />
                      </v-col>
                    </v-col>
                  </v-row>
                  <div class="d-flex justify-end">
                    <!-- <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickAutoChannels">
                      auto
                    </v-btn> -->
                    <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="resetLevels()">
                      reset
                    </v-btn>
                  </div>
                </v-expansion-panel-content>
              </v-expansion-panel>
              <!--  -->
              <!-- Color Balance -->
              <v-expansion-panel>
                <v-expansion-panel-header color="secondary darken-1">
                  Color Balance
                </v-expansion-panel-header>
                <v-expansion-panel-content eager color="secondary" class="pt-3">
                  <div class="d-flex justify-space-between">
                    <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickAutoBalance">
                      auto
                    </v-btn>
                    <v-btn tile small color="secondary" :disabled="!channelControlsEnabled" @click="clickResetColorBalance">
                      reset
                    </v-btn>
                  </div>
                  <v-row no-gutters>
                    <v-col class="gradient-track">
                      <template v-for="(color, index) in ['red', 'green', 'blue']">
                        <v-col :key="index" cols="12" :class="'px-0 g-' + color">
                          <h6 class="text-caption">
                            {{ channelControls.titles[index] }}
                          </h6>
                          <v-slider
                            v-model="colorBalanceControls.colorBalance[index].value"
                            min="-128"
                            max="128"
                            thumb-color="grey"
                            thumb-label=""
                            hide-details
                            height="1rem"
                            color="transparent"
                            @input="changeSliderColorBalance(index)"
                          />
                        </v-col>
                      </template>
                    </v-col>
                  </v-row>
                </v-expansion-panel-content>
              </v-expansion-panel>
              <!--  -->
              <!-- Intensity -->
              <v-expansion-panel>
                <v-expansion-panel-header color="secondary darken-1">
                  Intensity
                </v-expansion-panel-header>
                <v-expansion-panel-content eager color="secondary" class="pt-3">
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

                      <v-col cols="12" class="px-0">
                        <h6 class="text-caption">
                          HE
                        </h6>
                        <v-slider
                          v-model="controls.levels.adaptativeSpread.value"
                          min="0"
                          max="100"
                          thumb-color="grey"
                          thumb-label=""
                          hide-details
                          height="1rem"
                          color=""
                          @input="changeSliderIntensity(0)"
                        />
                      </v-col>
                    </v-col>
                  </v-row>
                </v-expansion-panel-content>
              </v-expansion-panel>
              <!--  -->
            </v-expansion-panels>
          </v-col>
        </v-row>
      </div>
    </v-col>
  <!--  -->
  </v-row>
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
              title: 'Open',
              icon: 'mdi-plus',
              click: this.clickOpenImage
            },
            {
              title: 'Export',
              icon: 'mdi-file-export',
              click: () => {
                console.log(this.originalData)
                console.log(this.tempData)
              }
            },
            {
              title: 'Close',
              icon: 'mdi-exit-to-app',
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
        levels: {
          keepBalance: false,
          limit: 0,
          adaptativeSpread: {
            value: 0
          }
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
        this.imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
        this.originalChannels = histogram.separateChannels(this.imageData.data)
        this.checkPoints[0] = this.originalChannels.map(chan => new Uint8ClampedArray(chan))
        this.checkPoints[1] = this.originalChannels.map(chan => new Uint8ClampedArray(chan))
        this.finalView8 = this.imageData.data
        this.finalView32 = new Uint32Array(this.finalView8.buffer)
        this.previewView8 = new Uint8ClampedArray(this.imageData.data)
        this.previewView32 = new Uint32Array(this.previewView8.buffer)
        this.originalCounts = this.originalChannels.map(chan => histogram.getCount(chan))
        this.updateHistograms()
      }
    },
    // Levels
    previewLevels () {
      const levelsLimit = this.controls.levels.limit - 1
      const keepBalance = this.controls.levels.keepBalance
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
    applyLevels () {

    },
    resetLevels () {

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
    inputLevels (value) {
      // const limit = Math.round(this.width * this.height * 0.001)
      // for (let i = 0; i < 3; i++) {
      //   this.channelControls.spreadClip[i].value = histogram.getAutoClips(this.originalChannels[i], limit)
      // }
      this.previewLevels()
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
    clickAddlevelsLimit (amount) {
      this.controls.levels.limit += amount
      this.inputLevels()
    },
    clickAutoChannels () {

    },
    clickAutoBalance () {

    },
    clickAutoIntensity () {

    },
    clickResetChannels () {
      for (let i = 0; i < 3; i++) {
        this.channelControls.spreadClip[i].value = [0, 255]
      }
      this.onValueChangeChannel()
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
      if (e.altKey) {
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
      }
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
#viewportContainer::-webkit-scrollbar {
  width: auto;
}
#viewportContainer::-webkit-scrollbar-track {
  background: hsl(0, 0%, 20%);
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
</style>
<style>
</style>
