<template>
  <div class="">
    <v-container>
      <v-row>
        <v-col sm="">
          <div v-for="section of toolSections" :key="section.title">
            <section v-if="section.tools" class="mb-5">
              <h1>
                <v-icon :color="section.color">
                  {{ section.icon }}
                </v-icon>
                {{ section.title }}
              </h1>
              <v-row justify="start">
                <v-col v-for="tool of section.tools" :key="tool.title" cols="12" lg="3">
                  <v-hover v-slot:default="{ hover }">
                    <ToolCard :app="tool" :elevation="hover ? 6 : 2" />
                  </v-hover>
                </v-col>
              </v-row>
            </section>
          </div>
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
          title: 'Artificial Intelligence',
          icon: '',
          color: '',
          tools: [
            {
              title: 'Reality 3D',
              description: 'Dong',
              route: '/app/reality-maker',
              icon: 'mdi-cube-outline',
              iconColor: 'white',
              color: 'blue lighten-2'
            },
            {
              title: 'Photo Enhancement',
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
          icon: '',
          tools: [
            {
              title: 'Photo Editor',
              description: 'Dong',
              route: '/app/photo-editor',
              icon: 'mdi-invert-colors',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Creepy Downloader',
              description: 'Download files from various sites',
              route: '/app/creepydownloader',
              icon: 'mdi-download',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Tensorflow simple',
              description: 'Dong',
              route: '/app/tensorflowsimple',
              icon: 'mdi-brain',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Tensorflow Reference',
              description: 'Dong',
              route: '/app/tensorflowtest',
              icon: 'mdi-brain',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Three JS',
              description: 'Dong',
              route: '/app/test-three-js',
              icon: 'mdi-cube',
              iconColor: 'dark',
              color: 'grey lighten-5'
            },
            {
              title: 'Babylon JS',
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
