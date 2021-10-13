<template>
  <div>
    <v-container>
      <v-row>
        <v-col sm="">
          <template v-for="section of toolSections">
            <section v-if="section.tools && !section.hidden" :key="section.title" class="">
              <h1 class="mt-6 mb-3">
                <!-- <v-icon :color="section.color">
                  {{ section.icon }}
                </v-icon> -->
                {{ section.title }}
              </h1>
              <v-row justify="start">
                <template v-for="tool of section.tools">
                  <v-col v-if="!tool.hidden" :key="tool.title" cols="6" lg="3">
                    <v-hover v-slot="{ hover }">
                      <ToolCard :app="tool" :elevation="hover ? 4 : 2" />
                    </v-hover>
                  </v-col>
                </template>
              </v-row>
            </section>
          </template>
        </v-col>
      </v-row>
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
          hidden: true,
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
              title: 'Exposer',
              hidden: false,
              description: 'Expose',
              route: '/app/exposer',
              icon: 'mdi-invert-colors',
              image: 'cat meme.png',
              iconColor: 'blue darken-1',
              color: 'blue lighten-5'
            }
          ]
        },
        {
          title: 'Random apps',
          tools: [
            {
              title: 'Multiplications',
              description: 'Random Multiplications',
              route: '/app/multiplications',
              icon: '',
              image: 'multiplications.png',
              color: 'white'
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
  head () {
    return {
      title: 'Apps - ' + process.env.title,
      meta: [
        { hid: 'description', name: 'description', content: 'Creations' }
      ]
    }
  },
  mounted () {

  },
  methods: {
    ...mapMutations({

    })
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
