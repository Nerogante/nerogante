
let viewLength: i32
let channelLength: i32
let width: i32
let height: i32
const viewOffsets = new StaticArray<u32>(4)
const countOffsets = new StaticArray<u32>(4)
const displayCountOffsets = new StaticArray<u32>(4)

declare function consoleLog(arg0: i32): void;
declare function consoleFloat(arg0: f32): void;
const curve = new Float32Array(256)

export function initData (_width: i32, _height: i32, _totalViews: u32): void {
  width = _width
  height = _height
  channelLength = width * height
  viewLength = channelLength * 4

  let arrayOffset = 0
  for (let i: u32 = 0; i < _totalViews; i++) {
    viewOffsets[i] = arrayOffset
    arrayOffset += viewLength
  }
  for (let i: u32 = 0; i < _totalViews; i++) {
    countOffsets[i] = arrayOffset
    arrayOffset += (256 * 4 * 3)
  }
  for (let i: u32 = 0; i < _totalViews; i++) {
    displayCountOffsets[i] = arrayOffset
    arrayOffset += (256 * 3)
  }
  const vals = [0.5019607843137255, 0.5058823529411764, 0.5098039215686274, 0.5137254901960784, 0.5176470588235295, 0.5215686274509804, 0.5254901960784314, 0.5294117647058824, 0.5333333333333333, 0.5372549019607843, 0.5411764705882353, 0.5450980392156862, 0.5490196078431373, 0.5529411764705883, 0.5568627450980392, 0.5607843137254902, 0.5647058823529412, 0.5686274509803921, 0.5725490196078431, 0.5764705882352941, 0.5803921568627451, 0.5843137254901961, 0.5882352941176471, 0.592156862745098, 0.596078431372549, 0.6, 0.6039215686274509, 0.6078431372549019, 0.611764705882353, 0.615686274509804, 0.6196078431372549, 0.6235294117647059, 0.6274509803921569, 0.6313725490196078, 0.6352941176470588, 0.6392156862745098, 0.6431372549019608, 0.6470588235294118, 0.6509803921568628, 0.6549019607843137, 0.6588235294117647, 0.6627450980392157, 0.6666666666666666, 0.6705882352941176, 0.6745098039215687, 0.6784313725490196, 0.6823529411764706, 0.6862745098039216, 0.6901960784313725, 0.6941176470588235, 0.6980392156862745, 0.7019607843137254, 0.7058823529411765, 0.7098039215686275, 0.7137254901960784, 0.7176470588235294, 0.7215686274509804, 0.7254901960784313, 0.7294117647058823, 0.7333333333333333, 0.7372549019607844, 0.7411764705882353, 0.7450980392156863, 0.7490196078431373, 0.7529411764705882, 0.7568627450980392, 0.7607843137254902, 0.7647058823529411, 0.7686274509803922, 0.7725490196078432, 0.7764705882352941, 0.7803921568627451, 0.7843137254901961, 0.788235294117647, 0.792156862745098, 0.796078431372549, 0.8, 0.803921568627451, 0.807843137254902, 0.8117647058823529, 0.8156862745098039, 0.8196078431372549, 0.8235294117647058, 0.8274509803921568, 0.8313725490196079, 0.8352941176470589, 0.8392156862745098, 0.8431372549019608, 0.8470588235294118, 0.8509803921568627, 0.8549019607843137, 0.8588235294117647, 0.8627450980392157, 0.8666666666666667, 0.8705882352941177, 0.8745098039215686, 0.8784313725490196, 0.8823529411764706, 0.8862745098039215, 0.8901960784313725, 0.8941176470588236, 0.8980392156862745, 0.9019607843137255, 0.9058823529411765, 0.9098039215686274, 0.9137254901960784, 0.9176470588235294, 0.9215686274509803, 0.9254901960784314, 0.9294117647058824, 0.9333333333333333, 0.9372549019607843, 0.9411764705882353, 0.9450980392156862, 0.9490196078431372, 0.9529411764705882, 0.9568627450980393, 0.9607843137254902, 0.9647058823529412, 0.9686274509803922, 0.9725490196078431, 0.9764705882352941, 0.9803921568627451, 0.984313725490196, 0.9882352941176471, 0.9921568627450981, 0.996078431372549, 1, 1, 0.996078431372549, 0.9921568627450981, 0.9882352941176471, 0.984313725490196, 0.9803921568627451, 0.9764705882352941, 0.9725490196078431, 0.9686274509803922, 0.9647058823529412, 0.9607843137254902, 0.9568627450980393, 0.9529411764705882, 0.9490196078431372, 0.9450980392156862, 0.9411764705882353, 0.9372549019607843, 0.9333333333333333, 0.9294117647058824, 0.9254901960784314, 0.9215686274509803, 0.9176470588235294, 0.9137254901960784, 0.9098039215686274, 0.9058823529411765, 0.9019607843137255, 0.8980392156862745, 0.8941176470588236, 0.8901960784313725, 0.8862745098039215, 0.8823529411764706, 0.8784313725490196, 0.8745098039215686, 0.8705882352941177, 0.8666666666666667, 0.8627450980392157, 0.8588235294117647, 0.8549019607843137, 0.8509803921568627, 0.8470588235294118, 0.8431372549019608, 0.8392156862745098, 0.8352941176470589, 0.8313725490196079, 0.8274509803921568, 0.8235294117647058, 0.8196078431372549, 0.8156862745098039, 0.8117647058823529, 0.807843137254902, 0.803921568627451, 0.8, 0.796078431372549, 0.792156862745098, 0.788235294117647, 0.7843137254901961, 0.7803921568627451, 0.7764705882352941, 0.7725490196078432, 0.7686274509803922, 0.7647058823529411, 0.7607843137254902, 0.7568627450980392, 0.7529411764705882, 0.7490196078431373, 0.7450980392156863, 0.7411764705882353, 0.7372549019607844, 0.7333333333333333, 0.7294117647058823, 0.7254901960784313, 0.7215686274509804, 0.7176470588235294, 0.7137254901960784, 0.7098039215686275, 0.7058823529411765, 0.7019607843137254, 0.6980392156862745, 0.6941176470588235, 0.6901960784313725, 0.6862745098039216, 0.6823529411764706, 0.6784313725490196, 0.6745098039215687, 0.6705882352941176, 0.6666666666666666, 0.6627450980392157, 0.6588235294117647, 0.6549019607843137, 0.6509803921568628, 0.6470588235294118, 0.6431372549019608, 0.6392156862745098, 0.6352941176470588, 0.6313725490196078, 0.6274509803921569, 0.6235294117647059, 0.6196078431372549, 0.615686274509804, 0.611764705882353, 0.6078431372549019, 0.6039215686274509, 0.6, 0.596078431372549, 0.592156862745098, 0.5882352941176471, 0.5843137254901961, 0.5803921568627451, 0.5764705882352941, 0.5725490196078431, 0.5686274509803921, 0.5647058823529412, 0.5607843137254902, 0.5568627450980392, 0.5529411764705883, 0.5490196078431373, 0.5450980392156862, 0.5411764705882353, 0.5372549019607843, 0.5333333333333333, 0.5294117647058824, 0.5254901960784314, 0.5215686274509804, 0.5176470588235295, 0.5137254901960784, 0.5098039215686274, 0.5058823529411764, 0.5019607843137255]
  for (let i = 0; i < 256; i++) {
    curve[i] = f32(vals[i])
  }
}

