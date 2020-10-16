<template>
  <div class="py-5">
    <v-container>
      <AppInfo :app="game" />
      <section>
        <v-row justify="start" class="py-5">
          <v-col md="6">
            <v-form id="searchForm" ref="superform" v-model="valid" @submit.prevent="submitSearch">
              <v-row>
                <v-col>
                  <v-text-field v-model="searchUser" :rules="userRules" label="Twitter Account" />
                </v-col>
                <v-col sm="auto">
                  <v-btn type="submit" color="primary" @click="submit">
                    <v-icon>mdi-magnify</v-icon>
                  </v-btn>
                </v-col>
              </v-row>
            </v-form>
          </v-col>
        </v-row>
        <v-row>
          <v-col sm="6">
            <div v-show="user.name">
              <h3>Best result</h3>
              <v-card>
                <v-img v-if="user.profile_banner_url" :src="user.profile_banner_url" />
                <v-row class="px-5 pt-3">
                  <v-avatar>
                    <img :src="user.profile_image_url">
                  </v-avatar>
                  <v-card-title>{{ user.name }}</v-card-title>
                </v-row>
              </v-card>
            </div>
            <div v-show="user.noresults">
              <h3>No exact results</h3>
            </div>
          </v-col>
          <!-- <v-list class="mt-5">
              <v-list-item-group>
                <v-subheader>Related Tweets</v-subheader>
                <pre>
                  {{ response }}
                </pre>
                <v-list-item v-for="(user, i) in users" :key="i">
                  <v-list-item-avatar>
                    <v-img :src="user.avatar" />
                  </v-list-item-avatar>
                  <v-list-item-content>
                    <v-list-item-title>
                      {{ user.name }}
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list> -->
        </v-row>
      </section>
    </v-container>
  </div>
</template>

<script>
// import axios from 'axios'
import AppInfo from '~/components/AppInfo'
export default {
  components: {
    AppInfo
  },
  data () {
    return {
      game: {
        title: 'Sliding Puzzle',
        description: 'Slide the blocks to form the original picture'
      },
      response: {},
      image: '',
      valid: false,
      searchUser: '',
      userRules: [
        v => !!v || 'Name is required'
      ],
      user: {}
    }
  },
  mounted () {

  },
  methods: {
    submit () {
      // this.$refs.form.submit()
      try {
        if (this.$refs.superform.validate()) {

        }
      } catch (error) {
        console.log(error)
      }
    },
    async submitSearch () {
      if (this.valid) {
        const res = await this.GETusersshow(this.searchUser)

        if (!res.data.error) {
          this.user = res.data
          console.log(this.user)
        } else {
          this.user = {
            noresults: true
          }
        }
        // this.$router.push({
        //   path: '/games/slide/' + this.searchUser
        // })
      }
    },
    async getLabData (_params) {
      try {
        return await this.$axios({
          baseURL: '/twitterapi/labs/1/tweets',
          method: 'GET',
          headers: {
            Authorization: 'Bearer ' + this.BEARER_TOKEN
          },
          proxy: true,
          params: _params
        })
      } catch (error) {
        return error
      }
    },
    async GETstatuseshome_timeline (_params, _headers) {
      return await this.$axios({
        baseURL: '/twitterapi/1.1/statuses/user_timeline.json',
        method: 'GET',
        headers: _headers,
        proxy: true,
        params: _params
      }).then(function (response) {
        return response
      }).catch(function (_error) {
        return { error: _error }
      })
    },
    async GETusersshow (_screenname) {
      return await this.$axios({
        baseURL: '/api/twitter/usersshow/' + _screenname,
        method: 'GET'
      }).then(function (response) {
        return response
      }).catch(function (_error) {
        return { error: _error }
      })
    },
    async GETuserssearch (_params, _headers) {
      try {
        return await this.$axios({
          baseURL: '/twitterapi/1.1/users/search.json',
          method: 'GET',
          headers: _headers,
          proxy: true,
          params: _params
        })
      } catch (error) {
        return error
      }
    }
  }
}
</script>

<style>

</style>
