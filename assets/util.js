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
  }
}

export default util
