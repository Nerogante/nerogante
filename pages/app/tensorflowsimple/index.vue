<template>
  <div>
    <section>
      <v-container>
        <h1>Simple</h1>

        <v-row>
          <v-col>
            <v-form disabled>
              <v-btn small @click="clickOpenVisor">
                Open Visor
              </v-btn>
              <v-btn small :disabled="training" @click="clickLoadData">
                Load Data
              </v-btn>
              <v-btn small :disabled="!inputData || model != null || training" @click="clickMakeModel">
                Make Model
              </v-btn>
              <v-btn small :disabled="!inputData || !model || training" @click="clickTrain">
                Train
              </v-btn>
              <v-btn small :disabled="!inputData || !model || training" @click="clickPredict">
                Predict
              </v-btn>
            </v-form>
          </v-col>
        </v-row>
        <v-row>
          <v-col sm="6">
            <!-- <h3>
              Layer Config
            </h3>
            <v-row>
              <v-col sm="auto">
                <v-select v-model="activation" :items="['sigmoid']" label="Activation" />
              </v-col>
            </v-row> -->
            <h3>
              Model Config
            </h3>
            <v-row>
              <v-col sm="auto">
                <v-select v-model="activation" :items="['sigmoid']" label="Optimizer" />
              </v-col>
              <v-col sm="auto">
                <v-select v-model="activation" :items="['sigmoid']" label="Loss" />
              </v-col>
              <v-col sm="auto">
                <v-text-field v-model="batchSize" type="number" min="0" label="Learning Rate" />
              </v-col>
            </v-row>

            <h3>
              Training config
            </h3>
            <v-row>
              <v-col sm="auto">
                <v-text-field v-model="batchSize" type="number" min="0" label="Chunk" />
              </v-col>
              <v-col sm="auto">
                <v-text-field v-model="epochs" type="number" min="0" label="Epochs" />
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </section>
  </div>
</template>

<script>
import * as tf from '@tensorflow/tfjs'
import * as vis from '@tensorflow/tfjs-vis'
import util from 'assets/util'

export default {
  data () {
    return {
      inputData: null,
      tensorData: null,
      training: false,
      model: null,
      activation: 'sigmoid',
      batchSize: 32,
      epochs: 50
    }
  },
  mounted () {

  },
  methods: {
    clickOpenVisor () {
      vis.visor().open()
    },
    clickLoadData () {
      this.inputData = []
      for (let i = 0; i < 1000; i++) {
        const teaspoons = util.getRndInteger(1, 100)
        this.inputData.push({
          teaspoons,
          // power: teaspoons / Math.sqrt(teaspoons) * 0.5
          power: teaspoons / (Math.sqrt(teaspoons) * 2)
          // power: teaspoons
        })
      }
      const graphData = this.inputData.map(d => ({
        x: d.power,
        y: d.teaspoons
      }))
      vis.render.scatterplot(
        { name: 'Super Graph' },
        { values: graphData },
        {
          xLabel: 'Power',
          yLabel: 'Teaspoons',
          height: 300
        }
      )
    },
    clickMakeModel () {
      this.model = this.createModel()
      vis.show.modelSummary({
        name: 'Model Summary'
      }, this.model)
    },
    async clickTrain () {
      this.training = true
      this.tensorData = this.convertToTensor(this.inputData)
      const { inputs, labels } = this.tensorData
      await this.trainModel(this.model, inputs, labels)
      this.training = false
    },
    clickPredict () {
      const { inputMax, inputMin, labelMax, labelMin } = this.tensorData
      const [xs, preds] = tf.tidy(() => {
        const xs = tf.linspace(0, 1, 100)
        const preds = this.model.predict(xs.reshape([100, 1]))
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

      const originalPoints = this.inputData.map(d => ({
        x: d.power,
        y: d.teaspoons
      }))

      vis.render.scatterplot(
        { name: 'Model Predictions vs Original Data' },
        {
          values: [originalPoints, predictedPoints],
          series: ['original', 'predicted']
        },
        {
          xLabel: 'Power',
          yLabel: 'Teaspoons',
          height: 300
        }
      )
    },
    createModel () {
      const model = tf.sequential()
      model.add(tf.layers.dense({
        inputShape: [1],
        units: 5,
        activation: this.activation,
        useBias: true
      }))
      model.add(tf.layers.dense({
        units: 5,
        activation: this.activation,
        useBias: true
      }))
      model.add(tf.layers.dense({
        units: 1,
        useBias: true
      }))
      // model.add(tf.layers.dense({
      //   inputShape: [1],
      //   units: 1,
      //   useBias: false
      // }))
      model.compile({
        optimizer: tf.train.adam(),
        loss: tf.losses.meanSquaredError,
        metrics: ['mse']
      })
      return model
    },
    convertToTensor (data) {
      return tf.tidy(() => {
      // Step 1. Shuffle data
        tf.util.shuffle(data)

        // Step 2. Convert data to tensors
        const inputs = data.map(d => d.power)
        const labels = data.map(d => d.teaspoons)
        const inputsTensor = tf.tensor2d(inputs, [inputs.length, 1], 'float32')
        const labelsTensor = tf.tensor2d(labels, [labels.length, 1], 'int32')

        console.log(inputsTensor)
        console.log(labelsTensor)
        // Step 3. Normalize the data to the range 0 - 1 using min-max scaling
        const inputMax = inputsTensor.max()
        const inputMin = inputsTensor.min()
        const labelMax = labelsTensor.max()
        const labelMin = labelsTensor.min()

        const normalizedInputs = inputsTensor.sub(inputMin).div(inputMax.sub(inputMin))
        const normalizedLabels = labelsTensor.sub(labelMin).div(labelMax.sub(labelMin))

        return {
          inputs: normalizedInputs,
          labels: normalizedLabels,
          // return the min/max bounds so we can use them later.
          inputMax,
          inputMin,
          labelMax,
          labelMin
        }
      })
    },
    async trainModel (model, inputs, labels) {
      return await model.fit(inputs, labels, {
        batchSize: this.batchSize,
        epochs: this.epochs,
        shuffle: true,
        callbacks: vis.show.fitCallbacks(
          { name: 'Training Performance' },
          ['loss', 'mse'],
          {
            height: 200,
            callbacks: ['onEpochEnd']
          }
        )
      })
    }
  }
}
</script>

<style>

</style>
