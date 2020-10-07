//
//  SheetRouter.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation
import SwiftUI

protocol NavigatorProtocol: ObservableObject {
    associatedtype SheetDestination
    func sheetView() -> AnyView
}

final class SheetRouter: NavigatorProtocol {
    
    @Published var showSheet = false
    var sheetDestination: SheetDestination = .none {
        didSet {
            self.showSheet = true
        }
    }
    
    enum SheetDestination {
        case none
        case profile
        case addProject
        case addTask
    }
    
    func sheetView() -> AnyView {
        switch sheetDestination {
        case .none:
            return AnyView(Text("None"))
        case .profile:
            return AnyView(ProfileView())
        case .addProject:
            return AnyView(AddProjectView())
        case .addTask:
            return AnyView(AddTaskView())
        }
    }
}
