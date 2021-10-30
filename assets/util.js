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
  findPercentageClamped (number, a, b) {
    const result = (number - a) / (b - a)
    if (result <= 0) {
      return 0
    }
    if (result >= 1) {
      return 1
    }
    return result
  },
  lerp (a, b, f) {
    return (a * (1.0 - f)) + (b * f)
  },
  slerp (a, b, t) {
    Math.sin((1 - t) * Math.pi)
  },
  getArrayIndexFrom2dPos (x, y, width) {
    return width * y + x
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
    for (let i = 2; i < len; i++) {
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
  },
  degrees_to_radians (degrees) {
    const pi = Math.PI
    return degrees * (pi / 180)
  },
  radians_to_degrees (radians) {
    const pi = Math.PI
    return radians * (180 / pi)
  },
  getCircleY (radians, radius) {
    return Math.sin(radians) * radius
  },
  mean (array) {
    const len = array.length
    let sum = 0
    for (let i = 0; i < len; i++) {
      sum += array[i]
    }
    return sum / len
  },
  rangedMean (array, levels) {
    const levelLen = levels.length
    const means = Array(levelLen)
    const sums = Array(levelLen)
    const counts = Array(levelLen)
    for (let i = 0; i < levelLen; i++) {
      sums[i] = 0
      counts[i] = 0
    }
    const len = array.length
    for (let i = 0; i < len; i++) {
      for (let j = 0; j < levelLen; j++) {
        if (array[i] < levels[j][1]) {
          sums[j] += array[i]
          counts[j]++
          break
        }
      }
    }
    for (let i = 0; i < levelLen; i++) {
      means[i] = sums[i] / counts[i]
    }
    return means
  },
  exportArray (array) {
    const len = array.length
    let text = '['
    for (let i = 0; i < len; i++) {
      text += array[i]
      if (i < 256 - 1) {
        text += ', '
      }
    }
    text += ']'
    console.log(text)
  },
  exportArrayIndexed (array) {
    const len = array.length
    let text = ''
    for (let i = 0; i < len; i++) {
      text += '[' + i + ', ' + array[i] + ']'
      if (i < 256 - 1) {
        text += ', '
      }
    }
    console.log(text)
  },
  delay (time) {
    return new Promise(resolve => setTimeout(resolve, time))
  }
}

export default util
