<template>
  <div class="">
    <v-app-bar dense elevation="0" color="transparent" />
    <section class="">
      <v-container>
        <v-row justify="start" class="">
          <v-col xs="1" md="2" class="d-none d-md-block" />
          <v-col xs="12" md="8">
            <v-card color="transparent" elevation="0">
            <v-form id="searchForm" ref="superform" class="" @submit.prevent="search">

              <v-card-title>
                {{tool.title}}
              </v-card-title>
              <v-card-text class="pb-0">

              <v-text-field
                v-model="userSearch"
                label="Paste link here"
                prepend-inner-icon="mdi-magnify"
                :error-messages="searchError"
                clearable
                filled
              />
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
              </v-card-text>
              <v-card-actions class="pt-0">
                <v-row justify="end">
                  <v-col cols="auto">

                <v-btn
                right
                type="submit"
                color="primary"
              >
                <v-icon left>
                  mdi-magnify
                </v-icon>
                Search
              </v-btn>
                  </v-col>

                </v-row>

              </v-card-actions>
            </v-form>
            </v-card>
            <v-card class="my-5">
              <v-card-text>
                <!-- <iframe src="https://jpg.church/a/213.N0tPn" allow="jpg.church">

                </iframe> -->
              </v-card-text>
            </v-card>

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

  },
  data () {
    return {
      tool: {
        title: 'Link Extractor',
        description: 'Download files from various sites'
      },
      searchError: '',
      userSearch: '',
      validURL: true,
      iframeURL: '',
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
    search (event) {
      const validHosts = [
        'jpg.church'
      ]
      if (!this.userSearch.includes('http://') && !this.userSearch.includes('https://')) {
        this.userSearch = 'https://' + this.userSearch
      }
      this.validURL = this.isValidUrl(this.userSearch)
      if (!this.validURL) {
        this.searchError = 'Not a valid URL'
        return
      } else {
        this.searchError = ''
      }
      const searchURL = new URL(this.userSearch)
      console.log(searchURL)
      if (validHosts.includes(searchURL.host)) {
        this.searchError = ''
      } else {
        this.searchError = 'Site not registered'
        return
      }
      // const xhr = new XMLHttpRequest()
      // xhr.open('POST', searchURL.href)
      // xhr.setRequestHeader('X-PINGOTHER', 'pingpong')
      // xhr.setRequestHeader('Content-Type', 'application/xml')
      // xhr.onreadystatechange = this.runJpegChurch
      // xhr.send('<person><name>Arun</name></person>')
      this.runJpegChurch(searchURL)
    },
    async runJpegChurch (site) {
      // console.log(site)
      this.iframeURL = site.href
      const response = await this.$axios({
        method: 'get',
        url: 'https://www.patreon.com/api/posts?include=user.null%2Caccess_rules.tier.null%2Cattachments.null%2Caudio.null%2Cimages.null%2Cpoll.choices.null%2Cpoll.current_user_responses.null&fields[user]=full_name%2Cimage_url%2Curl&fields[post]=comment_count%2Ccontent%2Ccontent_teaser_text%2Ccurrent_user_can_view%2Cembed%2Cimage%2Cis_paid%2Clike_count%2Cmin_cents_pledged_to_view%2Cpatreon_url%2Cpatron_count%2Cpledge_url%2Cpost_file%2Cpost_type%2Cpublished_at%2Cteaser_text%2Ctitle%2Cupgrade_url%2Curl&fields[reward]=[]&fields[access-rule]=access_rule_type%2Camount_cents%2Cpost_count&fields[media]=download_url%2Cimage_urls%2Cmetadata&filter[campaign_id]=642119&filter[contains_exclusive_posts]=true&filter[is_draft]=false&page[size]=1000&sort=-published_at&json-api-use-default-includes=false&json-api-version=1.0'
      })
      console.log(response)
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
