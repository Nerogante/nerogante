import util from 'assets/util'

const histogram = {
  separateChannels (view8) {
    const channelSize = view8.length * 0.25
    const channelR = new Uint8ClampedArray(channelSize)
    const channelG = new Uint8ClampedArray(channelSize)
    const channelB = new Uint8ClampedArray(channelSize)

    const len = view8.length
    for (let i = 0, j = 0; i < len; i += 4, j++) {
      channelR[j] = view8[i]
      channelG[j] = view8[i + 1]
      channelB[j] = view8[i + 2]
    }
    return [channelR, channelG, channelB]
  },
  getHistograms (data) {
    const histR = new Uint32Array(256)
    const histG = new Uint32Array(256)
    const histB = new Uint32Array(256)

    const len = data.length
    for (let i = 0; i < len; i += 4) {
      histR[data[i] & 0b11111111]++
      histG[data[i + 1] & 0xFF]++
      histB[data[i + 2] & 0xFF]++
    }

    const counts = [histR[0], histR[255], histG[0], histG[255], histB[0], histB[255]]

    const highestR = util.maxInArray(histR)
    const highestG = util.maxInArray(histG)
    const highestB = util.maxInArray(histB)

    const factorR = 100 / highestR
    const factorG = 100 / highestG
    const factorB = 100 / highestB

    for (let i = 0; i < 256; i++) {
      histR[i] = histR[i] > 0 ? util.clamp(histR[i] * factorR, 1, 100) : 0
      histG[i] = histG[i] > 0 ? util.clamp(histG[i] * factorG, 1, 100) : 0
      histB[i] = histB[i] > 0 ? util.clamp(histB[i] * factorB, 1, 100) : 0
    }
    return [histR, histG, histB, counts]
  },
  drawHistogram (ctx, histogram, height = 100) {
    ctx.beginPath()
    for (let i = 0; i < 256; i++) {
      ctx.moveTo(i + 0.5, height)
      ctx.lineTo(i + 0.5, height - histogram[i])
    }
    ctx.stroke()
    // ctx.beginPath
    // for (let i = 0; i < 256; i++) {

    // }
  },
  shiftChannel (channel, amount) {
    const len = channel.length
    for (let i = 0; i < len; i++) {
      channel[i] += amount
    }
  },
  getShiftAuto (channel, treshold = 0) {
    const counted = this.getCount(channel)
    const half = channel.length / 2
    let leftCount = 0
    let halfIndex = 0

    for (let i = 0; i < 256; i++) {
      leftCount += counted[i]
      halfIndex = i
      if (leftCount >= half) {
        break
      }
    }
    const shiftByHalf = 128 - halfIndex
    console.log('half', half, 'leftCount', leftCount, 'halfIndex', halfIndex, 'shiftByHalf', shiftByHalf)
    let sumL = counted[0]
    let leftIndex = 0
    let sumR = counted[255]
    let rightIndex = 255

    if (sumL <= treshold) {
      for (let i = 0; i < 256; i++) {
        sumL += counted[i]
        leftIndex = i
        if (sumL > treshold) {
          break
        }
      }
    }
    if (sumR <= treshold) {
      for (let i = 255; i >= 0; i--) {
        sumR += counted[i]
        rightIndex = i
        if (sumR > treshold) {
          break
        }
      }
    }
    rightIndex = 256 - rightIndex
    const shiftValue = parseInt((-leftIndex + rightIndex) / 2)
    const gap = leftIndex + shiftValue
    console.log('shiftValue', shiftValue, 'gap', gap)
    return [shiftByHalf, leftIndex, rightIndex, gap]
  },
  histogramEqualization (channel) {
    const counted = this.getCount(channel)
    const cdf = this.getCdf(counted)
    const min = util.minInArray(channel)
    const max = util.maxInArray(channel)
    this.equalizeLevel(channel, cdf, min, max)
    return channel
  },
  getChannel (array, index) {
    const data = new Uint8ClampedArray(array.length / 4)
    const len = array.length
    for (let i = index, j = 0; i < len; i += 4, j++) {
      data[j] = array[i]
    }
    return data
  },
  getCount (channel) {
    const counted = new Uint32Array(256)
    const len = channel.length
    for (let i = 0; i < len; i++) {
      counted[channel[i] & 0xFF]++
      // for (let j = 0; j < 256; j++) {
      //   if (channelArray[i] === j) {
      //     counted[j]++
      //     break
      //   }
      // }
    }
    return counted
  },
  getCdf (countedArray) {
    const cdf = new Uint32Array(countedArray)
    const len = countedArray.length
    for (let i = 1; i < len; i++) {
      cdf[i] += cdf[i - 1]
    }
    return cdf
  },
  equalizeLevel (channel, cdf, min, max) {
    // const factor = 1 / 255
    const len = channel.length
    for (let i = 0; i < len; i++) {
      channel[i] = Math.round((cdf[channel[i]] - cdf[min]) / (len - cdf[min]) * 255)
    }
  },
  spread (channel, amount) {
    const len = channel.length
    let dir = 1
    let distance = 0
    for (let i = 0; i < len; i++) {
      dir = channel[i] < 128 ? -1 : 1
      // distance = util.findPercentage(channel[i], 128, dir === 1 ? 255 : 0)
      distance = (channel[i] - 128) / (dir === 1 ? 255 : 0 - 128)
      channel[i] += (distance * dir * amount)
    }
  },
  getSpreadAuto (gap) {
    const distanceL = (gap - 128) / (0 - 128)
    const finalL = (gap / distanceL)
    // const distanceR = (255 - gap - 128) / (255 - 128)
    // const finalR = (255 - gap / distanceR)
    // console.log('gap:', gap, 'distanceL:', distanceL, 'finalLAmount', finalL)
    // console.log('rightGap:', 255 - gap, 'distanceR:', distanceR, 'finalRAmount', finalR)

    return finalL
  },
  drawRGB (histR, histG, histB, ctx) {
    ctx.strokeStyle = '#ff4040'
    ctx.beginPath()
    for (let i = 0; i < 256; i++) {
      ctx.moveTo(i + 0.5, 100)
      ctx.lineTo(i + 0.5, 100 - histR[i])
    }
    ctx.stroke()
    ctx.strokeStyle = '#40ff40'
    ctx.beginPath()
    for (let i = 0; i < 256; i++) {
      ctx.moveTo(i + 0.5, 100 - histR[i])
      ctx.lineTo(i + 0.5, 100 - histG[i])
    }
    ctx.stroke()
    ctx.strokeStyle = '#4040ff'
    ctx.beginPath()
    for (let i = 0; i < 256; i++) {
      ctx.moveTo(i + 0.5, 100 - Math.max(histG[i], histR[i]))
      ctx.lineTo(i + 0.5, 100 - histB[i])
    }
    ctx.stroke()
  },
  processImage (inImg) {
    // const width = inImg.width
    // const height = inImg.height
    const src = new Uint32Array(inImg.data.buffer)
    const isValueHistogram = true

    const histBrightness = (new Array(256)).fill(0)
    const histR = (new Array(256)).fill(0)
    const histG = (new Array(256)).fill(0)
    const histB = (new Array(256)).fill(0)

    for (let i = 0; i < src.length; i++) {
      const r = src[i] & 0xFF
      const g = (src[i] >> 8) & 0xFF
      const b = (src[i] >> 16) & 0xFF
      histBrightness[r]++
      histBrightness[g]++
      histBrightness[b]++
      histR[r]++
      histG[g]++
      histB[b]++
    }

    let maxBrightness = 0
    if (isValueHistogram) {
      for (let i = 1; i < 256; i++) {
        if (maxBrightness < histBrightness[i]) {
          maxBrightness = histBrightness[i]
        }
      }
    } else {
      for (let i = 0; i < 256; i++) {
        if (maxBrightness < histR[i]) {
          maxBrightness = histR[i]
        } else if (maxBrightness < histG[i]) {
          maxBrightness = histG[i]
        } else if (maxBrightness < histB[i]) {
          maxBrightness = histB[i]
        }
      }
    }

    const canvas = document.getElementById('canvasHistogram')
    const ctx = canvas.getContext('2d')
    const guideHeight = 8
    const startY = (canvas.height - guideHeight)
    const dx = canvas.width / 256
    const dy = startY / maxBrightness
    ctx.lineWidth = dx
    ctx.fillStyle = '#fff'
    ctx.fillRect(0, 0, canvas.width, canvas.height)

    for (let i = 0; i < 256; i++) {
      const x = i * dx
      if (isValueHistogram) {
        // Value
        ctx.strokeStyle = '#000000'
        ctx.beginPath()
        ctx.moveTo(x, startY)
        ctx.lineTo(x, startY - histBrightness[i] * dy)
        ctx.closePath()
        ctx.stroke()
      } else {
        // Red
        ctx.strokeStyle = 'rgba(220,0,0,0.5)'
        ctx.beginPath()
        ctx.moveTo(x, startY)
        ctx.lineTo(x, startY - histR[i] * dy)
        ctx.closePath()
        ctx.stroke()
        // Green
        ctx.strokeStyle = 'rgba(0,210,0,0.5)'
        ctx.beginPath()
        ctx.moveTo(x, startY)
        ctx.lineTo(x, startY - histG[i] * dy)
        ctx.closePath()
        ctx.stroke()
        // Blue
        ctx.strokeStyle = 'rgba(0,0,255,0.5)'
        ctx.beginPath()
        ctx.moveTo(x, startY)
        ctx.lineTo(x, startY - histB[i] * dy)
        ctx.closePath()
        ctx.stroke()
      }
      // Guide
      ctx.strokeStyle = 'rgb(' + i + ', ' + i + ', ' + i + ')'
      ctx.beginPath()
      ctx.moveTo(x, startY)
      ctx.lineTo(x, canvas.height)
      ctx.closePath()
      ctx.stroke()
    }
  },
  previewFast () {
    console.log('prev')
    const lowestPixel = this.lowestPixel
    const highestPixel = this.highestPixel

    const tempdata = this.tempData.data

    const canvas = this.getCurrentCanvas()
    const context = canvas.getContext('2d')
    const imageData = context.createImageData(canvas.width, canvas.height)
    const length = imageData.data.length

    const buf = new ArrayBuffer(length)
    const buf8 = new Uint8ClampedArray(buf)
    const data = new Uint32Array(buf)

    const shadowsValue = this.modalBrightness.controls[0].value
    const shadowsPeak = 0
    const shadowsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

    const darksValue = this.modalBrightness.controls[1].value
    const darksPeak = 0.25
    const darksOffset = (highestPixel - lowestPixel) / 5 / highestPixel

    const midsValue = this.modalBrightness.controls[2].value
    const midsPeak = 0.5
    const midsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

    const brightsValue = this.modalBrightness.controls[3].value
    const brightsPeak = 0.75
    const brightsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

    const highlightsValue = this.modalBrightness.controls[4].value
    const highlightsPeak = 1
    const highlightsOffset = (highestPixel - lowestPixel) / 5 / highestPixel

    const divisor = 1 / 3 / highestPixel

    let r, g, b, average
    let shadowsToAdd, darksToAdd, midsToAdd, brightsToAdd, highlightsToAdd

    for (let i = 0, j = 0; i < length; i += 4, j++) {
      r = tempdata[i]
      g = tempdata[i + 1]
      b = tempdata[i + 2]

      average = (r + g + b) * divisor

      shadowsToAdd = this.calculateStrength(average, shadowsPeak, shadowsOffset) * shadowsValue
      darksToAdd = this.calculateStrength(average, darksPeak, darksOffset) * darksValue
      midsToAdd = this.calculateStrength(average, midsPeak, midsOffset) * midsValue
      brightsToAdd = this.calculateStrength(average, brightsPeak, brightsOffset) * brightsValue
      highlightsToAdd = this.calculateStrength(average, highlightsPeak, highlightsOffset) * highlightsValue

      const finalSum = shadowsToAdd + darksToAdd + midsToAdd + brightsToAdd + highlightsToAdd
      r += finalSum
      g += finalSum
      b += finalSum

      r = util.clamp(r, 0, 255)
      g = util.clamp(g, 0, 255)
      b = util.clamp(b, 0, 255)

      data[j] =
      (255 << 24) | // alpha
      (b << 16) | // blue
      (g << 8) | // green
        r // red
    }
    imageData.data.set(buf8)
    context.putImageData(imageData, 0, 0)
  }
}

export default histogram
