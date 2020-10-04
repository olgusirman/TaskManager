//
//  CalendarView.swift
//  TaskManager
//
//  Created by Olgu on 13.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

// TODO: organize all formatters to one place
let monthNameFormatter = DateFormatter()
let headerFormatter = DateFormatter()

struct ProjectCalendarView: View {
    
    @State fileprivate var selectedDate = Date()
    
    fileprivate var tasks: [Task] = mockTasks
    fileprivate var monthName: String {
        monthNameFormatter.dateFormat = "MMMM" // current month name format
        return monthNameFormatter.string(from: Date())
    }
    
    fileprivate var headerName: String {
        headerFormatter.dateFormat = "E, MMM d" // current month name format
        return headerFormatter.string(from: selected ?? Date())
    }
    
    
    @ObservedObject var rkManager = RKManager(calendar: Calendar.current,
                                              minimumDate: Date().beginning(of: .month) ?? Date(),
                                              maximumDate: Date().endOfMonth,
                                              mode: 0)
    
    var selected: Date? {
        if rkManager.selectedDate != nil {
            return rkManager.selectedDate
        }
        return nil
    }
    
    var isThereAnyTaskInThatDate: Bool {
        if let selected = selected {
            return tasks.contains(where: { $0.date.day == selected.day })
        }
        return false
    }
    
    var selectedDateTasks: [Task] {
        if let selected = selected {
            return tasks.filter({ $0.date.day == selected.day })
        }
        return []
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                RKWeekdayHeader(rkManager: self.rkManager).padding([.horizontal])
                Divider()
                // Month View
                RKTaskManagerMonth(rkManager: self.rkManager, monthOffset: 0)
                
                if isThereAnyTaskInThatDate {
                    Text(headerName)
                        .fontWeight(.semibold)
                    LazyVStack {
                        ForEach(selectedDateTasks) { task in
                            HomeTaskRow(task: task)
                        }
                    }
                }
                
            }.padding()
                .navigationBarTitle(Text(monthName), displayMode: .automatic)
            
        }
    }
    
    private var leading: some View {
        Text("TUESDAY, MAY 12")
            .font(.footnote)
            .foregroundColor(.secondary)
            .bold()
    }
    
}

extension Date {
    
    var calendar: Calendar {
        // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
        return Calendar(identifier: Calendar.current.identifier)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    /// SwifterSwift: Yesterday date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    var yesterday: Date {
        return calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }

    /// SwifterSwift: Tomorrow's date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let tomorrow = date.tomorrow // "Oct 4, 2018, 10:57:11"
    ///
    var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }
    
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCalendarView()
    }
}
