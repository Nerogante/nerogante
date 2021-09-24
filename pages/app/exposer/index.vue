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

        <v-btn icon color="" @click="runBenchmarkLight">
          <v-icon>mdi-console</v-icon>
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
      <v-sheet cols="auto" class="mh-100-p adjustments pt-5">
        <!-- Tabs container -->
        <div class="d-flex flex-column flex-md-row">
          <v-tabs-items v-model="adjustmentTabs" dark style="overflow: visible; min-width:256px" class="transparent pt-md-10">
            <!-- Spread -->
            <v-tab-item value="tab-1" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12" class="">
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

            <!-- Temp -->
            <v-tab-item value="tab-2" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12" class="">
                <v-col cols="12" class="pa-0 temperature">
                  <v-slider
                    v-for="(element, index) in controls[1]"
                    :key="index"
                    v-model="element.strength"
                    :class="['gradient-red', 'gradient-green'][index]"
                    dense
                    color="transparent"
                    min="-256"
                    max="256"
                    thumb-label="always"
                    thumb-size=""
                    :thumb-color="['red darken-3', 'green darken-3', 'grey darken-2'][index]"
                    append-icon="mdi-plus"
                    prepend-icon="mdi-minus"
                    @click:append="clickAddBalanceStrength(1, -256, 256)"
                    @click:prepend="clickAddBalanceStrength(-1, -256, 256)"
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

            <!-- Light -->
            <v-tab-item value="tab-3" :transition="tabsTransition" :reverse-transition="tabsTransition" eager>
              <v-col cols="12">
                <v-col cols="12" class="pa-0">
                  <v-slider
                    v-for="(element, index) in controls[2]"
                    :key="index"
                    v-model="element.value"
                    :vertical="false"
                    dense
                    min="-100"
                    max="100"
                    thumb-label="always"
                    thumb-size=""
                    :hide-details="false"
                    :color="['grey', 'white', 'black'][index]"
                    thumb-color="blue darken-3"
                    append-icon="mdi-plus"
                    prepend-icon="mdi-minus"
                    @click:append="clickAddMidShift(1, -100, 100)"
                    @click:prepend="clickAddMidShift(-1, -100, 100)"
                    @input="inputControl(2)"
                  />
                </v-col>
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
            icons-and-text
            dark
            height=""
            :centered="$vuetify.breakpoint.mobile"
            :vertical="!$vuetify.breakpoint.mobile"
            color="green accent-3"
            active-class="green--text text--accent-1"
          >
            <!-- <v-tabs-slider /> -->
            <v-tab href="#tab-1" class="" :disabled="!imageLoaded">
              Clip
              <v-icon :color="clipDefault ? 'grey' : 'green accent-3'">
                mdi-chart-bar
              </v-icon>
            </v-tab>
            <v-tab href="#tab-2" class="" :disabled="!imageLoaded">
              Temp
              <v-icon :color="tempDefault ? 'grey' : 'green accent-3'">
                mdi-thermometer
              </v-icon>
            </v-tab>
            <v-tab href="#tab-3" :disabled="!imageLoaded">
              Light
              <v-icon :color="lightDefault ? 'grey' : 'green accent-3'">
                mdi-tune
              </v-icon>
            </v-tab>
            <v-tab href="#tab-4" :disabled="!imageLoaded">
              Color
              <v-icon>mdi-palette</v-icon>
            </v-tab>
          </v-tabs>
        </div>
      </v-sheet>
      <!--  -->

      <v-footer class="footer d-none d-md-flex justify-space-between" dark elevation="6">
        <div>
          <span class="green--text text--accent-3">
            Average Time:
          </span>
          <span class="">
            {{ averageProcess }}
          </span>
          <span class="green--text text--accent-3">
            {{ UIMessage }}
          </span>
          <span class="">
            {{ parseInt(UIValue) }}
          </span>
        </div>
        <div>
          <span class="green--text text--accent-3">
            Width:
          </span>
          <span>
            {{width}}
          </span>
          <span class="green--text text--accent-3">
            Height:
          </span>
          <span>
            {{height}}
          </span>
        </div>
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
      tabsTransition: 'none',
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
          { strength: 0 }, { strength: 0 }
        ],
        [
          { value: 0 }, { value: 0 }, { value: 0 }
        ]
      ],
      lastControls: [
        [
          { limit: 0, keepBalance: false }
        ],
        [
          { strength: 0 }, { strength: 0 }
        ],
        [
          { value: 0 }, { value: 0 }, { value: 0 }
        ]
      ],
      UIMessage: 'Debug: ',
      UIValue: 0,
      totalRuns: 0,
      runSum: 0,
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
    averageProcess () {
      return (this.runSum / this.totalRuns || 0).toFixed()
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
    },
    clipDefault () {
      return this.controls[0][0].limit === 0 && !this.controls[0][0].keepBalance
    },
    tempDefault () {
      return this.controls[1][0].strength === 0 && this.controls[1][1].strength === 0
    },
    lightDefault () {
      return this.controls[2][0].value === 0 && this.controls[2][1].value === 0 && this.controls[2][2].value === 0
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
    this.initializeCurves()
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
    async runBenchmarkLight () {
      const caca = async () => {
        for (let i = -100; i <= 100; i += 10) {
          this.controls[2][0].value = i
          await this.inputControl()
          await timeout(0)
        }
      }
      const timeout = (ms) => {
        return new Promise(resolve => setTimeout(resolve, ms))
      }
      await caca()
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
      // Clip
      const limitValue = this.controls[0][0].limit - 1
      const lastLimitValue = this.lastControls[0][0].limit - 1
      const keepBalance = this.controls[0][0].keepBalance
      const lastKeepBalance = this.lastControls[0][0].keepBalance
      const limit = Math.ceil((this.width * this.height * 0.0001) * limitValue * (keepBalance ? 4 : 2))

      // Temp
      const balanceR = this.controls[1][0].strength
      const balanceG = this.controls[1][1].strength
      const lastBalanceR = this.lastControls[1][0].strength
      const lastBalanceG = this.lastControls[1][1].strength

      // Light
      const midAmount = this.controls[2][0].value
      const lastMidAmount = this.lastControls[2][0].value
      const shadowAmount = this.controls[2][1].value
      const lastShadowAmount = this.lastControls[2][1].value
      const highlightAmount = this.controls[2][2].value
      const lastHighlightAmount = this.lastControls[2][2].value

      const runPercentileStretch = (limitValue !== lastLimitValue) || (keepBalance !== lastKeepBalance)
      const runColorBalance = (balanceR !== lastBalanceR || balanceG !== lastBalanceG) || (runPercentileStretch && !this.tempDefault)
      const runLight = (midAmount !== lastMidAmount || shadowAmount !== lastShadowAmount || highlightAmount !== lastHighlightAmount) || ((runPercentileStretch || runColorBalance) && !this.lightDefault)

      let displayIndex = 0

      if (runLight) {
        displayIndex = 3
      } else if (!this.tempDefault) {
        displayIndex = 2
      } else if (!this.clipDefault) {
        displayIndex = 1
      }

      console.log({ runPercentileStretch }, { runColorBalance }, { runLight })

      const startTime = performance.now()

      this.wasmHistogram.instance.exports.process(
        runPercentileStretch, runColorBalance, runLight,
        keepBalance, limit, limitValue,
        balanceR, balanceG,
        midAmount, shadowAmount, highlightAmount)
      this.wasmHistogram.instance.exports.__collect()

      const endTime = performance.now()

      this.UIMessage = 'Process time: '
      this.UIValue = endTime - startTime

      if (runPercentileStretch || runColorBalance || runLight) {
        this.totalRuns++
        this.runSum += endTime - startTime
      }
      this.debugMemory()

      // Assign Last values
      this.lastControls[0][0].limit = this.controls[0][0].limit
      this.lastControls[0][0].keepBalance = this.controls[0][0].keepBalance

      this.lastControls[1][0].strength = this.controls[1][0].strength
      this.lastControls[1][1].strength = this.controls[1][1].strength

      this.lastControls[2][0].value = this.controls[2][0].value
      this.lastControls[2][1].value = this.controls[2][1].value
      this.lastControls[2][2].value = this.controls[2][2].value

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
        controls.forEach((element) => {
          element.value = 0
        })
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
      const curveExpUp = (exp = 2, flipX = false, flipY = false) => {
        const factors = zeroArray()
        const radius = 1
        const xFactor = 1 / 255
        for (let i = 0, x = 0; i <= 255; i++, x += xFactor) {
          const y = Math.sqrt(Math.pow(radius, exp) - Math.pow(x, exp))
          factors[flipX ? (255 - i) : i] = flipY ? y : 1 - y
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
      const curveSinFull = (min = 0) => {
        const factors = zeroArray(256)
        for (let i = 0; i < 128; i++) {
          const y = Math.sin((i) * (1 / 256) * Math.PI) * (1 - min) + min
          factors[i] = y.toFixed(25)
          factors[255 - i] = y.toFixed(25)
        }
        return factors
      }
      const curveCamel = () => {
        const factors = zeroArray(256)
        for (let i = 0; i < 256; i++) {
          const y = Math.pow(Math.sin((i) / 255 * Math.PI * 2), 2).toFixed(25)
          factors[i] = y
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
      const lineUp = (from = 0, to = 255, min = 0, max = 1) => {
        const factors = zeroArray(256)
        const lineFactor = (1 - min) / (255)
        let currentScale = 0
        for (let i = from; i <= to; i++) {
          factors[i] = currentScale * lineFactor + min
          currentScale++
        }
        return factors
      }
      const lineDown = (from = 255, to = 0, min = 0, max = 1) => {
        const factors = zeroArray(256)
        const lineFactor = (1 - min) / (255)
        let currentScale = 0
        for (let i = from; i >= to; i--) {
          factors[i] = currentScale * lineFactor + min
          currentScale++
        }
        return factors
      }
      const curveSinUp = (flipX = false, flipY = false) => {
        const factors = zeroArray(256)
        let degree = 0
        let radian = 0
        const angleFactor = 90 / 255
        for (let i = 0; i <= 255; i++) {
          radian = util.degrees_to_radians(degree)
          const y = Math.sin(radian)
          factors[flipX ? (255 - i) : i] = flipY ? (1 - y) : y
          degree += angleFactor
        }
        return factors
      }
      const logUp = (offset = 1) => {
        const factors = zeroArray(256)
        for (let i = 0; i < 256; i++) {
          factors[i] = Math.log10(i + offset) / Math.log10(255 + offset)
        }
        return factors
      }
      const logDown = (offset = 1) => {
        const factors = zeroArray(256)
        for (let i = 0; i < 256; i++) {
          factors[255 - i] = Math.log10(i + offset) / Math.log10(255 + offset)
        }
        return factors
      }
      const midUp = () => {
        const factors = zeroArray(256)
        let y = 0
        for (let i = 0; i < 256; i++) {
          y = Math.sin(i / 255 * Math.PI * 1.5) / 2 + 0.5
          factors[i] = y
        }
        return factors
      }
      // util.exportArray(data)
      this.curvesHistograms = [
        curveSinFull(0),
        curveSinFull(0.25),
        curveSinFull(0.5)
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
        // const data = [0, 0.012271538285719925, 0.024541228522912288, 0.03680722294135883, 0.049067674327418015, 0.06132073630220858, 0.07356456359966743, 0.0857973123444399, 0.0980171403295606, 0.11022220729388306, 0.1224106751992162, 0.1345807085071262, 0.14673047445536175, 0.15885814333386145, 0.17096188876030122, 0.18303988795514098, 0.19509032201612825, 0.20711137619221856, 0.2191012401568698, 0.23105810828067114, 0.24298017990326387, 0.25486565960451457, 0.2667127574748984, 0.27851968938505306, 0.29028467725446233, 0.3020059493192281, 0.3136817403988915, 0.3253102921622629, 0.33688985339222005, 0.34841868024943456, 0.35989503653498817, 0.3713171939518375, 0.3826834323650898, 0.3939920400610481, 0.40524131400498986, 0.41642956009763715, 0.4275550934302821, 0.43861623853852766, 0.4496113296546066, 0.46053871095824, 0.47139673682599764, 0.4821837720791227, 0.49289819222978404, 0.5035383837257176, 0.5141027441932218, 0.524589682678469, 0.5349976198870972, 0.5453249884220465, 0.5555702330196022, 0.5657318107836131, 0.5758081914178453, 0.5857978574564389, 0.5956993044924334, 0.6055110414043255, 0.6152315905806268, 0.6248594881423863, 0.6343932841636455, 0.6438315428897915, 0.6531728429537768, 0.6624157775901718, 0.6715589548470184, 0.680600997795453, 0.6895405447370668, 0.6983762494089729, 0.7071067811865475, 0.7157308252838187, 0.7242470829514669, 0.7326542716724128, 0.7409511253549591, 0.7491363945234593, 0.7572088465064846, 0.765167265622459, 0.7730104533627369, 0.7807372285720945, 0.7883464276266062, 0.7958369046088836, 0.8032075314806449, 0.8104571982525948, 0.8175848131515837, 0.8245893027850253, 0.8314696123025452, 0.8382247055548381, 0.844853565249707, 0.8513551931052652, 0.8577286100002721, 0.8639728561215867, 0.8700869911087113, 0.8760700941954066, 0.881921264348355, 0.8876396204028539, 0.8932243011955153, 0.8986744656939538, 0.9039892931234433, 0.9091679830905224, 0.9142097557035307, 0.9191138516900578, 0.9238795325112867, 0.9285060804732156, 0.9329927988347388, 0.937339011912575, 0.9415440651830208, 0.9456073253805213, 0.9495281805930367, 0.9533060403541938, 0.9569403357322089, 0.9604305194155658, 0.9637760657954398, 0.9669764710448521, 0.970031253194544, 0.9729399522055602, 0.9757021300385286, 0.9783173707196277, 0.9807852804032304, 0.9831054874312163, 0.9852776423889412, 0.9873014181578584, 0.989176509964781, 0.99090263542778, 0.99247953459871, 0.9939069700023561, 0.9951847266721969, 0.996312612182778, 0.9972904566786902, 0.9981181129001492, 0.9987954562051724, 0.9993223845883495, 0.9996988186962042, 0.9999247018391445, 1, 0.9999235113880168, 0.9996940572530831, 0.9993116726964553, 0.9987764162142612, 0.9980883696885519, 0.9972476383747746, 0.9962543508856719, 0.9951086591716065, 0.9938107384973163, 0.9923607874151029, 0.9907590277344579, 0.9890057044881306, 0.987101085894644, 0.9850454633172632, 0.9828391512194237, 0.9804824871166252, 0.9779758315248003, 0.9753195679051626, 0.9725141026055468, 0.9695598647982466, 0.9664573064143603, 0.9632069020746571, 0.9598091490169693, 0.9562645670201276, 0.9525736983244458, 0.9487371075487713, 0.9447553816041101, 0.9406291296038441, 0.9363589827705495, 0.9319455943394349, 0.9273896394584106, 0.922691815084807, 0.9178528398787554, 0.9128734540932497, 0.9077544194609043, 0.9024965190774269, 0.8971005572818217, 0.891567359533345, 0.8858977722852279, 0.880092662855189, 0.8741529192927533, 0.8680794502434023, 0.861873184809571, 0.8555350724085166, 0.8490660826270794, 0.842467205073358, 0.835739449225322, 0.8288838442763844, 0.821901438977959, 0.8147933014790248, 0.8075605191627243, 0.8002041984800174, 0.7927254647804212, 0.7851254621398553, 0.7774053531856262, 0.7695663189185703, 0.7616095585323882, 0.7535362892301958, 0.7453477460383191, 0.7370451816173642, 0.7286298660705877, 0.7201030867496008, 0.7114661480574334, 0.7027203712489903, 0.6938670942289291, 0.6849076713469913, 0.6758434731908176, 0.6666758863762795, 0.6574063133353583, 0.6480361721016052, 0.6385668960932144, 0.6289999338937424, 0.6193367490305086, 0.6095788197507078, 0.5997276387952729, 0.5897847131705194, 0.5797515639176072, 0.5696297258798569, 0.5594207474679529, 0.5491261904230721, 0.5387476295779733, 0.5282866526160832, 0.5177448598286177, 0.5071238638697727, 0.49642528951002607, 0.4856507733875834, 0.4748019637580109, 0.46388052024208903, 0.45288811357192854, 0.4418264253353865, 0.4306971477188217, 0.41950198324822885, 0.4082426445287903, 0.396920853982887, 0.3855383435866072, 0.374096854604793, 0.3625981373246669, 0.35104395078807754, 0.3394360625224065, 0.3277762482701767, 0.3160662917174045, 0.3043079842207361, 0.2925031245334109, 0.2806535185300931, 0.2687609789306142, 0.256827325022668, 0.24485438238350124, 0.23284398260064146, 0.2207979629917062, 0.2087181663233351, 0.19660644052928852, 0.18446463842775587, 0.17229461743791663, 0.16009823929579745, 0.1478773697694689, 0.13563387837362562, 0.12336963808359294, 0.11108652504880454, 0.09878641830579413, 0.0864711994907457, 0.0741427525516462, 0.061802963460084105, 0.049453719922738996, 0.03709691109260531, 0.024734427279994954, 0.012368159663362913, 0]
        // for (let j = 0; j < 256; j++) {
        //   data[j] = data[j] * 100
        // }
        const data = Array(256)
        for (let j = 0; j < 256; j++) {
          data[j] = this.curvesHistograms[i][j] * 100
        }
        histogram.drawHistogram(ctx, data)
      }
      console.log(this.curvesHistograms)
      for (let i = 0; i < this.curvesHistograms.length; i++) {
        console.log('Export:', i)
        util.exportArray(this.curvesHistograms[i])
      }
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
.temperature .gradient-red >>> .v-slider__track-container {
  background: linear-gradient(90deg, rgba(0, 32, 255, 1) 0%, rgba(255 ,223,0,1) 100%);
}
.temperature .gradient-green >>> .v-slider__track-container {
  background: linear-gradient(90deg, rgba(255,32,255,1) 0%, rgba(32, 255, 32, 1) 100%);
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
