<template>
  <div>
    <v-container>
      <section>
        <h1>Photo Enhancement</h1>
        <v-file-input v-model="originalImage" accept="image/*" label="Image" @change="previewOriginalImage" />
        <v-row>
          <v-col sm="6">
            <v-img :src="originalUrl" />
          </v-col>
          <v-col sm="6">
            <v-img :src="enhancedUrl" />
          </v-col>
        </v-row>
      </section>
      <section>
        <v-btn nuxt to="photoenhancement/train">
          Train
        </v-btn>
      </section>
    </v-container>
  </div>
</template>

<script>
export default {
  data () {
    return {
      originalImage: null,
      originalUrl: '',
      enhancedImage: null,
      enhancedUrl: ''
    }
  },
  methods: {
    previewOriginalImage () {
      this.originalUrl = this.originalImage ? URL.createObjectURL(this.originalImage) : ''
      this.enhancedUrl = this.originalUrl
    }
  },
  head () {
    return {
      title: 'Photo Enhancement',
      meta: [
        { hid: 'description', name: 'description', content: 'Photo Enhancement' }
      ]
    }
  }
}
</script>

<style>

</style>
