<template>
  <!-- App.vue -->
  <v-app style="min-height: 100vh;">
    <Appbar />
    <!-- Sizes your content based upon application components -->
    <v-main>
      <!-- Provides the application the proper gutter -->
      <v-container fluid class="pa-0 grey lighten-5" style="min-height:100%">
        <!-- If using vue-router -->
        <router-view>
          <nuxt />
        </router-view>
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
// import { mapMutations } from 'vuex'
import Appbar from '../components/Appbar'
import Footer from '../components/Footer'

export default {
  name: 'Default',
  components: {
    Appbar,
    Footer
  },
  mounted () {
    // this.loadTheme()
  },
  methods: {
    // ...mapMutations({
    //   loadTheme: 'theme/loadTheme'
    // })
  }
}
</script>

<style>
</style>
