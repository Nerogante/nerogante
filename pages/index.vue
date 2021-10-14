<template>
  <div>
    <section class="black  h-100-v">
      <v-container class="h-100-p">
        <v-row align="center" class="h-100-p">
          <v-col class="">
            <h1 class="text-h2 font-weight-bold grey--text text--lighten-5">
              A little bit of everything
            </h1>
            <!-- <div class="mt-8 white--text text-body-1">
              Master of nothing
            </div> -->
            <v-btn
              x-large
              rounded
              class="mt-8 green accent-3 font-weight-black "
            >
              Latest Apps
            </v-btn>
          </v-col>
          <v-col>
            <h1 class="text-h1 green--text text--accent-3 font-weight-black text-center">

            </h1>
          </v-col>
        </v-row>
      </v-container>
    </section>
    <section class="h-100-v">
      a
    </section>
  </div>
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
