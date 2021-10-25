<template>
  <div>
    <v-app-bar
      :hidden="fixed"
      :app="false"
      :fixed="!fixed"
      flat
      dark
      dense
      class="px-0 mx-0 barra"
      color="black darken-4"
      elevation="2"
    >
      <!-- <v-app-bar-nav-icon @click="mini = !mini" /> -->
      <v-btn disabled icon />

      <!-- Logo Title -->
      <router-link
        id="page-title"
        to="/"
        class="text-uppercase font-weight-bold text-decoration-none ml-5 white--text"
        exact-active-class=""
      >
        <v-toolbar-title>
          Nerogante
        </v-toolbar-title>
      </router-link>

      <v-spacer />

      <!-- Links -->
      <router-link
        v-for="link of links"
        v-show="true"
        :key="link.title"
        :to="link.route"
        text
        class="d-none d-md-block page-link text-decoration-none mx-3"
        active-class="selected font-weight-bold"
        link
        nuxt
      >
        {{ link.title }}
      </router-link>

      <!-- Links Mobile -->
      <v-btn
        v-for="link of links"
        :key="link.icon"
        :to="link.route"
        icon
        nuxt
        link
        class="d-md-none"
        color=""
        active-class="red--text text--lighten-2"
      >
        <v-icon>{{ link.icon }}</v-icon>
      </v-btn>
    </v-app-bar>
    <v-app-bar
      flat
      collapse
      fixed
      dense
      style="right: unset"
      color="black"
      :elevation="fixed ? 2 : 0"
    >
      <v-btn
        fab
        small
        text
        color="red"
        @click="toggleAppbar"
      >
        <v-avatar>
          <!-- <img class="pa-2" :src="!hidden ?'/logo_white.png' : '/logo_color.png'" alt="favicon"> -->
          <img class="pa-2" src="/logo_color.png" alt="favicon">
        </v-avatar>
        <!-- <v-icon color="red">
          mdi-alpha-n-circle-outline
        </v-icon> -->
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
          title: '',
          route: '/games',
          icon: 'mdi-google-controller'
        },
        {
          title: 'Apps',
          route: '/app',
          icon: 'mdi-apps'
        },
        {
          title: 'Donate',
          route: '/donate',
          icon: 'mdi-gift'
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

<style lang="scss" scoped>
// @import '~vuetify/src/styles/styles.sass';

// $primary: #00C853;
$primary: var(--v-primary-base);

.page-link {
  color: hsl(0, 0%, 70%);
  &.selected {
    color: white;
  }
  &:hover {
    color: hsl(0, 0%, 90%);
  }
}
#page-title {
  // border-bottom-color: $primary;
  // border-bottom-style: solid;
  // color: $primary !important;
  :hover {
    color: hsl(0, 0%, 90%);
  }
}
</style>
