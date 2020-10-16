<template>
  <v-card :elevation="elevation" nuxt :to="app.route">
    <v-sheet :color="app.color" class="text-center">
      <v-icon class="py-10" :color="app.iconColor" size="64">
        {{ app.icon }}
      </v-icon>
    </v-sheet>
    <v-card-title>
      <span>
        {{ app.title }}
      </span>
    </v-card-title>
    <v-card-subtitle>
      {{ app.description }}
    </v-card-subtitle>
  </v-card>
</template>

<script>
export default {
  props: {
    app: {
      type: Object,
      default: null
    },
    elevation: {
      type: Number,
      default: 1
    }
  }
}
</script>

<style>
.title {
  text-decoration: none;
  color: black !important;
}
.title:hover{
  text-decoration: underline;
}
</style>
