<template>
  <section>
    <v-container>
      <v-row>
        <v-col>
          ola ke tal
        </v-col>
        <v-col>
          jeje
        </v-col>
      </v-row>
    </v-container>
  </section>
</template>

<script>

export default {
  components: {
    // ToolCard
    // Darken 4 lighten 5
  },
  data () {
    return {

    }
  },
  head () {
    return {
      // title: 'Creepy Player',
      meta: [
        { hid: 'description', name: 'description', contant: 'Very Useless Site' }
      ]
    }
  },
  computed: {

  },
  mounted () {

  },
  destroyed () {

  },
  methods: {

  }
}
</script>

<style>
#playground {
  height: 100vh;
  width: 100%;
  background-color: transparent;
}
#canvas {
  position: absolute;
  /* background-color: grey; */
  z-index: 0;
  height: 100%;
  width: 100%;
  image-rendering: pixelated;
}
#overlay {
  z-index: 1;
}
.rotate {
   animation: rotation 2s infinite alternate
}
@keyframes rotation {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>
