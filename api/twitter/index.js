// const axios = require('axios')
// const express = require('express')
// const app = express()
// const TWITTER_BEARER_TOKEN = 'AAAAAAAAAAAAAAAAAAAAAHFOFQEAAAAA%2F2muFR0OpMtvAM%2Fpn%2FoDOtbI24I%3D0DRACCkwykPnvG1UrJKHbS78ocm0yjZwItxL3qlHAwquy5Atqd'

// app.get('/', (req, res) => {
//   res.send('Twitter API Root')
// })
// app.get('/usersshow/:screenname', async (req, res) => {
//   const _params = {
//     screen_name: req.params.screenname
//   }
//   const _headers = {
//     Authorization: 'Bearer ' + TWITTER_BEARER_TOKEN,
//     include_entities: true
//   }
//   let deo = {}
//   await axios({
//     url: 'https://api.twitter.com/1.1/users/show.json',
//     method: 'GET',
//     headers: _headers,
//     // proxy: true,
//     params: _params
//   }).then(function (_response) {
//     // res.send(response.data)
//     deo = _response.data
//   }).catch(function (_error) {
//     deo = {
//       error: _error.message
//     }
//   })
//   res.send(deo)
//   // res.send('OLA KE TAL')
// })

// module.exports = {
//   path: '/api/twitter/',
//   handler: app
// }
