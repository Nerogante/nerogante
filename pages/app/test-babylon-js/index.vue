<!--
<template>
  <div>
    <canvas ref="babylonCanvas" class="babylonCanvas" />
  </div>
</template>

<script>
import * as BABYLON from 'babylonjs'
import MeshVertices from '~/assets/MeshVertices'

export default {
  data () {
    return {
      engine: null
    }
  },
  mounted () {
    this.$store.commit('appBar/setApp', false)
    this.$store.commit('appBar/setFixed', true)

    const scene = this.createScene()
    this.engine.runRenderLoop(() => {
      scene.render()
    })
  },
  methods: {
    createScene () {
      const canvas = this.$refs.babylonCanvas
      this.engine = new BABYLON.Engine(canvas, true)

      const scene = new BABYLON.Scene(this.engine)
      scene.clearColor = new BABYLON.Color4(0.3, 0.3, 0.3, 1)
      const camera = new BABYLON.ArcRotateCamera('ArcRotateCamera', 1, 0.8, 5, new BABYLON.Vector3(0, 0, 0), scene)
      camera.minZ = 0.1
      camera.lowerRadiusLimit = 0.001
      camera.upperRadiusLimit = 1
      camera.wheelPrecision = 100

      camera.setTarget(BABYLON.Vector3.Zero())
      camera.attachControl(canvas, true)

      const pointMesh = new BABYLON.MeshBuilder.CreateSphere('bulb', { diameter: 0.1 }, scene)
      pointMesh.receiveShadows = false
      pointMesh.position.y = 4
      const pointMat = new BABYLON.StandardMaterial('pointMat', scene)
      pointMat.emissiveColor = new BABYLON.Color3(1, 1, 1)
      pointMat.alpha = 0.5
      pointMesh.material = pointMat
      const pointBulb = new BABYLON.MeshBuilder.CreateSphere('pointBulb', { diameter: 0.05 }, scene)
      const pointBulbMat = new BABYLON.StandardMaterial('pointBulbMat', scene)
      pointBulbMat.emissiveColor = new BABYLON.Color3(1, 1, 1)
      pointBulb.material = pointBulbMat
      pointBulb.parent = pointMesh

      const pointLight = new BABYLON.PointLight('pointLight', new BABYLON.Vector3(0, 0, 0), scene)
      pointLight.intensity = 5
      pointLight.parent = pointMesh
      pointLight.position.x = 0

      const pointShadow = new BABYLON.ShadowGenerator(1024 * 1, pointLight)
      pointShadow.bias = 0.00001
      // pointShadow.usePercentageCloserFiltering = true
      // shadowGenerator.useContactHardeningShadow = true

      //  TwoSidedBox
      const twoSidedBox = this.createTwoSidedBox(10, 10, 10, 0, scene)
      twoSidedBox.receiveShadows = true
      const pbr = new BABYLON.PBRMetallicRoughnessMaterial('pbr', scene)
      pbr.metallic = 0
      pbr.roughness = 1
      twoSidedBox.material = pbr

      pointShadow.addShadowCaster(twoSidedBox)

      return scene
    },
    createBox (width, height, depth, scene) {
      const mesh = new BABYLON.Mesh('customBox', scene)
      const vertices = MeshVertices.Box({
        width,
        height,
        depth
      })
      const indices = []
      const totalIndices = vertices.length / 3
      for (let i = 0; i < totalIndices; i++) {
        indices.push(i)
      }
      const normals = []

      BABYLON.VertexData.ComputeNormals(vertices, indices, normals)
      const vertexData = new BABYLON.VertexData()

      vertexData.positions = vertices
      vertexData.indices = indices
      vertexData.normals = normals

      vertexData.applyToMesh(mesh)

      return mesh
    },
    createTwoSidedBox (width, height, depth, thickness, scene) {
      const mesh = new BABYLON.Mesh('customBox', scene)
      const vertices = MeshVertices.TwoSidedBox({
        width,
        height,
        depth,
        thickness
      })
      const indices = []
      const totalIndices = vertices.length / 3
      for (let i = 0; i < totalIndices; i++) {
        indices.push(i)
      }
      const normals = []

      BABYLON.VertexData.ComputeNormals(vertices, indices, normals)
      const vertexData = new BABYLON.VertexData()

      vertexData.positions = vertices
      vertexData.indices = indices
      vertexData.normals = normals

      vertexData.applyToMesh(mesh)

      return mesh
    }
  }
}
</script>

<style scoped>

html, body {
  overflow: hidden;
  width   : 100%;
  height  : 100%;
  margin  : 0;
  padding : 0;
}
.babylonCanvas{
  width: 100%;
  height: 100%;
  touch-action: none;
}
</style>
-->