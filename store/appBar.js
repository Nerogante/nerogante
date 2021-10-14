export const state = () => ({
  hidden: false,
  app: true,
  fixed: false
})

export const mutations = {
  toggleAppBar (state) {
    state.app = !state.app
    state.fixed = !state.app
    state.hidden = !state.app
  },
  hide (state) {
    state.app = false
    state.fixed = true
    state.hidden = true
  },
  show (state) {
    state.app = true
    state.fixed = false
    state.hidden = false
  },

  setHidden (state, hidden) {
    state.hidden = hidden
  },
  setApp (state, app) {
    state.app = app
  },
  setFixed (state, fixed) {
    state.fixed = fixed
  }
}
