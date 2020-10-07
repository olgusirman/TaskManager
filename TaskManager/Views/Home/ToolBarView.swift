//
//  ToolBarView.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ToolBarView: View {
    
    @ObservedObject var sheetRouter: SheetRouter
    
    static let listButtonEdge: CGFloat = buttonHeight / 2
    static let buttonHeight: CGFloat = 44
    static let fillButtonEdge: CGFloat = 28
    
    @State private var showActionSheet = false
    
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
                        self.sheetRouter.sheetDestination = .addProject
                    },
                    .default(Text("Add Task")) {
                        self.sheetRouter.sheetDestination = .addTask
                    },
                ]
            )
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
        ToolBarView(sheetRouter: SheetRouter())
    }
}
