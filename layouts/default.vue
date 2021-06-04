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
    <!-- <v-footer>
      <v-spacer />
      <div>
        &copy; NEROGANTE {{ new Date().getFullYear() }}
      </div>
    </v-footer> -->
  </v-app>
</template>

<script>
// import { mapMutations } from 'vuex'
import Appbar from '../components/Appbar'
export default {
  name: 'Default',
  components: {
    Appbar
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
