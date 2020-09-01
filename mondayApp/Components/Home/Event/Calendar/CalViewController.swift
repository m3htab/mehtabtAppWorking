import SwiftUI

struct CalViewController: View {
    
    @ObservedObject var calendarManager: CalendarManager
    @EnvironmentObject var filterViewModel: FilterViewModel
    var body: some View {
        VStack {
            WeekdayHeader(calendarManager: self.calendarManager)
            
            ScrollView {
                VStack {
                    ForEach(0..<numberOfMonths()) { index in
                        CalendarMonth(calendarManager: self.calendarManager, monthOffset: index).environmentObject(self.filterViewModel)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }
    
    func numberOfMonths() -> Int {
        let maxMonth = calendarManager.getMonth(date: calendarManager.maximumDate)
        let minMonth = calendarManager.getMonth(date: calendarManager.minimumDate)
        if(maxMonth == minMonth){
            return 1
        }else{
            return 2
        }
    }
    
    func maximumDateMonthLastDay() -> Date {
        var components = calendarManager.calendar.dateComponents([.year, .month, .day], from: calendarManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return calendarManager.calendar.date(from: components)!
    }
    
    func minimumDateMonthFirstDay() -> Date {
        var components = calendarManager.calendar.dateComponents([.year, .month, .day], from: calendarManager.minimumDate)
        components.month! -= 1
        components.day = 0
        
        return calendarManager.calendar.date(from: components)!
    }
}


