<template>
  <div>
    <v-container>
      <section class="">
        <!-- <h1 class="text-h1 text-center">
        I MAKE THINGS
      </h1> -->
        <h1>Tensorflow JS Test</h1>
        <v-btn
          @click="fireShowVisor"
        >
          <v-icon left>
            mdi-open-in-new
          </v-icon>
          Open Visor
        </v-btn>
        <v-btn
          :loading="cargando"
          :disabled="cargando"
          @click="fireLoadData"
        >
          <v-icon left>
            mdi-download
          </v-icon>
          Load data
          <template v-slot:cargando>
            <span class="custom-loader">
              <v-icon light>cached</v-icon>
            </span>
          </template>
        </v-btn>
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
          Predict
        </v-btn>
      </section>
    </v-container>
  </div>
</template>

<script>
// import ToolCard from '~/components/ToolCard'
import * as tf from '@tensorflow/tfjs'
import * as vis from '@tensorflow/tfjs-vis'
export default {
  components: {
    // ToolCard
  },
  data () {
    return {
      data: null,
      tensorData: null,
      model: null,
      visorOpen: false,
      cargando: false,
      training: false
    }
  },
  computed: {

  },
  mounted () {
  },
  methods: {
    fireShowVisor () {
      vis.visor().open()
    },
    async fireLoadData () {
      this.cargando = true
      this.data = await this.getData()
      const values = this.data.map(d => ({
        x: d.horsepower,
        y: d.mpg
      }))
      vis.render.scatterplot(
        { name: 'Horsepower v MPG' },
        { values },
        {
          xLabel: 'Horsepower',
          yLabel: 'MPG',
          height: 300
        }
      )
      this.model = this.createModel()
      vis.show.modelSummary({ name: 'Model Summary' }, this.model)
      this.cargando = false
    },
    async fireTraining () {
      this.training = true
      this.tensorData = this.convertToTensor(this.data)
      console.log(this.tensorData)
      const { inputs, labels } = this.tensorData
      await this.trainModel(this.model, inputs, labels)
      this.training = false
    },
    firePredict () {
      this.testModel(this.model, this.data, this.tensorData)
    },
    async getData () {
      const cars = await this.$axios.$get('https://storage.googleapis.com/tfjs-tutorials/carsData.json')
      const cleaned = cars.map(car => ({
        mpg: car.Miles_per_Gallon,
        horsepower: car.Horsepower
      })).filter(car => (car.mpg != null && car.horsepower != null))
      return cleaned
    },
    async trainModel (model, input, labels) {
      model.compile({
        optimizer: tf.train.adam(),
        loss: tf.losses.meanSquaredError,
        metrics: ['mse']
      })
      const batchSize = 32
      const epochs = 200
      return await model.fit(input, labels, {
        batchSize,
        epochs,
        shuffle: true,
        callbacks: vis.show.fitCallbacks(
          { name: 'Training Performance' },
          ['loss', 'mse'],
          { height: 200, callbacks: ['onEpochEnd'] }
        )
      })
    },
    testModel (model, inputData, normalizationData) {
      const { inputMax, inputMin, labelMin, labelMax } = normalizationData
      const [xs, preds] = tf.tidy(() => {
        const xs = tf.linspace(0, 1, 100)
        const preds = model.predict(xs.reshape([100, 1]))
        const unNormXs = xs
          .mul(inputMax.sub(inputMin))
          .add(inputMin)
        const unNormPreds = preds
          .mul(labelMax.sub(labelMin))
          .add(labelMin)
        return [unNormXs.dataSync(), unNormPreds.dataSync()]
      })

      const predictedPoints = Array.from(xs).map((val, i) => {
        return { x: val, y: preds[i] }
      })

      const originalPoints = inputData.map(d => ({
        x: d.horsepower,
        y: d.mpg
      }))

      vis.render.scatterplot(
        { name: 'Model Predictions vs Original Data' },
        {
          values: [originalPoints, predictedPoints],
          series: ['original', 'predicted']
        },
        {
          xLabel: 'Horsepower',
          yLabel: 'MPG',
          height: 300
        }
      )
    },
    createModel () {
      const model = tf.sequential()
      model.add(tf.layers.dense({
        inputShape: [1],
        units: 3,
        useBias: true,
        activation: 'sigmoid'
      }))
      model.add(tf.layers.dense({
        units: 3,
        useBias: true,
        activation: 'sigmoid'
      }))
      model.add(tf.layers.dense({
        units: 1,
        useBias: true
      }))
      return model
    },
    convertToTensor (data) {
      return tf.tidy(() => {
        tf.util.shuffle(data)
        const inputs = data.map(d => d.horsepower)
        const labels = data.map(d => d.mpg)
        const inputTensor = tf.tensor2d(inputs, [inputs.length, 1])
        const labelTensor = tf.tensor2d(labels, [labels.length, 1])
        const inputMax = inputTensor.max()
        const inputMin = inputTensor.min()
        const labelMax = labelTensor.max()
        const labelMin = labelTensor.min()
        const normalizedInputs = inputTensor.sub(inputMin).div(inputMax.sub(inputMin))
        const normalizedLabels = labelTensor.sub(labelMin).div(labelMax.sub(labelMin))
        return {
          inputs: normalizedInputs,
          labels: normalizedLabels,
          inputMax,
          inputMin,
          labelMax,
          labelMin
        }
      })
    }
  },
  head () {
    return {
      title: 'Test Tensorflow',
      meta: [
        { hid: 'description', name: 'description', contant: 'Test Tensorflow' }
      ]
    }
  }
}
</script>

<style>
.h-100{
  height: 100%;
}
</style>
