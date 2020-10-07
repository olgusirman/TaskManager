//
//  ToolBarView.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

// FIXME: Don't care too much for now, There is a new ToolBar component in iOS-14
struct ToolBarView: View {
    static let listButtonEdge: CGFloat = buttonHeight / 2
    private static let buttonHeight: CGFloat = 44
    private static let fillButtonEdge: CGFloat = 28
    
    // TODO: Need actions to here for tabbar buttons
    @State private var showActionSheet = false
    @State private var presentAddTaskView = false
    @State private var presentAddProjectView = false
    
    @State private var presentAddView = false
    
    enum ToolBarPresentedView {
        case addTask
        case addProject
    }
    
    @State private var willPresentedView: ToolBarPresentedView = .addTask
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: ActivityView()
            ) {
                Image(systemName: "list.bullet")
                    .configureTabIcon()
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)
            Spacer()
            Button(action: {
                self.showActionSheet = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .configureTabIcon()
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)
            
            Spacer()
            
            NavigationLink(
                destination: ProjectCalendarView()
            ) {
                Image(systemName: "calendar")
                    .configureTabIcon()
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)
            
        }.actionSheet(isPresented: $showActionSheet) {
            //TODO: Use custom ActinSheet here, migrate from UIKit with images
            ActionSheet(
                title: Text(""),
                message: nil,
                buttons: [
                    .cancel { debugPrint(self.showActionSheet) },
                    .default(Text("Add Project")) {
                        self.willPresentedView = .addProject
                        self.presentAddView = true
                    },
                    .default(Text("Add Task")) {
                        self.willPresentedView = .addTask
                        self.presentAddView = true
                    },
                ]
            )
        }.sheet(isPresented: $presentAddView) {
            if self.willPresentedView == .addTask {
                AddTaskView()
            } else if self.willPresentedView == .addProject {
                AddProjectView()
            }
        }
    }
}

fileprivate extension Image {
    
    func configureTabIcon() -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: ToolBarView.listButtonEdge, height: ToolBarView.listButtonEdge)
    }
    
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView()
    }
}
