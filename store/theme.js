// import vuetify from '@nuxtjs/vuetify'

export const state = () => ({
  // dark: process.browser ? localStorage.getItem('dark') : 'true'
})

export const mutations = {
  switch (state) {
    // state.dark = state.dark === 'true' ? 'false' : 'true'
    const isDark = localStorage.getItem('dark') === 'true'
    window.$nuxt.$root.$vuetify.theme.dark = !isDark
    window.$nuxt.$root.$vuetify.theme.light = isDark
    localStorage.setItem('dark', !isDark ? 'true' : 'false')
  },
  loadTheme (state) {
    // state.dark = localStorage.getItem('dark') === 'true'
    window.$nuxt.$root.$vuetify.theme.dark = localStorage.getItem('dark') === 'true'
    window.$nuxt.$root.$vuetify.theme.light = !window.$nuxt.$root.$vuetify.theme.dark
  }
}
