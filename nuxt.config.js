
export default {
  env: {
    title: 'Nerogante',
    TWITTER_API_KEY: 'wrnSG471OkyHXUAF1OKpyuvxg',
    TWITTER_API_KEY_SECRET: 'yuGWmuec2kL6UdvOkOuV7YVmL2NXm2Su0easkWfY041VRZS0Rq',
    TWITTER_BEARER_TOKEN: 'AAAAAAAAAAAAAAAAAAAAAHFOFQEAAAAA%2F2muFR0OpMtvAM%2Fpn%2FoDOtbI24I%3D0DRACCkwykPnvG1UrJKHbS78ocm0yjZwItxL3qlHAwquy5Atqd'
  },
  server: {
    port: 8000,
    host :'0.0.0.0'
  },
  /*
  ** Headers of the page
  */
  head: {
    // title: process.env.npm_package_name || 'Nerogante',
    title: 'Nerogante',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    '~assets/scss/global.scss'
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module',
    '@nuxtjs/vuetify'
  ],
  vuetify: {
    icons: {

    }
  },
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/proxy'
  ],
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {

  },
  proxy: {
    '/twitterapi/': { target: 'https://api.twitter.com', pathRewrite: { '^/twitterapi/': '' } },
    '/cyberdropproxy/': { target: 'https://cyberdrop.me/a/', pathRewrite: { '^/cyberdropproxy/': '' } },
    '/cyberdropfileproxy/': { target: 'https://f.cyberdrop.nl/', pathRewrite: { '^/cyberdropfileproxy/': '' } },
    '/weiboproxy/': { target: 'https://video.weibo.com/show?fid=', pathRewrite: { '^/weiboproxy/': '' } }
  },
  serverMiddleware: [
    {
      path: 'api/twitter',
      handler: '~/api/twitter/index.js'
    }
  ],
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend (config, ctx) {
    }
  }
}
