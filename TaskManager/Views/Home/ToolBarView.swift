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
    private static let buttonHeight: CGFloat = 44
    private static let listButtonEdge: CGFloat = buttonHeight / 2
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
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ToolBarView.listButtonEdge, height: ToolBarView.listButtonEdge)
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)
            Spacer()
            Button(action: {
                debugPrint("Toolbar plus pressed")
                self.showActionSheet = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ToolBarView.fillButtonEdge, height: ToolBarView.fillButtonEdge)
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)

            Spacer()
            
            NavigationLink(
                destination: ProjectCalendarView()
            ) {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ToolBarView.listButtonEdge, height: ToolBarView.listButtonEdge)
            }
            .frame(width: ToolBarView.buttonHeight, height: ToolBarView.buttonHeight)
        
        }.actionSheet(isPresented: $showActionSheet) {
            //TODO: Use custom ActinSheet here, migrate from UIKit with images
            ActionSheet(
                title: Text(""),
                message: nil,
                buttons: [
                    .cancel { print(self.showActionSheet) },
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

struct customSheet: View {
    @Binding var showActionSheet: Bool

    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.spring()) {
                    self.showActionSheet = false
                }
            }) {
                HStack {
                    Image(systemName: "camera")
                    Spacer()
                    Text("Take a picture")
                    Spacer()
                }
            }

            Button(action: {
                withAnimation(.spring()) {
                    self.showActionSheet = false
                }
            }) {
                HStack {
                    Image(systemName: "camera")
                    Spacer()
                    Text("Take a picture")
                    Spacer()
                }
            }
            Divider()
            Button(action: {
                withAnimation {
                    self.showActionSheet = false
                }
            }) {
                HStack {
                    Image(systemName: "trash")
                    Spacer()
                    Text("Delete")
                    Spacer()
                }
            }.foregroundColor(.red)
        }
    }
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView()
    }
}
