<template>
  <div class="">
    <!-- Hero -->
    <section class="py-16">
      <v-container class="mt-12">
        <v-row align="stretch" class="">
          <v-col cols="12" md="6" class="d-flex flex-column align-start justify-center">
            <h1
              class="text-h4 text-md-h2 font-weight-bold
              "
            >
              I make random apps and games
            </h1>
            <v-btn
              to="/app"
              x-large
              rounded
              color="red accent-4"
              class="font-weight-black
              white--text mt-8
              "
            >
              Let me see
            </v-btn>
          </v-col>
          <v-col cols="12" md="6" class="">
            <!-- <v-img src="placeholder_1080p.png" /> -->
            <div
              class="game-grid-container"
              :style="{
                gridTemplateRows: 'repeat(' + game.height + ', 1fr)',
                gridTemplateColumns: 'repeat(' + game.width + ', 1fr)'
              }"
            >
              <v-btn
                v-for="btn in game.size"
                :key="btn"
                color=""
                class=""
                height="100%"
                width="100%"
              >

              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </section>
    <!-- Latest Games -->
    <!--  -->

    <!-- Latest Apps -->
    <section class="py-16 blue-grey lighten-5">
      <v-container>
        <v-row class="" justify="start">
          <v-col cols="12">
            <h1 class="text-h4 font-weight-bold">
              Latest Apps
            </h1>
          </v-col>
          <v-col v-for="app in latestApps" :key="app.title" cols="12" md="3">
            <v-card :to="app.url">
              <v-img
                :src="app.src"
                class="grey"
                contain
                eager
              />
              <v-card-title>
                {{ app.title }}
              </v-card-title>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </section>
    <!--  -->
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
      game: {
        height: 0,
        width: 0,
        size: 0
      },
      latestApps: [
        {
          title: 'Exposer',
          description: 'Simple photo editor',
          src: 'placeholder_500.png',
          url: '/app/exposer'
        },
        {
          title: 'Exposer1',
          description: 'Simple photo editor',
          src: 'placeholder_500.png',
          url: '/app/exposer'
        },
        {
          title: 'Exposer2',
          description: 'Simple photo editor',
          src: 'placeholder_500.png',
          url: '/app/exposer'
        },
        {
          title: 'Exposer3',
          description: 'Simple photo editor',
          src: 'placeholder_500.png',
          url: '/app/exposer'
        }
      ],
      latestGames: [
        {
          title: 'Exposer',
          description: 'Simple photo editor',
          src: ''
        },
        {
          title: 'Exposer',
          description: 'Simple photo editor',
          src: ''
        }
      ]
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
    this.game.height = 5
    this.game.width = 5
    this.game.size = this.game.height * this.game.width
  },
  destroyed () {

  },
  methods: {

  }
}
</script>

<style lang="scss" scoped>
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
.game-grid-container {
  width: 100%;
  aspect-ratio: 1 / 1;

  display: grid;
  gap: 0.5em;
  padding: 0.5em;

  // background-color: hsl(0, 0%, 50%);
  // div {
  //   background-color: hsl(0, 0%, 80%);
  //   height: 100%;
  //   width: 100%;
  //   border-radius: 10%;
  // }
}
</style>
