<template>
  <div class="">
    <section class="py-16">
      <v-container class="mt-12">
        <v-row>
          <v-col cols="12" md="6">
            <div
              class="game-grid-container"
              :style="{
                gridTemplateRows: 'repeat(' + game.height + ', 1fr)',
                gridTemplateColumns: 'repeat(' + game.width + ', 1fr)'
              }"
            >
              <v-btn
                v-for="btn in game.size"
                :key="btn"
                color=""
                class="block"
                height="100%"
                width="100%"
                @click="clickBlock($event, true)"
              />
            </div>
          </v-col>
        </v-row>
      </v-container>
    </section>
  </div>
</template>

<script>
import util from 'assets/util'

export default {
  scrollToTop: true,
  data () {
    return {
      game: {
        colors: [
          ['grey', 'lighten-1'],
          ['blue', 'lighten-1'],
          ['purple', 'lighten-1'],
          ['orange', 'lighten-1'],
          ['grey', 'darken-4']
        ],
        colorGood: ['green', 'lighten-1'],
        colorBad: ['red', 'lighten-1'],
        height: 0,
        width: 0,
        size: 0,
        turn: 0,
        movesAI: [],
        movesPlayer: [],
        canPlayerClick: false
      }
    }
  },
  async mounted () {
    this.game.height = util.getRndInteger(2, 5)
    this.game.width = this.game.height
    this.game.size = this.game.height * this.game.width

    await this.$nextTick(() => {

    })
    this.resetGame()
    await util.delay(500)
    this.nextLevel()
  },
  methods: {
    resetGame () {
      const allBlocks = document.querySelectorAll('.block')
      for (let i = 0; i < allBlocks.length; i++) {
        const element = allBlocks[i]
        element.classList.add(...this.game.colors[0])
      }
      this.game.turn = 0
      this.game.movesAI = []
      this.game.movesPlayer = []
    },
    async nextLevel () {
      this.game.canPlayerClick = false
      const allBlocks = [...document.querySelectorAll('.block')]
      for (let i = 0; i < allBlocks.length; i++) {
        allBlocks[i].classList.remove(...this.game.colorBad)
        allBlocks[i].classList.remove(...this.game.colorGood)
        allBlocks[i].classList.add(...this.game.colors[0])
      }
      const totalPlays = this.game.turn + 1
      const nextIndex = util.getRndInteger(0, this.game.size - 1)
      this.game.movesAI.push(nextIndex)

      for (let i = 0; i < totalPlays; i++) {
        const rndIndex = this.game.movesAI[i]
        const element = allBlocks[rndIndex]
        element.focus()
        element.click()
        this.removeColors(element)
        let colorToAdd = 1
        if (this.game.turn >= 20) {
          colorToAdd = 3
        } else if (this.game.turn >= 10) {
          colorToAdd = 2
        }
        element.classList.add(...this.game.colors[colorToAdd])
        await util.delay(200)
        element.blur()
        this.removeColors(element)
        element.classList.add(...this.game.colors[0])
        await util.delay(100)
      }
      this.game.canPlayerClick = true
    },
    async clickBlock (event, isPlayer = false) {
      let element = event.target
      const allBlocks = [...document.querySelectorAll('.block')]
      let indexClick = allBlocks.indexOf(element)
      if (indexClick === -1) {
        indexClick = allBlocks.indexOf(element.parentElement)
        element = element.parentElement
      }

      if (isPlayer && this.game.canPlayerClick) {
        this.game.canPlayerClick = false
        this.game.movesPlayer.push(indexClick)
        const indexCorrect = this.game.movesAI[this.game.movesPlayer.length - 1]
        this.removeColors(element)

        if (indexClick === indexCorrect) {
          if (this.game.movesPlayer.length > 1) {
            const elementPrev = allBlocks[this.game.movesPlayer[this.game.movesPlayer.length - 2]]
            this.removeColors(elementPrev)
            elementPrev.classList.add(...this.game.colors[0])
          }
          this.removeColors(element)
          element.classList.add(...this.game.colorGood)
          // element.querySelector('span').innerHTML = this.game.movesPlayer.length
          if (this.game.movesAI.length === this.game.movesPlayer.length) {
            this.game.turn += 1
            this.game.movesPlayer = []
            await util.delay(750)
            this.nextLevel()
          } else {
            this.game.canPlayerClick = true
          }
        } else {
          element.classList.add(...this.game.colorBad)
          await util.delay(500)
          this.resetGame()
          await util.delay(500)
          this.nextLevel()
        }
      }
      // element.classList.add(...this.game.colors[nextColorIndex])
      // this.game.blocks[index] = nextColorIndex
    },
    removeColors (element) {
      for (let i = 0; i < this.game.colors.length; i++) {
        element.classList.remove(...this.game.colors[i])
      }
      element.classList.remove(...this.game.colorGood)
      element.classList.remove(...this.game.colorBad)
    },
    isLastCorrect (turn) {
      return false
    }
  }
}
</script>

<style lang="scss" scoped>
.game-grid-container {
  width: 100%;
  aspect-ratio: 1 / 1;

  display: grid;
  gap: 0.75em;
  padding: 0;

  // background-color: hsl(0, 0%, 25%);
  // div {
  //   background-color: hsl(0, 0%, 80%);
  //   height: 100%;
  //   width: 100%;
  //   border-radius: 10%;
  // }
}
</style>
