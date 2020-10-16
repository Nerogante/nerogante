// import Vector3 from 'assets/Vector3'

const MeshVertices = {
  Box () {
    const args = Array.from(arguments)[0]

    let width = args.width ? args.width : 1
    let height = args.height ? args.height : 1
    let depth = args.depth ? args.depth : 1

    width *= 0.5
    height *= 0.5
    depth *= 0.5

    const vertices = [
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

    ]
    return vertices
  },
  TwoSidedBox () {
    const args = Array.from(arguments)[0]

    let width = args.width ? args.width : 1
    let height = args.height ? args.height : 1
    let depth = args.depth ? args.depth : 1
    const thickness = args.thickness ? args.thickness : 0.1

    width *= 0.5
    height *= 0.5
    depth *= 0.5

    const vertices = [
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

    ]
    width -= thickness
    height -= thickness
    depth -= thickness

    const verticesInset = [
      // Front
      -1 * width, -1 * height, -1 * depth * -1,
      1 * width, -1 * height, -1 * depth * -1,
      1 * width, 1 * height, -1 * depth * -1,

      1 * width, 1 * height, -1 * depth * -1,
      -1 * width, 1 * height, -1 * depth * -1,
      -1 * width, -1 * height, -1 * depth * -1,

      // Right
      -1 * width * -1, -1 * height, 1 * depth,
      -1 * width * -1, -1 * height, -1 * depth,
      -1 * width * -1, 1 * height, -1 * depth,

      -1 * width * -1, -1 * height, 1 * depth,
      -1 * width * -1, 1 * height, -1 * depth,
      -1 * width * -1, 1 * height, 1 * depth,

      // Back
      1 * width, -1 * height, 1 * depth * -1,
      -1 * width, -1 * height, 1 * depth * -1,
      -1 * width, 1 * height, 1 * depth * -1,

      1 * width, -1 * height, 1 * depth * -1,
      -1 * width, 1 * height, 1 * depth * -1,
      1 * width, 1 * height, 1 * depth * -1,

      // Left
      1 * width * -1, -1 * height, -1 * depth,
      1 * width * -1, -1 * height, 1 * depth,
      1 * width * -1, 1 * height, 1 * depth,

      1 * width * -1, -1 * height, -1 * depth,
      1 * width * -1, 1 * height, 1 * depth,
      1 * width * -1, 1 * height, -1 * depth,

      // Top
      -1 * width, -1 * height * -1, 1 * depth,
      1 * width, -1 * height * -1, 1 * depth,
      1 * width, -1 * height * -1, -1 * depth,

      -1 * width, -1 * height * -1, 1 * depth,
      1 * width, -1 * height * -1, -1 * depth,
      -1 * width, -1 * height * -1, -1 * depth,

      // Bottom
      -1 * width, 1 * height * -1, -1 * depth,
      1 * width, 1 * height * -1, -1 * depth,
      1 * width, 1 * height * -1, 1 * depth,

      -1 * width, 1 * height * -1, -1 * depth,
      1 * width, 1 * height * -1, 1 * depth,
      -1 * width, 1 * height * -1, 1 * depth

    ]
    const arrayNew = vertices.concat(verticesInset)
    return arrayNew
  }
}

export default MeshVertices
