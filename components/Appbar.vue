<template>
  <div>
    <v-app-bar
      :app="app"
      :fixed="fixed"
      flat
      dark
      dense
      class="px-0 mx-0"
      :value="!hidden"
      color="black"
    >
      <!-- <v-app-bar-nav-icon @click="mini = !mini" /> -->

      <v-btn disabled icon />

      <router-link id="page-title" to="/" class="font-weight-black text-decoration-none ml-5 white--text">
        <v-toolbar-title>
          Nerogante
        </v-toolbar-title>
      </router-link>

      <v-spacer />

      <router-link
        v-for="link of links"
        v-show="true"
        :key="link.title"
        :to="link.route"
        text
        class="d-none d-md-flex headerSection text-decoration-none mx-3 grey--text"
        active-class="font-weight-bold text--lighten-3"
        link
        nuxt
      >
        <span class="">
          {{ link.title }}
        </span>
      </router-link>
      <v-menu offset-y tile>
        <template #activator="{ on, attrs }">
          <v-btn
            icon
            v-bind="attrs"
            v-on="on"
          >
            <v-icon color="grey">
              mdi-dots-vertical
            </v-icon>
          </v-btn>
        </template>
        <v-list dense>
          <v-list-item-group>
            <v-list-item
              v-for="(item, i) in menuItems"
              :key="i"
              @click="item.method"
            >
              <v-list-item-icon>
                <v-icon>
                  {{ item.icon }}
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-menu>
      <!-- <v-btn fab small elevation="0" @click="toggle">
        <v-icon small>
          mdi-unfold-more-vertical
        </v-icon>
      </v-btn> -->
    </v-app-bar>
    <v-app-bar
      flat
      collapse
      fixed
      dense
      style="right: unset"
      color="black"
    >
      <v-btn
        fab
        small
        text
        @click="toggleAppbar"
      >
        <v-icon color="red">
          mdi-alpha-n-circle-outline
        </v-icon>
      </v-btn>
    </v-app-bar>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      links: [
        {
          title: 'Games',
          route: '/games'
        },
        {
          title: 'Web Apps',
          route: '/app'
        },
        {
          title: 'Donate',
          route: '/donate'
        }
      ],
      menuItems: [
        {
          title: 'Hello',
          icon: 'mdi-hand-right',
          method: () => {}
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
    ...mapMutations({
      toggleAppbar: 'appBar/toggleAppBar',
      switchTheme: 'theme/switch'
    }),
    debug (event) {
      alert(event)
    }
  }
}
</script>

<style>
.fit {
  max-height: 100%;
  max-width: 100%;
}
</style>
