<template>
  <v-footer v-show="!fixed" color="grey darken-4" class="white--text">
    <v-container class="py-16">
      <v-row justify="center">
        <v-col v-for="section in footerContent" :key="section.title" cols="6" md="3">
          <h4>
            {{ section.title }}
          </h4>
          <div class="d-flex flex-column justify-start align-start">
            <v-btn
              v-for="link in section.links"
              :key="link.title"
              :to="link.url"
              plain
              text
              min-width="0"
              color="grey"
              class="text-left px-0"
            >
              {{ link.title }}
            </v-btn>
          </div>
        </v-col>
        <v-col
          class="py-4 text-center white--text"
          cols="12"
        >
          {{ new Date().getFullYear() }} — <strong>Nerogante</strong>
        </v-col>
      </v-row>
    </v-container>
  </v-footer>
</template>

<script>
// import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      footerContent: [
        {
          title: 'Navigation',
          links: [
            {
              title: 'Homepage',
              url: '/'
            },
            {
              title: 'Games',
              url: '/games'
            },
            {
              title: 'Apps',
              url: '/app'
            },
            {
              title: 'Donate',
              url: '/donate'
            }
          ]
        },
        {
          title: 'Website',
          links: [
            {
              title: 'Privacy',
              url: '/privacy'
            }
          ]
        }
      ]
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

<style scoped>
</style>
