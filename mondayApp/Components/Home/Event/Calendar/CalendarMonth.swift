import SwiftUI

struct CalendarMonth: View {
    
    @ObservedObject var calendarManager: CalendarManager
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    let monthOffset: Int
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth = CGFloat(32)
    
    @State var showTime = false
    
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            Text(getMonthHeader()).foregroundColor(self.calendarManager.colors.monthHeaderColor)
            VStack(alignment: .leading, spacing: 15) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack() {
                        ForEach(row, id:  \.self) { column in
                            HStack() {
                                Spacer()
                                if self.isThisMonth(date: column) {
                                    CalCell(calDate: CalDate(
                                        date: column,
                                        calendarManager: self.calendarManager,
                                        isDisabled: !self.isEnabled(date: column),
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSpecialDate(date: column),
                                        isBetweenStartAndEnd: self.isBetweenStartAndEnd(date: column)),
                                        cellWidth: self.cellWidth)
                                        .onTapGesture { self.dateTapped(date: column) }
                                } else {
                                    Text("").frame(width: self.cellWidth, height: self.cellWidth)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            
        }.background(calendarManager.colors.monthForwardColor)
    }

     func isThisMonth(date: Date) -> Bool {
         return self.calendarManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
        if self.isEnabled(date: date) {
            switch self.calendarManager.mode {
            case 0:
                if self.calendarManager.selectedDate != nil &&
                    self.calendarManager.calendar.isDate(self.calendarManager.selectedDate, inSameDayAs: date) {
                    self.calendarManager.selectedDate = nil
                } else {
                    self.calendarManager.selectedDate = date
                }
            case 1:
                self.calendarManager.startDate = date
                self.calendarManager.endDate = nil
                self.calendarManager.mode = 2
            case 2:
                self.calendarManager.endDate = date
                if self.isStartDateAfterEndDate() {
                    self.calendarManager.endDate = nil
                    self.calendarManager.startDate = nil
                }
                self.calendarManager.mode = 1
            case 3:
                if self.calendarManager.selectedDatesContains(date: date) {
                    if let ndx = self.calendarManager.selectedDatesFindIndex(date: date) {
                        self.filterViewModel.RemoveSelectedDate(position: ndx)
                    }
                } else {
                    self.filterViewModel.AddDateToSelected(date: date)
                }
            default:
                self.calendarManager.selectedDate = date
            }
        }
    }
     
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = calendarManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: calendarManager.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = calendarManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - calendarManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek


        //var finishOffset = weekday - calendarManager.calendar.firstWeekday
        //finishOffset -= finishOffset <= 0 ? daysPerWeek : 0

        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset
        
        return calendarManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }
    
    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = calendarManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return calendarManager.calendar.date(byAdding: offset, to: firstDateMonth())!
    }
    
    func lastOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return calendarManager.calendar.date(byAdding: offset, to: lastDateMonth())!
    }
    
    func formatDate(date: Date) -> Date {
        let components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return calendarManager.calendar.date(from: components)!
    }
    
    func formatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = formatDate(date: referenceDate)
        let clampedDate = formatDate(date: date)
        return refDate == clampedDate
    }
    
    func firstDateMonth() -> Date {
        var components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: calendarManager.minimumDate)
        components.day = 1
        
        return calendarManager.calendar.date(from: components)!
    }

    func lastDateMonth() -> Date {
        var components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: calendarManager.maximumDate)
        components.day = 1
        
        return calendarManager.calendar.date(from: components)!
    }
    
    // MARK: - Date Property Checkers
    
    func isToday(date: Date) -> Bool {
        return formatAndCompareDate(date: date, referenceDate: Date())
    }
     
    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date) ||
            isStartDate(date: date) ||
            isEndDate(date: date) ||
            isOneOfSelectedDates(date: date)
    }
    
    func isOneOfSelectedDates(date: Date) -> Bool {
        return self.calendarManager.selectedDatesContains(date: date)
    }

    func isSelectedDate(date: Date) -> Bool {
        if calendarManager.selectedDate == nil {
            return false
        }
        return formatAndCompareDate(date: date, referenceDate: calendarManager.selectedDate)
    }
    
    func isStartDate(date: Date) -> Bool {
        if calendarManager.startDate == nil {
            return false
        }
        return formatAndCompareDate(date: date, referenceDate: calendarManager.startDate)
    }
    
    func isEndDate(date: Date) -> Bool {
        if calendarManager.endDate == nil {
            return false
        }
        return formatAndCompareDate(date: date, referenceDate: calendarManager.endDate)
    }
    
    func isBetweenStartAndEnd(date: Date) -> Bool {
        if calendarManager.startDate == nil {
            return false
        } else if calendarManager.endDate == nil {
            return false
        } else if calendarManager.calendar.compare(date, to: calendarManager.startDate, toGranularity: .day) == .orderedAscending {
            return false
        } else if calendarManager.calendar.compare(date, to: calendarManager.endDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func isOneOfDisabledDates(date: Date) -> Bool {
        return self.calendarManager.disabledDatesContains(date: date)
    }
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = formatDate(date: date)
        if calendarManager.calendar.compare(clampedDate, to: calendarManager.minimumDate, toGranularity: .day) == .orderedAscending || calendarManager.calendar.compare(clampedDate, to: calendarManager.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return !isOneOfDisabledDates(date: date)
    }
    
    func isStartDateAfterEndDate() -> Bool {
        if calendarManager.startDate == nil {
            return false
        } else if calendarManager.endDate == nil {
            return false
        } else if calendarManager.calendar.compare(calendarManager.endDate, to: calendarManager.startDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}



