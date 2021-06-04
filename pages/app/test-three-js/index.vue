<!--<template>
  <div>
    <section>
      <v-container fluid class="pa-0">
        <div ref="olap" />
      </v-container>
    </section>
  </div>
</template>

<script>
// import ToolCard from '~/components/ToolCard'
// import util from 'assets/util'
import { mapMutations } from 'vuex'
// import { mat4 } from 'gl-matrix'
import * as THREE from 'three'

export default {
  components: {
    // ToolCard
    // Darken 4 lighten 5
  },
  data () {
    return {
      colors: [
        'red', 'pink', 'purple', 'deep-purple', 'indigo', 'blue', 'light-blue', 'cyan', 'teal', 'green', 'light-green', 'lime', 'yellow', 'amber', 'orange', 'deep-orange', 'brown', 'blue-grey', 'grey'
      ],
      colorVariants: [
        'lighten', 'darken'
      ],
      colorAlones: [
        'black', 'white', 'transparent'
      ],
      shapes: [

      ],
      camera: null,
      scene: null,
      renderer: null
    }
  },
  computed: {

  },
  mounted () {
    this.$store.commit('appBar/setApp', false)
    this.$store.commit('appBar/setFixed', true)
    // const fbxLoader = require('three/examples/jsm/loaders/FBXLoader.js')
    // const loader = new fbxLoader.FBXLoader()

    // console.log(GLTFLoader)
    // const loader = require('three/examples/jsm/loaders/GLTFLoader.js')
    // const GLTFLoader = new loader.GLTFLoader()

    this.initialize()
    // loader.load('3d/asd.fbx', function (gltf) {
    //   console.log(gltf)
    //   this.scene.add(gltf.scene)
    // }, undefined, function (error) {
    //   console.error(error)
    // })

    // GLTFLoader.load('3d/2/scene.gltf', function (gltf) {
    //   // console.log(gltf.scene)
    //   this.scene.add(gltf.scene)
    // }, undefined, function (error) {
    //   console.error(error)
    // })
  },
  methods: {
    initialize () {
      this.scene = new THREE.Scene()
      this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
      this.renderer = new THREE.WebGLRenderer({ alpha: true })

      // this.renderer.shadowMap.enabled = true
      this.renderer.shadowMap.enabled = true
      this.renderer.shadowMap.type = THREE.PCFSoftShadowMap

      this.renderer.toneMapping = THREE.ReinhardToneMapping

      const controlsReq = require('three/examples/jsm/controls/OrbitControls')
      const controls = new controlsReq.OrbitControls(this.camera, this.renderer.domElement)

      this.renderer.setSize(window.innerWidth, window.innerHeight)
      this.renderer.setClearColor(new THREE.Color('rgb( 64, 64, 64)'), 1)
      this.$refs.olap.appendChild(this.renderer.domElement)

      this.camera.position.z = 5
      controls.update()

      // Cube 1
      const cube1 = this.createCube(1, 1, 1)
      cube1.position.x = -1
      this.scene.add(cube1)

      // Inside Box
      const room = this.createInsideBox(10, 10, 10)
      this.scene.add(room)

      // Sphere 1
      const geometry = new THREE.SphereGeometry(1, 64, 64)
      const material = new THREE.MeshPhysicalMaterial({
        color: 0xFFFFFF,
        metalness: 1
      })
      const sphere = new THREE.Mesh(geometry, material)
      sphere.castShadow = true
      sphere.receiveShadow = true
      sphere.position.x = 1
      this.scene.add(sphere)

      // // Add Directional Light
      // const directionalLight = new THREE.DirectionalLight(new THREE.Color(1, 1, 1), 1)
      // directionalLight.position.set(0, 10, 0)
      // directionalLight.target.position.set(0, 0, -5)
      // directionalLight.castShadow = true
      // this.scene.add(directionalLight)
      // this.scene.add(directionalLight.target)

      // // Add Ambient Light
      // const ambientLight = new THREE.HemisphereLight(0xB1E1FF, 0xB97A20, 1)
      // this.scene.add(ambientLight)

      // Light
      const PointLight = new THREE.PointLight(new THREE.Color(1, 1, 1), 1)
      PointLight.castShadow = true
      PointLight.position.y = 0
      PointLight.decay = 2
      PointLight.shadow.radius = 10
      PointLight.shadow.mapSize.width = 2048
      PointLight.shadow.mapSize.height = 2048
      this.scene.add(PointLight)

      const update = () => {
        requestAnimationFrame(update)
        cube1.rotation.x += 0.005
        cube1.rotation.y += 0.005
        sphere.rotation.x += 0.01
        sphere.rotation.y += 0.01
        this.renderer.render(this.scene, this.camera)
      }
      update()
    },
    animate () {

    },
    createCube (width, height, depth) {
      const geometry = new THREE.BufferGeometry()
      width *= 0.5
      height *= 0.5
      depth *= 0.5

      const vertices = new Float32Array([
        // Front
        -1 * width, -1 * height, 1 * depth,
        1 * width, -1 * height, 1 * depth,
        1 * width, 1 * height, 1 * depth,

        1 * width, 1 * height, 1 * depth,
        -1 * width, 1 * height, 1 * depth,
        -1 * width, -1 * height, 1 * depth,

        // Right
        1 * width, -1 * height, 1 * depth,
        1 * width, -1 * height, -1 * depth,
        1 * width, 1 * height, -1 * depth,

        1 * width, -1 * height, 1 * depth,
        1 * width, 1 * height, -1 * depth,
        1 * width, 1 * height, 1 * depth,

        // Back
        1 * width, -1 * height, -1 * depth,
        -1 * width, -1 * height, -1 * depth,
        -1 * width, 1 * height, -1 * depth,

        1 * width, -1 * height, -1 * depth,
        -1 * width, 1 * height, -1 * depth,
        1 * width, 1 * height, -1 * depth,

        // Left
        -1 * width, -1 * height, -1 * depth,
        -1 * width, -1 * height, 1 * depth,
        -1 * width, 1 * height, 1 * depth,

        -1 * width, -1 * height, -1 * depth,
        -1 * width, 1 * height, 1 * depth,
        -1 * width, 1 * height, -1 * depth,

        // Top
        -1 * width, 1 * height, 1 * depth,
        1 * width, 1 * height, 1 * depth,
        1 * width, 1 * height, -1 * depth,

        -1 * width, 1 * height, 1 * depth,
        1 * width, 1 * height, -1 * depth,
        -1 * width, 1 * height, -1 * depth,

        // Bottom
        -1 * width, -1 * height, -1 * depth,
        1 * width, -1 * height, -1 * depth,
        1 * width, -1 * height, 1 * depth,

        -1 * width, -1 * height, -1 * depth,
        1 * width, -1 * height, 1 * depth,
        -1 * width, -1 * height, 1 * depth

      ])

      geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3))
      const material = new THREE.MeshPhysicalMaterial({ color: new THREE.Color('rgb(180,180,180)') })
      const mesh = new THREE.Mesh(geometry, material)
      mesh.geometry.computeVertexNormals()
      mesh.geometry.normalsNeedUpdate = true
      mesh.castShadow = true
      mesh.receiveShadow = true
      return mesh
    },
    createInsideBox (width, height, depth) {
      const geometry = new THREE.BufferGeometry()
      width *= 0.5
      height *= 0.5
      depth *= 0.5

      const vertices = new Float32Array([
        // Front
        -1 * width, -1 * height, -1 * depth,
        1 * width, -1 * height, -1 * depth,
        1 * width, 1 * height, -1 * depth,

        1 * width, 1 * height, -1 * depth,
        -1 * width, 1 * height, -1 * depth,
        -1 * width, -1 * height, -1 * depth,

        // Right
        -1 * width, -1 * height, 1 * depth,
        -1 * width, -1 * height, -1 * depth,
        -1 * width, 1 * height, -1 * depth,

        -1 * width, -1 * height, 1 * depth,
        -1 * width, 1 * height, -1 * depth,
        -1 * width, 1 * height, 1 * depth,

        // Back
        1 * width, -1 * height, 1 * depth,
        -1 * width, -1 * height, 1 * depth,
        -1 * width, 1 * height, 1 * depth,

        1 * width, -1 * height, 1 * depth,
        -1 * width, 1 * height, 1 * depth,
        1 * width, 1 * height, 1 * depth,

        // Left
        1 * width, -1 * height, -1 * depth,
        1 * width, -1 * height, 1 * depth,
        1 * width, 1 * height, 1 * depth,

        1 * width, -1 * height, -1 * depth,
        1 * width, 1 * height, 1 * depth,
        1 * width, 1 * height, -1 * depth,

        // Top
        -1 * width, -1 * height, 1 * depth,
        1 * width, -1 * height, 1 * depth,
        1 * width, -1 * height, -1 * depth,

        -1 * width, -1 * height, 1 * depth,
        1 * width, -1 * height, -1 * depth,
        -1 * width, -1 * height, -1 * depth,

        // Bottom
        -1 * width, 1 * height, -1 * depth,
        1 * width, 1 * height, -1 * depth,
        1 * width, 1 * height, 1 * depth,

        -1 * width, 1 * height, -1 * depth,
        1 * width, 1 * height, 1 * depth,
        -1 * width, 1 * height, 1 * depth

      ])

      geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3))
      const material = new THREE.MeshPhysicalMaterial({ color: new THREE.Color('rgb(180,180,180)') })
      const mesh = new THREE.Mesh(geometry, material)
      mesh.geometry.computeVertexNormals()
      mesh.geometry.normalsNeedUpdate = true
      mesh.castShadow = true
      mesh.receiveShadow = true
      return mesh
    },

    ...mapMutations({
      toggleHidden: 'appBar/toggleHidden'
    })
  },
  head () {
    return {
      title: 'Creepy Player',
      meta: [
        { hid: 'description', name: 'description', contant: 'Very Useless Site' }
      ]
    }
  }
}
</script>

<style>
.mainCanvas{
  height: 100%;
  width: 100%;
}
</style>
-->