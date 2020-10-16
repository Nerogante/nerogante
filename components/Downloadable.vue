<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      <v-row no-gutters align="center">
        <v-col cols="auto">
          <v-icon>
            mdi-check
          </v-icon>
        </v-col>
        <v-col sm="5">
          <div class="text-truncate">
            {{ link }}
          </div>
        </v-col>
        <v-col sm="auto">
          <div>
            {{ album.files.length }} files ({{ album.fileSize }})
          </div>
        </v-col>
      </v-row>
      <!-- <v-spacer />
      <v-btn icon @click="close">
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn> -->
    </v-expansion-panel-header>
    <v-expansion-panel-content>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    </v-expansion-panel-content>
    <!-- <a :href="link" target="_blank">{{ link }}</a> -->

    <!-- {{ album.files.length }} files ({{ album.fileSize }}) -->
    <!-- <v-expansion-panels flat hover>
                <v-expansion-panel>
                  <v-expansion-panel-header>
                    <template>
                      <v-row no-gutters>
                        <v-col>
                          Download Settings
                        </v-col>
                      </v-row>
                    </template>
                  </v-expansion-panel-header>
                  <v-expansion-panel-content>
                    <v-text-field
                      v-model="currentSite.downloadName"
                      label="Album Name"
                    />
                  </v-expansion-panel-content>
                </v-expansion-panel>
              </v-expansion-panels> -->
    <!-- <v-card-actions>
      <v-text-field v-model="album.name" label="Album Name" append-icon="mdi-pencil" />

      <v-btn text color="primary" @click="download">
        <v-icon left dark>
          mdi-download
        </v-icon>
        Download Album
      </v-btn>
    </v-card-actions> -->
  </v-expansion-panel>
</template>

<script>
import util from '~/assets/util'
export default {
  props: {
    link: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      album: {
        name: '',
        files: [],
        fileSize: ''
      },
      source: null
    }
  },
  mounted () {
    // this.loadInfo()
  },
  methods: {
    download () {
      alert(1)
    },
    close () {
      this.source.cancel()
      this.$store.commit('downloader/remove', this.link)
    },
    async loadInfo () {
      const CancelToken = this.$axios.CancelToken
      this.source = CancelToken.source()

      const newUrl = this.link.split('cyberdrop.me/a/').pop()
      let error = null
      const doc = await this.$axios({
        method: 'get',
        url: '/cyberdropproxy/' + newUrl,
        cancelToken: this.source.token
      }).catch(function (_error) {
        error = _error
      })
      if (error) {
        return
      }
      // console.log(doc.data)
      const domparser = new DOMParser()
      const cyberDOM = domparser.parseFromString(doc.data, 'text/html')

      this.album.name = cyberDOM.querySelector('#title').title
      this.album.files = cyberDOM.querySelectorAll('#table a.image[href]')
      let fileSize = cyberDOM.querySelector('.file-size').innerHTML
      fileSize = fileSize.substring(0, fileSize.length - 2)
      this.album.fileSize = util.formatBytes(fileSize, 1)
    }
  }
}
</script>

<style>

</style>
