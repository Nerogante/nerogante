<template>
  <div>
    <v-container>
      <section>
        <h1>
          Donate :)
        </h1>
      </section>
    </v-container>
  </div>
</template>

<script>
export default {
  mounted () {
    this.$store.commit('appBar/setFixed', false)
    this.$store.commit('appBar/setApp', true)
  }
}
</script>

<style>

</style>
