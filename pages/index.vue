
<template>
  <div>
    <section>
      <v-container fluid class="pa-0">
        <!-- <h1 class="text-center text-h2 mt-16">
          I make things <v-icon x-large class="rotate">
            mdi-emoticon-cool-outline
          </v-icon>
        </h1> -->
        <div id="playground" class="d-flex justify-center align-center">
          <div id="overlay">
            <h1 class="text-h1">
              Welcome to my hideout
            </h1>
          </div>
          <canvas id="canvas" />
        </div>
      </v-container>
    </section>
  </div>
</template>

<script>
// import ToolCard from '~/components/ToolCard'
// import util from 'assets/util'
// import random from 'assets/random'
import { mapMutations } from 'vuex'

export default {
  components: {
    // ToolCard
    // Darken 4 lighten 5
  },
  data () {
    return {
      colors: [
        'red', 'pink', 'purple', 'deep-purple', 'indigo', 'blue', 'light-blue', 'cyan', 'teal', 'green', 'light-green', 'lime', 'yellow', 'amber', 'orange', 'deep-orange', 'brown', 'blue-grey', 'grey'
      ],
      colorVariants: [
        'lighten', 'darken'
      ],
      colorAlones: [
        'black', 'white', 'transparent'
      ],
      shapes: [

      ],
      camera: null,
      scene: null,
      renderer: null,
      FRAME_PERIOD: 10,
      lastTime: 0
    }
  },
  computed: {

  },
  mounted () {
    this.$store.commit('appBar/setApp', false)
    this.$store.commit('appBar/setFixed', true)
    this.initialize()
  },
  destroyed () {
    window.removeEventListener('resize', this.afterResize)
  },
  methods: {
    initialize () {

    },
    draw (time) {

    },
    shuffle () {

    },
    afterResize () {
      console.log(1)
    },
    ...mapMutations({
      toggleHidden: 'appBar/toggleHidden'
    })

  },
  head () {
    return {
      // title: 'Creepy Player',
      meta: [
        { hid: 'description', name: 'description', contant: 'Very Useless Site' }
      ]
    }
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
