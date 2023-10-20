//
//  ContentView.swift
//  Word Clock
//
//  Created by Chirayu Nimonkar on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    private var minute:Int
    private var hour:Int
    init() {
        // current time
        let now = Date()
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: now) % 12
        if (hour == 0) {
            hour = 12
        }
        minute = calendar.component(.minute, from: now)
//        print(String(hour) + ":" + String(minute))
    }
    
    func isSelected(_ word: String, _ wordType: Character) -> Bool {
        // word equivalents
        let hourWords = ["ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE"]
        let minuteWords = ["FIVE", "TEN", "QUARTER", "TWENTY", "TWENTY FIVE", "HALF"]
        
        // time to words
        
        // IT IS ___ O'CLOCK
        if (minute / 5 == 0) {
            if ((word == hourWords[hour - 1] && wordType == "h") || word == "O'CLOCK") {
                return true
            }
            return false
        }
        
        // IT IS ___ PAST HOUR
        else if (minute <= 30) {
            // edge case: "TWENTY FIVE" (targeting two minute words)
            if (minuteWords[minute/5 - 1] == "TWENTY FIVE" && (word == "TWENTY" || (word == "FIVE" && wordType == "m"))) {
                return true
            }
            if ((word == minuteWords[minute/5 - 1] && wordType == "m")  || word == "PAST" || (word == hourWords[hour - 1] && wordType == "h")) {
                return true
            }
            return false
        }
        
        // IT IS FIVE TO HOUR
        else if (minute > 55) { // handle 56-59 edge case
            if ((word == minuteWords[0] && wordType == "m") || word == "TO" || (word == hourWords[hour % 12] && wordType == "h")) {
                return true
            }
            return false
        }
        
        // IT IS ___ TO HOUR
        else if (minute > 30) {
            if ((word == minuteWords[(60 - minute)/5 - 1] && wordType == "m") || word == "TO" || (word == hourWords[hour % 12] && wordType == "h")) {
                return true
            }
            return false
        }
        return false
    }
    
    var body: some View {
        
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack {
                Text("IT") + Text("M").foregroundColor(.gray) + Text("IS") + Text("I").foregroundColor(.gray) + Text("TWENTY").foregroundColor(isSelected("TWENTY", "m") ? .black : .gray)
                
                Text("QUARTER").foregroundColor(isSelected("QUARTER", "m") ? .black : .gray) + Text("HALF").foregroundColor(isSelected("HALF", "m") ? .black : .gray) + Text("M").foregroundColor(.gray)
                
                Text("TEN").foregroundColor(isSelected("TEN", "m") ? .black : .gray) + Text("FIVE").foregroundColor(isSelected("FIVE", "m") ? .black : .gray) + Text("E").foregroundColor(.gray) + Text("PAST").foregroundColor(isSelected("PAST", "m") ? .black : .gray)
                
                Text("TO").foregroundColor(isSelected("TO", "m") ? .black : .gray) + Text("A").foregroundColor(.gray) + Text("TWELVE").foregroundColor(isSelected("TWELVE", "h") ? .black : .gray) + Text("ONE").foregroundColor(isSelected("ONE", "h") ? .black : .gray)
                
                Text("TWO").foregroundColor(isSelected("TWO", "h") ? .black : .gray) + Text("THREE").foregroundColor(isSelected("THREE", "h") ? .black : .gray) + Text("FOUR").foregroundColor(isSelected("FOUR", "h") ? .black : .gray)
                
                Text("FIVE").foregroundColor(isSelected("FIVE", "h") ? .black : .gray) + Text("SIX").foregroundColor(isSelected("SIX", "h") ? .black : .gray) + Text("SEVEN").foregroundColor(isSelected("SEVEN", "h") ? .black : .gray)
                
                Text("EIGHT").foregroundColor(isSelected("EIGHT", "h") ? .black : .gray) + Text("NINE").foregroundColor(isSelected("NINE", "h") ? .black : .gray) + Text("TEN").foregroundColor(isSelected("TEN", "h") ? .black : .gray)
                
                Text("ELEVEN").foregroundColor(isSelected("ELEVEN", "h") ? .black : .gray) + Text("EL").foregroundColor(.gray) + Text("WORD").foregroundColor(.black)
                
                Text("O'CLOCK").foregroundColor(isSelected("O'CLOCK", "h") ? .black : .gray) + Text("O").foregroundColor(.gray) + Text("TIME").foregroundColor(.black)
            }
            .padding()
            .font(.title)
            .monospaced()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
