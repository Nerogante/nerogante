<template>
  <div>
    <h1 class="text-left">
      {{ app.title }}
    </h1>
    <!-- <div class="text-left">
      {{ app.description }}
    </div> -->
  </div>
</template>

<script>

export default {
  props: {
    app: {
      type: Object,
      default: null
    }
  }
}
</script>

<style>

</style>
