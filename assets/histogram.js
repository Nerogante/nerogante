import util from 'assets/util'

const histogram = {
  getHistograms (data) {
    const histR = new Uint32Array(256)
    const histG = new Uint32Array(256)
    const histB = new Uint32Array(256)

    const len = data.length
    for (let i = 0; i < len; i += 4) {
      histR[data[i] & 0xFF]++
      histG[data[i + 1] & 0xFF]++
      histB[data[i + 2] & 0xFF]++
    }
    const highestR = util.maxHistogramPoint(histR)
    const highestG = util.maxHistogramPoint(histG)
    const highestB = util.maxHistogramPoint(histB)

    const factorR = 100 / highestR
    const factorG = 100 / highestG
    const factorB = 100 / highestB

    for (let i = 0; i < 256; i++) {
      histR[i] = util.clamp(histR[i] * factorR, 0, 100)
      histG[i] = util.clamp(histG[i] * factorG, 0, 100)
      histB[i] = util.clamp(histB[i] * factorB, 0, 100)
    }
    return [histR, histG, histB]
  },
  drawHistogram (ctx, histogram, height = 100) {
    ctx.beginPath()
    for (let i = 0; i < 256; i++) {
      ctx.moveTo(i + 0.5, height)
      ctx.lineTo(i + 0.5, height - histogram[i])
    }
    ctx.stroke()
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
