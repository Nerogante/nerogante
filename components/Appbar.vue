<template>
  <div>
    <v-app-bar
      :app="app"
      :fixed="fixed"
      flat
      dark
      dense
      short
      :collapse="collapsed"
      class="px-0 mx-0"
      :value="!hidden"
    >
      <!-- <v-app-bar-nav-icon @click="mini = !mini" /> -->

      <router-link v-show="!collapsed" to="/" class="font-weight-black red-text text-decoration-none pagename ml-3">
        <v-toolbar-title>Nerogante</v-toolbar-title>
      </router-link>
      <v-spacer />

      <v-btn
        v-for="link of links"
        v-show="!collapsed"
        :key="link.title"
        :to="link.route"
        :text="link.textBtn"
        :color="link.color"
        active-class="font-weight-black"
        link
        nuxt
      >
        <v-icon left class="d-md" :color="link.iconColor">
          {{ link.icon }}
        </v-icon>
        <span class="white--text" :class="{'d-none': link.textBtn, 'd-md-inline': true}">
          {{ link.title }}
        </span>
      </v-btn>
      <!-- <v-btn fab small elevation="0" @click="toggle">
        <v-icon small>
          mdi-unfold-more-vertical
        </v-icon>
      </v-btn> -->
    </v-app-bar>
  </div>
</template>

<script>
// import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      links: [
        {
          title: 'Games',
          icon: 'mdi-gamepad',
          color: 'red',
          iconColor: 'red',
          route: '/games',
          textBtn: true
        },
        {
          title: 'Web Apps',
          icon: 'mdi-creation',
          color: 'green',
          iconColor: 'green',
          route: '/app',
          textBtn: true
        },
        // {
        //   title: 'Art',
        //   icon: 'mdi-image',
        //   color: 'yellow',
        //   iconColor: 'yellow',
        //   route: '/art',
        //   textBtn: true
        // },
        {
          title: 'Donate',
          icon: 'mdi-gift-outline',
          color: 'blue',
          iconColor: 'blue',
          route: '/donate',
          textBtn: true
        }
      ],
      mini: false,
      dark: true
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
    }
  },
  methods: {
    // ...mapMutations({
    //   toggleCollapsed: 'appBar/toggleCollapsed',
    //   toggleHidden: 'appBar/toggleHidden',
    //   toggleApp: 'appBar/toggleApp'
    // })
  }
}
</script>

<style>
a.pagename {
  color: white !important;
}
.fit {
  max-height: 100%;
  max-width: 100%;
}
</style>
