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
            <v-tab-item class="blue full-size">
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
          <v-tabs-items v-model="rightTabs" class="secondary white--text">
            <!-- Histogram items -->
            <v-tab-item class="py-2">
              <div class="text-caption">
                RGB
              </div>
              <canvas id="histogramRGB" width="256" height="100" class="grey darken-4" />
              <div class="text-caption">
                Red
              </div>
              <canvas id="histogramRed" width="256" height="100" class="grey darken-4" />
              <div class="text-caption">
                Green
              </div>
              <canvas id="histogramGreen" width="256" height="100" class="grey darken-4" />
              <div class="text-caption">
                Blue
              </div>
              <canvas id="histogramBlue" width="256" height="100" class="grey darken-4" />
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
      sidebarOpen: true,
      workTabs: null,
      rightTabs: null,
      finalData: null,
      tempData: null,
      previewData: null,
      zoom: 1
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
      const canvas = this.$refs.mainCanvas

      const context = canvas.getContext('2d')

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

        canvas.width = img.naturalWidth
        canvas.height = img.naturalHeight
        context.clearRect(0, 0, canvas.width, canvas.height)
        context.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        this.updateHistograms()
        // this.originalData = context.getImageData(0, 0, canvas.width, canvas.height)
      }
    },
    updateHistograms () {
      // Load Red Canvas
      const canvasOG = this.$refs.mainCanvas
      const ctxOG = canvasOG.getContext('2d')

      const rgbCtx = histogram.clearCanvas('histogramRGB')
      const redCtx = histogram.clearCanvas('histogramRed')
      const greenCtx = histogram.clearCanvas('histogramGreen')
      const blueCtx = histogram.clearCanvas('histogramBlue')

      const imageData = ctxOG.getImageData(0, 0, canvasOG.width, canvasOG.height).data

      const [redHistogram, greenHistogram, blueHistogram] = histogram.getHistograms(imageData)

      histogram.drawHistogram(redCtx, redHistogram)
      histogram.drawHistogram(greenCtx, greenHistogram)
      histogram.drawHistogram(blueCtx, blueHistogram)
      histogram.drawRGB(redHistogram, greenHistogram, blueHistogram, rgbCtx)
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
    }
  }
}
</script>

<style scoped>
.enhancer-grid {
  /* display: grid; */
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
canvas {
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-crisp-edges;
  image-rendering: pixelated;
  image-rendering: crisp-edges;
  display: block;
}
.v-window__container {
}
</style>
