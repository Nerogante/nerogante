<template>
  <div class="">
    <!-- Hero -->
    <!-- <section class="py-16 grey darken-4">
      <v-container class="mt-12">
        <v-row align="stretch" class="py-8">
          <v-col cols="12" md="12" class="">
            <h1
              class="text-h4 text-md-h2 font-weight-bold
              text-center
              white--text
              "
            >
              Welcome to my hideout
            </h1>
          </v-col>
        </v-row>
      </v-container>
    </section> -->
    <!-- Latest Games -->
    <!--  -->

    <!-- Latest Apps -->
    <section class="py-12 white">
      <v-container class="mt-12">
        <v-row class="" justify="center">
          <v-col cols="12" class="mb-6">
            <h1 class="text-h4 font-weight-bold text-center">
              Featured Apps
            </h1>
          </v-col>
          <v-col v-for="app in latestApps" :key="app.title" cols="12" md="3">
            <v-card :to="app.url" color="transparent" elevation="0" class="card-image-hover">
              <v-img
                :src="app.src"
                class=""
                contain
                eager
              />
              <v-card-title class="font-weight-bold px-0">
                {{ app.title }}
              </v-card-title>
              <v-card-subtitle class="px-0">
                {{ app.description }}
              </v-card-subtitle>
            </v-card>
          </v-col>
          <v-col cols="12" class="text-center">
            <v-btn outlined x-large to="/app" color="">
              View all apps
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </section>
    <!--  -->

    <!-- Games -->
    <section class="py-12 grey lighten-3">
      <v-container>
        <v-row justify="center">
          <v-col cols="12" class="mb-6">
            <h1 class="text-h4 font-weight-bold text-center">
              Latest Games
            </h1>
          </v-col>
        </v-row>
      </v-container>
    </section>
  </div>
</template>

<script>

// import util from 'assets/util'
import appList from 'assets/data/appList'
import { mapMutations } from 'vuex'

export default {
  components: {
    // appList
    // ToolCard
    // Darken 4 lighten 5
  },
  scrollToTop: true,
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
    latestApps () {
      return appList.apps.slice(0, 2)
    },
    latestGames () {
      return []
    }
  },
  mounted () {
    this.showAppBar()
  },
  destroyed () {

  },
  methods: {
    ...mapMutations({
      hideAppBar: 'appBar/hide',
      toggleAppBar: 'appBar/toggleAppBar',
      showAppBar: 'appBar/show'
    })
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
.card-image-hover {
  transition: all 0.1s ease-in-out;
  &:hover {
    filter: brightness(70%);
  }
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
