const Vector3 = class {
  x = 0
  y = 0
  z = 0
  constructor (x, y, z) {
    this.x = x
    this.y = y
    this.z = z
  }

  static get forward () {
    return new Vector3(0, 0, 1)
  }

  static get back () {
    return new Vector3(0, 0, -1)
  }

  static get right () {
    return new Vector3(1, 0, 0)
  }

  static get left () {
    return new Vector3(-1, 0, 0)
  }

  static get up () {
    return new Vector3(0, 1, 0)
  }

  static get down () {
    return new Vector3(0, -1, 0)
  }

  static get zero () {
    return new Vector3(0, 0, 0)
  }

  static get one () {
    return new Vector3(1, 1, 1)
  }
}

export default Vector3
