export const state = () => ({
  collapsed: false,
  hidden: false,
  app: true,
  fixed: false
})

export const mutations = {
  toggleCollapse (state) {
    state.collapsed = !state.collapsed
  },
  setCollapsed (state, collapsed) {
    state.collapsed = collapsed
  },
  toggleHidden (state) {
    state.hidden = !state.hidden
  },
  setHidden (state, hidden) {
    state.hidden = hidden
  },
  toggleApp (state) {
    state.app = !state.app
  },
  setApp (state, app) {
    state.app = app
  },
  toggleFixed (state) {
    state.fixed = !state.fixed
  },
  setFixed (state, fixed) {
    state.fixed = fixed
  }
}
