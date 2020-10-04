//
//  RKDate.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKDate {
    
    var date: Date
    let rkManager: RKManager
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false
    var isBetweenStartAndEnd: Bool = false
    var tasks: [Task]
    
    init(date: Date, rkManager: RKManager, isDisabled: Bool, isToday: Bool, isSelected: Bool, isBetweenStartAndEnd: Bool, tasks: [Task] = []) {
        self.date = date
        self.rkManager = rkManager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isBetweenStartAndEnd = isBetweenStartAndEnd
        self.tasks = tasks
    }
    
    func decideThatDateIncludesTask() -> Bool {
        tasks.contains(where: { $0.date.day == self.date.day })
    }
    
    func isAllTasksDone() -> Bool {
        return !(selectedDateTasks.map({ $0.isChecked }).filter({ !$0 }).count > 0)
    }
    
    var selectedDateTasks: [Task] {
        return tasks.filter({ $0.date.day == self.date.day })
    }
    
    func getText() -> String {
        let day = formatDate(date: date, calendar: self.rkManager.calendar)
        return day
    }
    
    func getTextColor() -> Color {
        var textColor = rkManager.colors.textColor
        if isDisabled {
            textColor = rkManager.colors.disabledColor
        } else if isSelected {
            textColor = rkManager.colors.selectedColor
        } else if isToday {
            textColor = rkManager.colors.todayColor
        } else if isBetweenStartAndEnd {
            textColor = rkManager.colors.betweenStartAndEndColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = rkManager.colors.textBackColor
        if isBetweenStartAndEnd {
            backgroundColor = rkManager.colors.betweenStartAndEndBackColor
        }
        if isToday {
            backgroundColor = rkManager.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = rkManager.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = rkManager.colors.selectedBackColor
        }
        return backgroundColor
    }
    
    // Or decide to color depends on the all tasks completed or not
    func getIsCellIncludeTaskDotColor() -> Color {
        if isAllTasksDone() {
            return rkManager.colors.selectedBackColor
        }
        return rkManager.colors.disabledColor
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.regular
        } else if isToday {
            fontWeight = Font.Weight.regular
        } else if isBetweenStartAndEnd {
            fontWeight = Font.Weight.regular
        }
        return fontWeight
    }
    
    // MARK: - Date Formats
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
}