export function process (runPercentileStretch: bool, runGrayWorld: bool, keepBalance: bool, limit: i32, limitValue: i32, balanceStrength: i32): void {
  // Run percentile stretch
  if (runPercentileStretch) {
    const clips = new Uint8ClampedArray(6)
    clips[1] = 255
    clips[3] = 255
    clips[5] = 255
    
    if (limitValue >= 0) {
      let countOffset = countOffsets[0]
      for (let chan = 0; chan < 3; chan++) {
        const limitL: u32 = limit + load<u32>(countOffset)
        const limitR: u32 = limit + load<u32>(countOffset + 255 * 4)
        let sumL: u32 = 0
        let sumR: u32 = 0
        let clipL: u8 = 0
        let clipR: u8 = 255
        for (let i: i32 = 0; i <= 255; i++) {
          sumL += load<u32>(countOffset + i * 4)
          if (sumL <= limitL) {
            clipL = i as u8
          } else {
            break
          }
        }
        for (let i: i32 = 255; i >= 0; i--) {
          sumR += load<u32>(countOffset + i * 4)
          if (sumR <= limitR) {
            clipR = i as u8
          } else {
            break
          }
        }
        clips[0 + chan * 2] = clipL
        clips[1 + chan * 2] = clipR
        countOffset += 256 * 4
      }
    }

    if (keepBalance) {
      let minL = clips[0]
      minL = clips[2] < minL ? clips[2] : minL
      minL = clips[4] < minL ? clips[4] : minL

      clips[0] = minL
      clips[2] = minL
      clips[4] = minL

      let maxR = clips[1]
      maxR = clips[3] > maxR ? clips[3] : maxR
      maxR = clips[5] > maxR ? clips[5] : maxR

      clips[1] = maxR
      clips[3] = maxR
      clips[5] = maxR
    }
    // 

    const rfactor: f32 = 1.0 / (unchecked(clips[1]) - unchecked(clips[0])) * 255
    const gfactor: f32 = 1.0 / (unchecked(clips[3]) - unchecked(clips[2])) * 255
    const bfactor: f32 = 1.0 / (unchecked(clips[5]) - unchecked(clips[4])) * 255

    let value: u32 = 0
    let r: i16 = 0
    let g: i16 = 0
    let b: i16 = 0
    let rCurve: f32 = 1
    let gCurve: f32 = 1
    let bCurve: f32 = 1
    const rclipL = unchecked(clips[0])
    const gclipL = unchecked(clips[2])
    const bclipL = unchecked(clips[4])

    const resultOffset = viewOffsets[1]

    for (let i = 0; i < viewLength; i += 4) {
      // value = load<u32>(i + viewLength)
      // r = f32(value & 0xff)
      // g = f32(value >> 8 & 0xff)
      // b = f32(value >> 16 & 0xff) 
      r = load<u8>(i)
      g = load<u8>(i + 1) 
      b = load<u8>(i + 2)
      rCurve = unchecked(curve[(r)])
      gCurve = unchecked(curve[(g)])
      bCurve = unchecked(curve[(b)])


      r = <i16>((r * (1.0 - rCurve)) + (r - rclipL) * rfactor * rCurve)
      g = <i16>((g * (1.0 - gCurve)) + (g - gclipL) * gfactor * gCurve)
      b = <i16>((b * (1.0 - bCurve)) + (b - bclipL) * bfactor * bCurve)

      // r = (r > 255) ? 255 : (r < 0) ? 0 : r
      // g = (g > 255) ? 255 : (g < 0) ? 0 : g
      // b = (b > 255) ? 255 : (b < 0) ? 0 : b

      // r = r < 0 ? 0 : r
      // r = r > 255 ? 255 : r
      // g = g < 0 ? 0 : g
      // g = g > 255 ? 255 : g
      // b = b < 0 ? 0 : b
      // b = b > 255 ? 255 : b

      // r = <i16>Math.min(Math.max(r, 0), 255)
      if (r > 255) {
        r = 255
      } else if (r < 0) {
        r = 0
      }
      if (g > 255) {
        g = 255
      } else if (g < 0) {
        g = 0
      }
      if (b > 255) {
        b = 255
      } else if (b < 0) {
        b = 0
      }
      // store<u32>(i, 0b11111111000000000000000000000000 | 
      //   (u32(b) << 16) | 
      //   (u32(g) << 8) | 
      //   u32(r))
      store<u8>(resultOffset + i, (r))
      store<u8>(resultOffset + i + 1,(g))
      store<u8>(resultOffset + i + 2, (b))
    }
    calculateCounts(1)
    calculateDisplayCounts(1)
  }
  // End percentile stretch

  // Run gray world
  if (runGrayWorld) {
    // calculateCounts(1)
    // grayWorld(balanceStrength)
  }
  // End gray world
}
export function calculateClips (limit: i32, limitValue: i32):void {
  
}

