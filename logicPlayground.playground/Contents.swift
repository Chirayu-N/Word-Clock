import Cocoa

// current time
let now = Date()
let calendar = Calendar.current
var hour = calendar.component(.hour, from: now) % 12    // hour, 12-hour time
if (hour == 0) {
    hour = 12
}
var minute = calendar.component(.minute, from: now)

print(String(hour) + ":" + String(minute))

// word equivalents
let hourWords = ["ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE"]
let minuteWords = ["FIVE", "TEN", "QUARTER", "TWENTY", "TWENTY FIVE", "HALF"]

// time to words

// IT IS ___ O'CLOCK
if (minute / 5 == 0) {
    print("IT IS " + hourWords[hour - 1] + " O'CLOCK")
}

// IT IS ___ PAST HOUR
else if (minute <= 30) {
    print("IT IS " + minuteWords[minute/5 - 1] + " PAST " + hourWords[hour - 1])
}

// IT IS FIVE TO HOUR
else if (minute > 55) { // handle 56-59 edge case
    print("IT IS " + minuteWords[0] + " TO " + hourWords[hour % 12])
}

// IT IS ___ TO HOUR
else if (minute > 30) {
    print("IT IS " + minuteWords[(60 - minute)/5 - 1] + " TO " + hourWords[hour % 12])
}

