<template>
  <div>
    <v-app-bar
      fixed
      flat
      dark
      dense
      class="px-0 mx-0 barra"
      :value="!hidden"
      color="black darken-1"
    >
      <!-- <v-app-bar-nav-icon @click="mini = !mini" /> -->
      <v-btn disabled icon />

      <router-link id="page-title" to="/" class="text-uppercase font-weight-bold text-decoration-none ml-5 white--text">
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
        class="d-none d-md-block head-link text-decoration-none mx-3 font-weight-bold white--text"
        active-class="selected-link"
        link
        nuxt
      >
        {{ link.title }}
      </router-link>

      <v-btn
        v-for="link of links"
        :key="link.icon"
        :to="link.route"
        icon
        nuxt
        link
        class="d-md-none"
        active-class="green--text"
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
      color="transparent"
    >
      <v-btn
        fab
        small
        text
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
          title: 'Games',
          route: '/games',
          icon: 'mdi-gamepad-round-right'
        },
        {
          title: 'Web Apps',
          route: '/app',
          icon: 'mdi-tools'
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
$primary: #00C853;

.head-link:hover {
  color: $primary !important;
}
.selected-link {
  color: $primary !important;
}
#page-title {
  // border-bottom-color: $primary;
  // border-bottom-style: solid;
  :hover {
    color: $primary !important;
  }
}
</style>