export function grayWorld (strength: i32): void {
  let sumR: f32 = 0
  let sumG: f32 = 0
  let sumB: f32 = 0

  const viewStart = viewLength * 2
  const viewEnd = viewStart + viewLength

  for (let i = viewStart; i < viewEnd; i += 4) {
    sumR += load<u8>(i)
    sumG += load<u8>(i + 1)
    sumB += load<u8>(i + 2)
  }
  const meanR: u32 = u32(sumR / f32(channelLength))
  const meanG: u32 = u32(sumG / f32(channelLength))
  const meanB: u32 = u32(sumB / f32(channelLength))

  const factorR: f32 = 128 / f32(meanR)
  const factorG: f32 = 128 / f32(meanG)
  const factorB: f32 = 128 / f32(meanB)

  let r: f32 = 0
  let g: f32 = 0
  let b: f32 = 0
  let newR: f32 = 0
  let newG: f32 = 0
  let newB: f32 = 0

  const f: f32 = f32(strength) * 0.1
  const aCache: f32 = 1.0 -f
  const bCacheR = factorR * f
  const bCacheG = factorG * f
  const bCacheB = factorB * f

  // (a * (1.0 - f)) + (b * f)
  for (let i = 0; i < viewLength; i += 4) {
    r = f32(load<u8>(i))
    g = f32(load<u8>(i + 1))
    b = f32(load<u8>(1 + 2))

    newR = (r * aCache) + (r * bCacheR)
    newG = (g * aCache) + (g * bCacheG)
    newB = (b * aCache) + (b * bCacheB)

    if (newR > 255) {
      newR = 255
    } else if (newR < 0) {
      newR = 0
    }
    if (newG > 255) {
      newG = 255
    } else if (newG < 0) {
      newG = 0
    }
    if (newB > 255) {
      newB = 255
    } else if (newB < 0) {
      newB = 0
    }
    store<u8>(i, u8(newR))
    store<u8>(i + 1, u8(newG))
    store<u8>(i + 2, u8(newB))
  }
}

