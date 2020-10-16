<template>
  <!-- App.vue -->
  <v-app>
    <Appbar />
    <!-- Sizes your content based upon application components -->
    <v-main class="grey grey lighten-5">
      <!-- Provides the application the proper gutter -->
      <v-container fluid class="pa-0">
        <!-- If using vue-router -->
        <router-view>
          <nuxt />
        </router-view>
      </v-container>
    </v-main>
    <!-- <v-footer>
      <v-spacer />
      <div>&copy; Creepy Player {{ new Date().getFullYear() }}</div>
    </v-footer> -->
  </v-app>
</template>

<script>
import Appbar from '../components/Appbar'
export default {
  components: {
    Appbar
  }
}
</script>

<style>
</style>
