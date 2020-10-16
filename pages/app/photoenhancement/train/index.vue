<template>
  <div>
    <v-container fluid="">
      <section>
        <h1>Photo Enhancement Training Area</h1>
        <v-btn
          @click="fireShowVisor"
        >
          <v-icon left>
            mdi-open-in-new
          </v-icon>
          Show Visor
        </v-btn>
        <v-btn
          @click="fireShowHistograms"
        >
          <v-icon left>
            mdi-open-in-new
          </v-icon>
          Show histograms
        </v-btn>
        <!-- <v-btn
          :loading="cargando"
          :disabled="cargando"
          @click="fireLoadData"
        >
          <v-icon left>
            mdi-download
          </v-icon>
          <template v-slot:cargando>
            <span class="custom-loader">
              <v-icon light>cached</v-icon>
            </span>
          </template>
        </v-btn> -->
        <v-btn
          :color="training ? 'error' : ''"
          @click="fireTraining"
        >
          <v-icon left>
            {{ !training? 'mdi-play':'mdi-pause' }}
          </v-icon>
          {{ !training? 'Train':'Pause' }}
        </v-btn>
        <v-btn
          @click="firePredict"
        >
          <v-icon left>
            mdi-home
          </v-icon>
        </v-btn>
        <div>Input data</div>
        <v-row>
          <v-col sm="6">
            <v-file-input v-model="largeImg" accepts="image/*" label="Large photo" @change="previewLarge" />
            <!-- <v-img :src="largeUrl" /> -->
            <canvas id="canvasLarge" class="d-none" />
            <v-img :src="largeUrl" />
            <v-btn @click="fireTransform">
              Transform
            </v-btn>

            <v-subheader>Brightness</v-subheader>
            <v-slider
              v-model="brightness"
              class="align-center"
              max="255"
              min="-255"
              hide-details
            >
              <template v-slot:append>
                <v-text-field
                  v-model="brightness"
                  class="mt-0 pt-0"
                  hide-details
                  single-line
                  type="number"
                  style="width: 60px"
                />
              </template>
            </v-slider>
          </v-col>
          <v-col sm="6">
            <v-file-input v-model="smallImg" accepts="image/*" label="Small photo" @change="previewSmall" />
            <canvas id="canvasSmall" class="d-none" />
            <v-img :src="smallUrl" />
          </v-col>
        </v-row>
        <div>Prediction</div>
      </section>
    </v-container>
  </div>
</template>

<script>
// import * as tf from '@tensorflow/tfjs'
import * as vis from '@tensorflow/tfjs-vis'
// import util from 'assets/util'
export default {
  data () {
    return {
      largeImg: null,
      largeUrl: '',
      smallImg: null,
      smallUrl: '',
      training: false,
      urlDownload: '',
      brightness: 0,
      darkWeights: 0,
      lightWeights: 0,
      normalWeights: 0,
      grayscale: false
    }
  },
  methods: {
    previewLarge () {
    //   this.largeUrl = this.largeImg ? URL.createObjectURL(this.largeImg) : ''
      const img = new Image()
      img.src = URL.createObjectURL(this.largeImg)
      this.largeUrl = img.src

      const canvas = document.getElementById('canvasLarge')
      const canvasSmall = document.getElementById('canvasSmall')
      const context = canvas.getContext('2d')
      context.clearRect(0, 0, canvas.width, canvas.height)

      img.onload = () => {
        // console.log(img.naturalHeight)
        canvas.width = img.naturalWidth
        canvas.height = img.naturalHeight
        canvasSmall.width = img.naturalWidth
        canvasSmall.height = img.naturalHeight
        context.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)
        // const imageData = context.getImageData(0, 0, img.naturalWidth, img.naturalHeight)
        // console.log(imageData)
      }
      canvas.width = canvas.width / 2
      canvas.height = canvas.height / 2
    //   console.log(myContext)
    },
    previewSmall () {
      this.smallUrl = this.smallImg ? URL.createObjectURL(this.smallImg) : ''
    },
    fireShowVisor () {
      vis.visor().open()
    },
    fireShowHistograms () {
    //   const data = Array(256).fill(0)
    //     .map(x => Math.random() * 1000 - (Math.random() * 0))
    //   data.push(Infinity)
    //   data.push(NaN)
    //   data.push(0)
    //   console.log(data)
    //   const surface = { name: 'Histogram', tab: 'Charts' }
    //   vis.render.histogram(surface, data)
    },
    fireTraining () {

    },
    firePredict () {
      const canvas = document.getElementById('canvasLarge')
      //   const context = canvas.getContext('2d')
      const dataURL = canvas.toDataURL('image/png')
      //   this.urlDownload = dataURL
      this.smallUrl = dataURL
      this.urlDownload = dataURL
      window.open(dataURL)
    },
    fireTransform () {
      const canvas = document.getElementById('canvasLarge')
      const context = canvas.getContext('2d')
      const canvasSmall = document.getElementById('canvasSmall')
      const contextSmall = canvasSmall.getContext('2d')

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

      contextSmall.clearRect(0, 0, canvasSmall.width, canvasSmall.height)
      contextSmall.putImageData(imageData, 0, 0)
      this.smallUrl = canvasSmall.toDataURL('image/png')

      console.log(imageData.data)
    //   const dataURL = canvas.toDataURL('image/png')
    },
    async delay (imageData, i) {

    }
  },
  head () {
    return {
      title: 'Photo Enhancement Train',
      meta: [
        { hid: 'description', name: 'description', content: 'Photo Enhancement Train' }
      ]
    }
  }
}
</script>

<style>

</style>
