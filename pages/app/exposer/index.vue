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

        <v-btn icon color="">
          <v-icon>mdi-select-compare</v-icon>
        </v-btn>

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
      </v-app-bar>
      <!--              End top menu -->

      <!-- Histograms -->
      <v-sheet
        elevation="2"
        class="white--text justify-center justify-md-start align-center histograms"
        :class="switches.histograms ? 'd-flex flex-md-column flex-row pa-2' : 'd-one'"
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
        <div
          v-for="{value, index} in curvesHistograms"
          :key="index"
          :class="switches.debugHistograms ? 'd-flex justify-center align-center mx-1 my-2' : 'd-none'"
        >
          <canvas :ref="'curvesHistograms'" width="256" height="100" class="secondary darken-3 h-100-p w-100-p" />
          <div class="d-none">
            {{ value }}
          </div>
        </div>
        <div v-for="(value, index) in ['#D32F2F', '#388E3C', '#1976D2']" :key="index" class="d-flex justify-center align-center mx-1 my-2">
          <canvas :ref="channelControls.names[index]" width="256" height="100" class="secondary darken-2 h-100-p w-100-p" />
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
      </div>
      <!--          End Window -->

      <!-- Adjustments Sidebar -->
      <v-sheet cols="auto" class="mh-100-p d-flex flex-column justify-start adjustments px-2">
        <!-- Tabs container -->
        <div class="d-flex flex-column flex-md-column-reverse">
          <v-tabs-items v-model="adjustmentTabs" dark style="overflow: visible;" class="transparent pt-md-10">
            <!-- Spread -->
            <v-tab-item value="tab-1" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-slider
                  v-model="controls[0][0].limit"
                  dense
                  min="0"
                  max="20"
                  thumb-label="always"
                  thumb-size=""
                  hide-details=""
                  thumb-color="blue darken-3"
                  append-icon="mdi-plus"
                  prepend-icon="mdi-minus"
                  @click:append="clickAddSpreadLimit(1, 0, 20)"
                  @click:prepend="clickAddSpreadLimit(-1, 0, 20)"
                  @input="inputControl(0)"
                />
                <v-checkbox
                  v-model="controls[0][0].keepBalance"
                  label="Keep Balance"
                  color="blue"
                  hide-details
                  dense
                  @click="inputControl(0)"
                />
                <div class="d-flex justify-end pt-2">
                  <v-btn dark :disabled="!channelControlsEnabled" @click="clickResetControls(0)">
                    <v-icon left>
                      mdi-undo-variant
                    </v-icon>
                    Reset
                  </v-btn>
                </div>
              </v-col>
            </v-tab-item>
            <!--  -->

            <!-- Color -->
            <v-tab-item value="tab-2" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-col cols="12" class="pa-0">
                  <v-slider
                    v-for="(element, index) in controls[1]"
                    :key="index"
                    v-model="element.strength"
                    dense
                    min="-10"
                    max="10"
                    thumb-label="always"
                    thumb-size=""
                    :thumb-color="index === 0 ? 'red darken-3' : index === 1 ? 'green darken-3' : 'blue darken-3'"
                    append-icon="mdi-plus"
                    prepend-icon="mdi-minus"
                    @click:append="clickAddBalanceStrength(1, -10, 10)"
                    @click:prepend="clickAddBalanceStrength(-1, -10, 10)"
                    @input="inputControl(1)"
                  />
                </v-col>
                <div class="d-flex justify-end pt-2">
                  <v-btn dark :disabled="!channelControlsEnabled" @click="clickResetControls(1)">
                    <v-icon left>
                      mdi-undo-variant
                    </v-icon>
                    Reset
                  </v-btn>
                </div>
              </v-col>
            </v-tab-item>
            <!--  -->

            <!-- Brightness -->
            <v-tab-item value="tab-3" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-slider
                  v-model="controls[2][0].newCenter"
                  dense
                  min="-32"
                  max="32"
                  thumb-label="always"
                  thumb-size=""
                  hide-details=""
                  thumb-color="blue darken-3"
                  append-icon="mdi-plus"
                  prepend-icon="mdi-minus"
                  @click:append="clickAddMidShift(1, -32, 32)"
                  @click:prepend="clickAddMidShift(-1, -32, 32)"
                  @input="inputControl(2)"
                />
                <div class="d-flex justify-end pt-2">
                  <v-btn dark :disabled="!channelControlsEnabled" @click="clickResetControls(2)">
                    <v-icon left>
                      mdi-undo-variant
                    </v-icon>
                    Reset
                  </v-btn>
                </div>
              </v-col>
            </v-tab-item>
            <!--  -->

            <!--  -->
          </v-tabs-items>

          <v-tabs
            v-model="adjustmentTabs"
            background-color="transparent"
            centered
            icons-and-text
            dark
            height=""
            :vertical="!$vuetify.breakpoint.mobile"
          >
            <!-- <v-tabs-slider /> -->
            <v-tab href="#tab-1" :disabled="!imageLoaded">
              Clip
              <v-icon>mdi-chart-bar</v-icon>
            </v-tab>
            <v-tab href="#tab-2" :disabled="!imageLoaded">
              Balance
              <v-icon>mdi-palette</v-icon>
            </v-tab>
            <v-tab href="#tab-3" :disabled="!imageLoaded">
              Light
              <v-icon>mdi-lightbulb-on</v-icon>
            </v-tab>
            <v-tab href="#tab-4" :disabled="!imageLoaded">
              Color
              <v-icon>mdi-lightbulb-on</v-icon>
            </v-tab>
          </v-tabs>
        </div>
      </v-sheet>
      <!--  -->

      <v-footer class="footer d-none d-md-block" dark elevation="6">
        <span class="green--text text--accent-3">
          {{ UIMessage }}
        </span>
        <span class="">
          {{ parseInt(UIValue) }}
        </span>
        <span class="green--text text--accent-3">
          ms
        </span>
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
        histograms: true,
        debugHistograms: false
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
      histograms: [],
      histogramsLevels: {
        black: [0, 0, 0],
        white: [0, 0, 0]
      },
      histogramRGB: null,
      canvasMain: null,
      ctxMain: null,
      views: [],
      counts: [],
      displayCounts: [],
      channelControls: {
        titles: ['Red', 'Green', 'Blue'],
        names: ['histR', 'histG', 'histB', 'histCurves'],
        blackCount: [0, 0, 0],
        whiteCount: [0, 0, 0]
      },
      controls: [
        [
          { limit: 0, keepBalance: false }
        ],
        [
          { strength: 0 }, { strength: 0 }, { strength: 0 }
        ],
        [
          { newCenter: 0 }
        ]
      ],
      lastControls: [
        [
          { limit: 0, keepBalance: false }
        ],
        [
          { strength: 0 }, { strength: 0 }, { strength: 0 }
        ],
        [
          { newCenter: 0 }
        ]
      ],
      UIMessage: 'Debug: ',
      UIValue: 0,
      wasmHistogram: null,
      curvesHistograms: []
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
      return this.imageLoaded
    },
    portrait () {
      if (process.window) {
        return screen.orientation.type === 'portrait-primary'
      } else {
        return true
      }
    }
  },
  mounted () {
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
    // this.initializeCurves()
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
      this.drawCurves()
    },
    loadImage () {
      if (this.$refs.imageInput.files.length === 0) {
        return
      }
      const file = this.$refs.imageInput.files[0]
      this.documentName = file.name
      const img = new Image()
      img.src = URL.createObjectURL(file)

      img.onload = async () => {
        if (this.canvasMain.width > 0) {
          this.hardReset()
        }
        const startTime = performance.now()

        this.canvasMain.width = img.naturalWidth
        this.canvasMain.height = img.naturalHeight
        this.width = img.naturalWidth
        this.height = img.naturalHeight
        this.canvasContainerResize()
        this.ctxMain.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        this.imageData = this.ctxMain.getImageData(0, 0, this.canvasMain.width, this.canvasMain.height)
        console.log('Image Loaded. width:', this.width, 'height:', this.height, 'total pixels:', this.width * this.height)

        const bytesPerPage = 64 * 1024 // 65.536
        const channelLength = this.width * this.height
        const viewLength = channelLength * 4
        // const bytesNeeded = (channelLength * 4 * 2) + (256 * 4 * 3) + (256 * 6)
        const pagesNeeded = Math.ceil(2560000000 / bytesPerPage) + 1

        const memory = new WebAssembly.Memory({
          initial: pagesNeeded
        })
        const importObject = {
          env: {
            abort: (_msg, _file, line, column) =>
              console.error(`Error at ${line}:${column}`),
            memory
          },
          index: {
            consoleFloat: value => console.log(value),
            consoleLog: value => console.log(value)
          }
        }
        this.wasmHistogram = await WebAssembly.instantiateStreaming(fetch('/wasm/optimized.wasm'), importObject)
        const exports = this.wasmHistogram.instance.exports
        const buffer = memory.buffer
        // [original]
        // [percentile]
        // [grayWorld]
        // [B]
        let arrayOffset = 0
        const totalViews = 4
        for (let i = 0; i < totalViews; i++) {
          this.views[i] = new Uint8ClampedArray(buffer, arrayOffset, viewLength)
          arrayOffset += viewLength
        }

        for (let i = 0; i < totalViews; i++) {
          this.counts[i] = Array(3)
          for (let c = 0; c < 3; c++) {
            this.counts[i][c] = new Uint32Array(buffer, arrayOffset, 256)
            arrayOffset += 256 * 4
          }
        }
        for (let i = 0; i < totalViews; i++) {
          this.displayCounts[i] = Array(3)
          for (let c = 0; c < 3; c++) {
            this.displayCounts[i][c] = new Uint8ClampedArray(buffer, arrayOffset, 256)
            arrayOffset += 256
          }
        }
        this.views[0].set(this.imageData.data)
        this.views[1].set(this.imageData.data)
        this.views[2].set(this.imageData.data)
        this.views[3].set(this.imageData.data)
        exports.initData(this.width, this.height, totalViews)
        exports.calculateCounts(0)
        exports.calculateDisplayCounts(0)

        const endTime = performance.now()
        this.UIMessage = 'Load time'
        this.UIValue = endTime - startTime
        this.debugMemory()

        this.updateHistograms(0)
        this.imageLoaded = true
      }
    },
    // Levels
    process () {
      // Spread
      const limitValue = this.controls[0][0].limit - 1
      const lastLimitValue = this.lastControls[0][0].limit - 1
      const keepBalance = this.controls[0][0].keepBalance
      const lastKeepBalance = this.lastControls[0][0].keepBalance
      const limit = Math.ceil((this.width * this.height * 0.0001) * limitValue * (keepBalance ? 4 : 2))

      // Balance
      const balanceStrength = this.controls[1][0].strength
      const lastBalanceStrength = this.lastControls[1][0].strength

      // Center Shift
      const newCenter = this.controls[2][0].newCenter
      const lastNewCenter = this.lastControls[2][0].newCenter

      const spreadDefault = (limitValue === -1) && (keepBalance === false)
      const balanceDefault = (balanceStrength === 0)
      const centerShiftDefault = (newCenter === 0)

      const runPercentileStretch = (limitValue !== lastLimitValue) || (keepBalance !== lastKeepBalance)
      const runGrayWorld = (balanceStrength !== lastBalanceStrength) || (runPercentileStretch && !balanceDefault)
      const runCenterShift = (newCenter !== lastNewCenter) || ((runPercentileStretch || runGrayWorld) && !centerShiftDefault)

      let displayIndex = 0

      if (runCenterShift) {
        displayIndex = 3
      } else if (!balanceDefault) {
        displayIndex = 2
      } else if (!spreadDefault) {
        displayIndex = 1
      }

      console.log({ runPercentileStretch }, { runGrayWorld }, { runCenterShift })

      const startTime = performance.now()

      this.wasmHistogram.instance.exports.process(
        runPercentileStretch, runGrayWorld, runCenterShift,
        keepBalance, limit, limitValue,
        balanceStrength,
        newCenter)

      const endTime = performance.now()

      this.UIMessage = 'Process time: '
      this.UIValue = endTime - startTime
      this.debugMemory()

      // Assign Last values
      this.lastControls[0][0].limit = this.controls[0][0].limit
      this.lastControls[0][0].keepBalance = this.controls[0][0].keepBalance

      this.lastControls[1][0].strength = this.controls[1][0].strength

      this.lastControls[2][0].newCenter = this.controls[2][0].newCenter

      this.updateCanvas(displayIndex)
      this.updateHistograms(displayIndex)
    },
    clickResetControls (index) {
      const controls = this.controls[index]
      if (index === 0) {
        controls[0].limit = 0
        controls[0].keepBalance = false
      } else if (index === 1) {
        controls.forEach((element) => {
          element.strength = 0
        })
      } else if (index === 2) {
        controls[0].newCenter = 0
      }
      this.inputControl()
    },
    updateCanvas (index) {
      this.imageData.data.set(this.views[index])
      this.ctxMain.putImageData(this.imageData, 0, 0)
    },
    updateHistograms (index) {
      // const histdata = histogram.getHistograms(this.view8)
      // for (let i = 0, j = 0; i < 3; i++, j += 2) {
      //   this.channelControls.blackCount[i] = histdata[3][j]
      //   this.channelControls.whiteCount[i] = histdata[3][j + 1]
      // }

      for (let i = 0; i < 3; i++) {
        this.histograms[i].clearRect(0, 0, 256, 100)
        // this.histogramsLevels.black[i] = histdata[i][0]
        // this.histogramsLevels.white[i] = histdata[i][255]
        histogram.drawHistogram(this.histograms[i], this.displayCounts[index][i])
      }

      // this.histogramRGB.clearRect(0, 0, 256, 100)
      // histogram.drawRGB(this.histogramRGB, histdata[0], histdata[1], histdata[2])
    },
    inputControl (index) {
      this.process()
    },
    // Levels
    clickAddSpreadLimit (amount, min, max) {
      const old = this.controls[0].limit
      if (((amount < 0) && (old + amount >= min)) || ((amount > 0) && (old + amount <= max))) {
        this.controls[0].limit += amount
        this.inputControl(0)
      }
    },
    clickAddBalanceStrength (amount, min, max) {
      const old = this.controls[1].strength
      if (((amount < 0) && (old + amount >= min)) || ((amount > 0) && (old + amount <= max))) {
        this.controls[1].strength += amount
        this.inputControl(1)
      }
    },
    clickAddMidShift (amount, min, max) {
      const old = this.controls[2].newCenter
      if (((amount < 0) && (old + amount >= min)) || ((amount > 0) && (old + amount <= max))) {
        this.controls[2].newCenter += amount
        this.inputControl(2)
      }
    },
    initializeCurves () {
      const zeroArray = (size) => {
        const zeroes = Array(size)
        for (let i = 0; i < size; i++) {
          zeroes[i] = 0
        }
        return zeroes
      }
      const line = (from, to) => {
        const factors = Array(256)
        for (let i = 0; i < 256; i++) {
          factors[i] = 0
        }
        if (from < to) {
          const f = 1 / (to - from)
          for (let i = from, c = 0; i < to; i++, c++) {
            factors[i] = c * f
          }
        } else {
          const f = 1 / (from - to)
          for (let i = from, c = 0; i >= to; i--, c++) {
            factors[i] = c * f
          }
        }
        return factors
      }
      const curveExpUp = (from, to) => {
        const factors = zeroArray()
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 0, x = 0; i <= 255; i++, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = 1 - y
        }
        return factors
      }
      const curveExpDown = (from, to) => {
        const factors = zeroArray(256)
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 255, x = 0; i >= 0; i--, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = 1 - y
        }
        return factors
      }
      const curveRootUp = (from, to) => {
        const factors = zeroArray(256)
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 0, x = -1; i <= 255; i++, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
        }
        return factors
      }
      const curveRootDown = (from, to) => {
        const factors = zeroArray(256)
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 255, x = -1; i >= 0; i--, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
        }
        return factors
      }
      const curveRootUpMid = (from, to) => {
        const factors = zeroArray(256)
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 0, x = -1; i <= 255; i++, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y / 2 + 0.5
        }
        return factors
      }
      const curveRootDownMid = (from, to) => {
        const factors = zeroArray(256)
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 255, x = -1; i >= 0; i--, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y / 2 + 0.5
        }
        return factors
      }
      const curveSphereFull = (center = 128) => {
        const factors = zeroArray(256)
        let xFactor = 1 / (center)
        const radius = 1
        for (let i = 0, x = 0; i <= center; i++, x += xFactor) {
          const y = 1 - Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
          // factors[i] = Math.pow(y, 2).toFixed(10)
        }

        xFactor = 1 / (255 - center + 1)
        for (let i = 255, x = 0; i >= center; i--, x += xFactor) {
          const y = 1 - Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
          // factors[i] = Math.pow(y, 2).toFixed(10)
        }
        return factors
      }
      const curvePowFull = (center = 128, exponent = 2) => {
        const factors = zeroArray(256)
        let xFactor = 1 / center
        let x = 0
        for (let i = 0; i <= center; i++) {
          const y = Math.pow(x, exponent)
          factors[i] = y
          x += xFactor
        }
        xFactor = 1 / (255 - center)
        x = 0
        for (let i = 255; i >= center; i--) {
          const y = Math.pow(x, exponent)
          factors[i] = y
          x += xFactor
        }
        return factors
      }
      const curveSinFull = (center = 128) => {
        const factors = zeroArray(256)
        let degree = 0
        let radian = 0
        let angleFactor = 90 / center
        for (let i = 0; i <= center; i++) {
          radian = util.degrees_to_radians(degree)
          const y = Math.sin(radian)
          factors[i] = y
          degree += angleFactor
        }
        angleFactor = 90 / (255 - center)
        degree = 0
        for (let i = 255; i >= center; i--) {
          radian = util.degrees_to_radians(degree)
          const y = Math.sin(radian)
          factors[i] = y
          degree += angleFactor
        }
        return factors
      }
      const blob = (center = 128, exponent = 4) => {
        const factors = zeroArray(256)
        const radius = 1
        let xFactor = 1 / center
        let x = -1
        for (let i = 0; i <= center; i++) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
          x += xFactor
        }
        xFactor = 1 / (255 - center)
        x = -1
        for (let i = 255; i >= center; i--) {
          const y = Math.sqrt(Math.pow(radius, 2) - Math.pow(x, 2))
          factors[i] = y
          x += xFactor
        }
        return factors
      }
      // util.exportArray(data)
      this.curvesHistograms = [
        // line(0, 256),
        // line(256, 0),
        // curveExpUp(),
        // curveExpDown(),
        // curveRootUp(),
        // curveRootDown(),
        // curveRootUpMid(),
        // curveRootDownMid(),
        blob(64),
        blob(128),
        curvePowFull(32, 2),
        curveSinFull(32)
        // curveSphereFull(64),
        // curveSphereFull(192)
      ]
    },
    drawCurves () {
      this.switches.debugHistograms = true
      const canvases = this.$refs.curvesHistograms
      for (let i = 0; i < canvases.length; i++) {
        const ctx = canvases[i].getContext('2d')
        ctx.imageSmoothingEnabled = false
        ctx.strokeStyle = 'lightgrey'
        ctx.clearRect(0, 0, 256, 100)
        const data = Array(256)
        for (let j = 0; j < 256; j++) {
          data[j] = this.curvesHistograms[i][j] * 100
        }
        histogram.drawHistogram(ctx, data)
      }
      console.log(this.curvesHistograms)
      util.exportArray(this.curvesHistograms[3])
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
      // console.log(containerRatio, imgRatio)
    },
    hardReset () {
      // this.ctxMain.clearRect(0, 0, this.canvasMain.width, this.canvasMain.height)
    },
    debugArray (array, length) {
      const text = []
      for (let i = 0; i < length; i++) {
        text[i] = array[i]
      }
      console.log(text)
    },
    debugMemory () {
      console.log('Views:')
      console.log(this.views)
      console.log('Counts')
      console.log(this.counts)
      console.log('Display Counts')
      console.log(this.displayCounts)
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
