/**
 * Data source: https://coinmarketcap.com/currencies/bitcoin/historical-data/?start=20171216&end=20190518
 */

// Data
var records = document.getElementsByClassName("cmc-table-row")
var parsedRecords = []

// Model
class CandlestickInfo {
    constructor(date, open, high, low, close, volume, marketCap) {
        this.date = date
        this.open = open
        this.high = high
        this.low = low
        this.close = close
        this.volume = volume
        this.marketCap = marketCap
    }

    toString() {
        return `${this.date} - Open ${this.open}, Close ${this.close}, Volume ${this.volume}`
    }
}

// Parse function
function parseCardElement(rawEle) {
    // Filter out empty element
    if (rawEle.children.length == 0)
        return

    let date = rawEle.children[0].children[0].textContent
    // Note that we should remove all commas
    // https://flaviocopes.com/how-to-replace-all-occurrences-string-javascript/
    let open = rawEle.children[1].children[0].textContent.split(',').join('')
    let high = rawEle.children[2].children[0].textContent.split(',').join('')
    let low = rawEle.children[3].children[0].textContent.split(',').join('')
    let close = rawEle.children[4].children[0].textContent.split(',').join('')
    let volume = rawEle.children[5].children[0].textContent.split(',').join('')
    let marketCap = rawEle.children[6].children[0].textContent.split(',').join('')

    let newCard = new CandlestickInfo(date, parseFloat(open), parseFloat(high),
        parseFloat(low), parseFloat(close), parseFloat(volume), parseFloat(marketCap))
    parsedRecords.push(newCard)

    console.log(`${newCard}`)
}

// Parse all records, and put result into parsedRecordss, note that records is not an 
// normal array, so we need to construct an standard array via Array.from()
Array.from(records).forEach(parseCardElement)

// Convert parsedRecords arr to json string
var parsedRecordsJsonStr = JSON.stringify(parsedRecords)

// Copy variable from chrome dev tools console to clipboard
copy(parsedRecordsJsonStr)
