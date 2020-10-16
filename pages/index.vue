<template>
  <div>
    <section>
      <v-container>
        <h1 class="text-center text-h2 mt-16">
          I make things <v-icon x-large class="rotate">
            mdi-emoticon-cool-outline
          </v-icon>
        </h1>
      </v-container>
    </section>
  </div>
</template>

<script>
// import ToolCard from '~/components/ToolCard'
// import util from 'assets/util'
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
      renderer: null
    }
  },
  computed: {

  },
  mounted () {
    // this.$store.commit('appBar/setApp', false)
    // this.$store.commit('appBar/setFixed', true)
    this.initialize()
  },
  methods: {
    initialize () {
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
