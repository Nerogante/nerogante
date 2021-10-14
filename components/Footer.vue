<template>
  <v-footer color="black white--text">
    <v-container>
      <v-row>
        <v-col>
          1
        </v-col>
        <v-col>
          2
        </v-col>
        <v-col>
          3
        </v-col>
        <v-col>
          4
        </v-col>
      </v-row>
    </v-container>
  </v-footer>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  data () {
    return {

    }
  },
  computed: {
    collapsed () {
      return this.$store.state.appBar.collapsed
    },
    hidden () {
      return this.$store.state.appBar.hidden
    },
    app () {
      return this.$store.state.appBar.app
    },
    fixed () {
      return this.$store.state.appBar.fixed
    },
    dark () {
      return this.$store.state.theme.dark
    }
  },
  mounted () {

  },
  methods: {

  }
}
</script>

<style>

</style>
