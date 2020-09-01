import SwiftUI

struct WeekdayHeader : View {
    
    var calendarManager: CalendarManager
     
    var body: some View {
        HStack(alignment: .center) {
            ForEach(self.getWeekdayHeaders(calendar: self.calendarManager.calendar), id: \.self) { weekday in
                Text(weekday)
                    .font(.system(size: 14))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(self.calendarManager.colors.weekdayHeaderColor)
            }
        }.background(calendarManager.colors.weekdayHeaderBackColor)
    }
    
    func getWeekdayHeaders(calendar: Calendar) -> [String] {
        
        var weekdaySymbols = Calendar.current.shorterWeekdaySymbols

        let weekdaySymbolsCount = weekdaySymbols.count
        
        for _ in 0 ..< (1 - calendar.firstWeekday + weekdaySymbolsCount){
            let lastObject = weekdaySymbols.last
            weekdaySymbols.removeLast()
            weekdaySymbols.insert(lastObject!, at: 0)
        }
        
        return weekdaySymbols 
    }
}

extension Calendar {
    var shorterWeekdaySymbols: [String] {
        return symbolsFor("EEEEE")
    }
    
    private func symbolsFor(_ format: String) -> [String] {
        let df = DateFormatter()
        df.locale = self.locale
        df.calendar = self
        df.dateFormat = format
        let weekdays = self.range(of: .weekday, in: .year, for: Date())!
        return weekdays.map {
            let date = self.nextDate(after: Date(), matching: DateComponents(weekday: $0), matchingPolicy: .strict)!
            return df.string(from: date)
        }
    }
}