export function calculateCounts (index: u32): void {
  clearCounts(index)
  const _viewOffset = viewOffsets[index]
  const _countOffset = countOffsets[index]
  const viewEnd = _viewOffset  + viewLength
  let countIndexR: u32 = 0
  let countIndexG: u32 = 0
  let countIndexB: u32 = 0
  for (let i = _viewOffset; i < viewEnd; i += 4) {
    countIndexR = _countOffset + 4 * load<u8>(i)
    countIndexG = _countOffset + 4 * load<u8>(i + 1) + 1024
    countIndexB = _countOffset + 4 * load<u8>(i + 2) + 2048

    store<u32>(countIndexR, load<u32>(countIndexR) + 1)
    store<u32>(countIndexG, load<u32>(countIndexG) + 1)
    store<u32>(countIndexB, load<u32>(countIndexB) + 1)
  }
}

export function calculateDisplayCounts (index: u32): void {
  clearDisplayCounts(index)
  const _countOffset = countOffsets[index]
  const _displayCountOffset = displayCountOffsets[index]
  let maxR: i32 = 0
  let maxG: i32 = 0
  let maxB: i32 = 0
  const endCount = _countOffset + 256 * 4
  for (let i = _countOffset; i < endCount; i += 4) {
    const r = load<i32>(i)
    const g = load<i32>(i + 256 * 4)
    const b = load<i32>(i + 512 * 4)
    if (r > maxR) {
      maxR = r
    }
    if (g > maxG) {
      maxG = g
    }
    if (b > maxB) {
      maxB = b
    }
  }
  const factorR: f32 = 100.0 / <f32>maxR
  const factorG: f32 = 100.0 / <f32>maxG
  const factorB: f32 = 100.0 / <f32>maxB

  for (let i = _countOffset, d = _displayCountOffset; i < endCount; i += 4, d++) {
    const r: f32 = <f32>load<i32>(i)
    const g: f32 = <f32>load<i32>(i + 256 * 4)
    const b: f32 = <f32>load<i32>(i + 512 * 4)

    let newR: i32 = 0
    let newG: i32 = 0
    let newB: i32 = 0

    if (g > 0) {
      newR = <i32>(factorR * r)
      if (newR < 1) {
        newR = 1
      } else if (newR > 100) {
        newR = 100
      }
    }
    if (g > 0) {
      newG = <i32>(factorG * g)
      if (newG < 1) {
        newG = 1
      } else if (newG > 100) {
        newG = 100
      }
    }
    if (b > 0) {
      newB = <i32>(factorB * b)
      if (newB < 1) {
        newB = 1
      } else if (newB > 100) {
        newB = 100
      }
    }

    store<u8>(d, <u8>newR)
    store<u8>(d + 256, <u8>(newG))
    store<u8>(d + 512, <u8>(newB))
  }

  // consoleLog(maxR)
  // consoleLog(maxG)
  // consoleLog(maxB)
  // const leftR: i32 = load<i32>(_countOffset)
  // const rightR: i32 = load<i32>(_countOffset + 255 * 4)
  // consoleLog(leftR)
  // consoleLog(rightR)
}

function clearCounts (index: u32): void {
  const countOffset = countOffsets[index]
  const endCountCache: u32 = countOffset + (256 * 4 * 3)
  for (let i: u32 = countOffset; i < endCountCache; i += 4) {
    store<u32>(i, 0)
  }
}

function clearDisplayCounts (index: u32): void {
  const displayCountOffset = displayCountOffsets[index]
  const endDisplayCount: u32 = displayCountOffset + (256 * 3)
  for (let i: u32 = displayCountOffset; i < endDisplayCount; i++) {
    store<u8>(i, 0)
  }
}
// [view8]  [view8original] [view8cache]  [counts]      [countsOriginal]
// [Full]   [Full]          [full]        [256 * 4 * 3] [256 * 4 * 3]
