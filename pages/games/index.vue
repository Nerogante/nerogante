<template>
  <div class="py-5">
    <v-container>
      <section v-for="section of gameSections" :key="section.title" class="mb-5">
        <h1>
          {{ section.title }}
        </h1>
        <v-row justify="start">
          <v-col v-for="game of section.games" :key="game.title" sm="2">
            <v-hover v-slot:default="{ hover }">
              <ToolCard :app="game" :elevation="hover ? 6 : 2" />
            </v-hover>
          </v-col>
        </v-row>
      </section>
    </v-container>
  </div>
</template>

<script>
import ToolCard from '~/components/ToolCard'

export default {
  components: {
    ToolCard
  },
  data () {
    return {
      gameSections: [
        {
          title: 'Casual Games',
          games: [
            {
              title: '4',
              description: 'Show your abilities',
              image: '/gamepics/tictactoe.jpg',
              route: '/games/tictactoe'
            }
          ]
        },
        {
          title: 'Hardcore Games',
          games: [
            {
              title: 'Sliding Puzzle',
              description: 'Slide the blocks',
              image: '/gamepics/slidingpuzzle.jpg',
              route: '/games/slide'
            },
            {
              title: 'Tic Tac Toe',
              description: 'asd',
              image: '/gamepics/tictactoe.jpg',
              route: '/games/tictactoe'
            },
            {
              title: 'Snake',
              description: 'asd',
              image: '/gamepics/tictactoe.jpg',
              route: '/games/snake'
            }
          ]
        },
        {
          title: 'Pure Skill',
          games: [
            {
              title: 'Rock Paper Scissors',
              description: 'See the future',
              image: '/gamepics/rockpaperscissors.png',
              route: '/games/rockpaperscissors'
            }
          ]
        }
      ]
    }
  },
  head () {
    return {
      title: 'Games - Useless Site',
      meta: [
        { hid: 'description', name: 'description', contant: 'Boring Games' }
      ]
    }
  }
}
</script>

<style>

</style>
