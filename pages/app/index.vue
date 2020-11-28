<template>
  <div class="">
    <v-container>
      <v-row>
        <v-col sm="">
          <template v-for="section of toolSections">
            <section v-if="section.tools && !section.hidden" :key="section.title" class="mb-5">
              <h1>
                <!-- <v-icon :color="section.color">
                  {{ section.icon }}
                </v-icon> -->
                {{ section.title }}
              </h1>
              <v-row justify="start">
                <template v-for="tool of section.tools">
                  <v-col v-if="!tool.hidden" :key="tool.title" cols="12" lg="3">
                    <v-hover v-slot:default="{ hover }">
                      <ToolCard :app="tool" :elevation="hover ? 6 : 2" />
                    </v-hover>
                  </v-col>
                </template>
              </v-row>
            </section>
          </template>
        </v-col>
      </v-row>
      <!-- Tools -->
    </v-container>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'
import ToolCard from '~/components/ToolCard'

export default {
  components: {
    ToolCard
  },
  data () {
    return {
      toolSections: [
        {
          title: 'Web Scraping',
          hidden: false,
          icon: '',
          color: '',
          tools: [
            {
              title: 'Downloader',
              hidden: false,
              description: 'Download files from various sites',
              route: '/app/downloader',
              icon: 'mdi-download',
              image: 'Downloader.png',
              iconColor: 'green darken-1',
              color: 'green lighten-5'
            }
          ]
        },
        {
          title: 'Image Editing',
          hidden: false,
          icon: '',
          color: '',
          tools: [
            {
              title: 'Photo Editor',
              hidden: false,
              description: 'Dong',
              route: '/app/photo-editor',
              icon: 'mdi-invert-colors',
              image: 'Draw.png',
              iconColor: 'blue darken-1',
              color: 'blue lighten-5'
            }
          ]
        },
        {
          title: 'Artificial Intelligence',
          hidden: true,
          icon: '',
          color: '',
          tools: [
            {
              title: 'Reality 3D',
              hidden: false,
              description: 'Dong',
              route: '/app/reality-maker',
              icon: 'mdi-cube-outline',
              color: 'white',
              iconColor: 'blue lighten-2'
            },
            {
              title: 'Photo Enhancement',
              hidden: false,
              description: 'Dong',
              route: '/app/photoenhancement',
              icon: 'mdi-image-size-select-large',
              iconColor: 'white',
              color: 'purple lighten-2'
            }
          ]
        },
        {
          title: 'Unfinished Prototypes',
          hidden: true,
          icon: '',
          tools: [
            {
              title: 'Tensorflow simple',
              hidden: false,
              description: 'Dong',
              route: '/app/tensorflowsimple',
              icon: 'mdi-brain',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Tensorflow Reference',
              hidden: true,
              description: 'Dong',
              route: '/app/tensorflowtest',
              icon: 'mdi-brain',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Three JS',
              hidden: false,
              description: 'Dong',
              route: '/app/test-three-js',
              icon: 'mdi-cube',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Babylon JS',
              hidden: false,
              description: 'Dong',
              route: '/app/test-babylon-js',
              icon: 'mdi-cube',
              iconColor: 'dark',
              color: 'grey lighten-5'
            }
          ]
        }
      ]
    }
  },
  mounted () {
    this.$store.commit('appBar/setFixed', false)
    this.$store.commit('appBar/setApp', true)
  },
  methods: {
    ...mapMutations({

    })
  },
  head () {
    return {
      title: 'Apps - ' + process.env.title,
      meta: [
        { hid: 'description', name: 'description', content: 'Creations' }
      ]
    }
  }
  // beforeRouteLeave (to, from, next) {
  //   const answer = window.confirm('Do you really want to leave? you have unsaved changes!')
  //   if (answer) {
  //     next()
  //   } else {
  //     next(false)
  //   }
  // }
}
</script>

<style>

</style>
