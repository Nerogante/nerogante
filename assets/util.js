const util = {
  formatBytes (a, b = 2) { if (a === 0) { return '0 Bytes' } const c = b < 0 ? 0 : b; const d = Math.floor(Math.log(a) / Math.log(1024)); return parseFloat((a / 1024 ** d).toFixed(c)) + ' ' + ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][d] },
  getRndInteger (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min
  },
  getTrueRandomInteger (min, max) {
    return Math.floor(Math.random() * (max - min)) + min
  },
  clamp (number, min, max) {
    return number <= min ? min : number >= max ? max : number
  },
  findPercentage (number, a, b) {
    return (number - a) / (b - a)
  },
  maxInArray (array) {
    let max = array[0]
    const len = array.length
    for (let i = 1; i < len; i++) {
      if (array[i] > max) {
        max = array[i]
      }
    }
    return max
  },
  minInArray (array) {
    let min = array[0]
    const len = array.length
    for (let i = 1; i < len; i++) {
      if (array[i] < min) {
        min = array[i]
      }
    }
    return min
  },
  secondMaxInArray (array) {
    let max = array[0]
    let second = 0
    const len = array.length
    for (let i = 0; i < len; i++) {
      if (array[i] > max) {
        second = max
        max = array[i]
      }
    }
    return second
  },
  thirdMaxInArray (array) {
    let max = array[0]
    let second = 0
    let third = 0
    const len = array.length
    for (let i = 0; i < len; i++) {
      if (array[i] > max) {
        third = second
        second = max
        max = array[i]
      }
    }
    return third
  },
  maxHistogramPoint (array) {
    let max = array[1]
    const len = array.length - 1
    for (let i = 1; i < len; i++) {
      if (array[i] > max) {
        max = array[i]
      }
    }
    return max
  },
  calculateStrength (average, peak, offset) {
    let strength
    if (average > peak) {
      if (average > peak + offset) {
        strength = 0
      } else {
        strength = util.findPercentage(average, peak + offset, peak)
      }
    } else if (average < peak) {
      if (average < peak - offset) {
        strength = 0
      } else {
        strength = util.findPercentage(average, peak - offset, peak)
      }
    } else {
      strength = 1
    }
    return util.clamp(Math.abs(strength), 0, 1)
  }
}

export default util
