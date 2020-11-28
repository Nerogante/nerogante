<template>
  <div class="py-5">
    <section>
      <v-container>
        <v-row justify="start" class="">
          <v-col xs="1" md="2" class="d-none d-md-block" />
          <v-col xs="12" md="8">
            <AppInfo :app="tool" />
            <v-form id="searchForm" ref="superform" v-model="valid" class="mb-5" @submit.prevent="addLinks">
              <v-textarea
                v-model="searchURL"
                label="Paste links here"
                rows="2"
                clearable
                filled
                dense
              />
              <v-row no-gutters justify="end">
                <v-btn
                  type="submit"
                  color="primary"
                  :disabled="!searchURL"
                >
                  <v-icon left>
                    mdi-plus
                  </v-icon>
                  Add
                </v-btn>
              </v-row>
              <!-- <v-btn
                type="submit"
                color="primary"
                :disabled="!searchURL"
              >
                <v-icon left>
                  mdi-plus
                </v-icon>
                Add Links
              </v-btn> -->
            </v-form>
            {{ selected.length }} selected
            <v-btn fab class="elevation-1" small color="primary">
              <v-icon dark>
                mdi-download
              </v-icon>
            </v-btn>
            <v-btn fab class="elevation-1" small>
              <v-icon dark>
                mdi-delete
              </v-icon>
            </v-btn>
            <!-- <v-data-table
              v-model="selected"
              :headers="headers"
              :items="links"
              item-key="url"
              show-select
              no-data-text="No links added"
              class="elevation-1"
            /> -->
            <!-- <Cyberdrop v-for="link in cyberdropLinks" :key="link.link" :link="link.link" /> -->
            <v-expansion-panels accordion multiple hover dense>
              <Downloadable v-for="link of links" :key="link.url" :link="link.url" />
            </v-expansion-panels>
          </v-col>
          <v-col md="2" class="d-none" />
        </v-row>
      </v-container>
    </section>
    <!-- <section>
      <v-row>
        <v-col>
          Supported sites: cyberdrop.me
        </v-col>
      </v-row>
    </section> -->
  </div>
</template>

<script>
import JSZip from 'jszip'
import saveAs from 'file-saver'
import AppInfo from '~/components/AppInfo'
import util from '~/assets/util'
import Downloadable from '~/components/Downloadable'
export default {
  components: {
    AppInfo,
    Downloadable
  },
  data () {
    return {
      tool: {
        title: 'Creepy Downloader',
        description: 'Download files from various sites'
      },
      errorMessage: '',
      searchURL: '',
      valid: false,
      selected: [],
      headers: [
        {
          text: 'Url',
          align: 'start',
          value: 'url'
        },
        {
          text: 'Files',
          value: 'files'
        },
        {
          text: 'Size',
          value: 'size'
        }
      ]
    }
  },
  computed: {
    cyberdropLinks () {
      return this.links.filter(link => link.includes('cyberdrop.me'))
    },
    links () {
      return this.$store.state.downloader.list
    }
  },
  methods: {
    submit () {
      // this.$refs.form.submit()
      // try {
      //   if (this.$refs.superform.validate()) {

      //   }
      // } catch (error) {
      //   console.log(error)
      // }
    },
    addLinks () {
      const changed = this.searchURL.replace(/\s/g, '\n')
      // console.log(changed)
      const splited = changed.split('\n')
      // console.log(splited)
      for (const part of splited) {
        // console.log(part)
        if (part.length === 0) {
          // splited.splice(splited.indexOf(part), 1)
        } else if (this.isValidUrl(part) && this.links.filter(link => link.url === part).length === 0) {
          const link = {
            url: part,
            files: 0,
            size: util.formatBytes(0, 2)
          }
          this.$store.commit('downloader/add', link)
        }
      }
    },
    checkSite () {
    },
    doCyberdrop () {
    },
    async download () {
      const title = this.currentSite.albumName
      for (const file of this.currentSite.files) {
        const newUrl = file.href.split('f.cyberdrop.nl/').pop()
        const response = await this.$axios({
          method: 'get',
          responseType: 'blob',
          url: '/cyberdropfileproxy/' + newUrl
        }).catch(function (_error) {
          console.log(_error)
        })
        file.downloaded = response.data
      }
      const zip = new JSZip()
      const img = zip.folder(title)
      for (const file of this.currentSite.files) {
        img.file(decodeURI(file.href.split('f.cyberdrop.nl/').pop()), file.downloaded)
      }

      zip.generateAsync({ type: 'blob' })
        .then(function (content) {
          saveAs(content, title)
        })
    },
    isValidUrl (str) {
      return /^(?:\w+:)?\/\/([^\s\\.]+\.\S{2}|localhost[\\:?\d]*)\S*$/.test(str)
    }
  }

}
</script>

<style>

</style>
