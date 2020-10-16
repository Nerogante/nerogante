export const state = () => ({
  list: []
})

export const mutations = {
  add (state, link) {
    console.log(link)
    state.list.push(
      link
    )
  },
  remove (state, { link }) {
    state.list.splice(state.list.indexOf(link), 1)
  }
}
