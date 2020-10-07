//
//  ContentView.swift
//  TaskManager
//
//  Created by Olgu on 17.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var sheetRouter = SheetRouter()
    
    @State private var searchText = ""
    @State private var showActionSheet = false
    @State private var navigateToActivityItem = false
    @State private var navigateToCalendar = false

    private var tasks: [Task] = []
    
    var body: some View {
        if userManager.isLoggedIn {
            contentView
        } else {
            LoginView()
                .environmentObject(self.userManager)
        }
    }
    
    private var loginView: some View {
        LoginView()
    }
    
    private var contentView: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: ActivityView(), isActive: self.$navigateToActivityItem) { EmptyView() }
                NavigationLink(destination: ProjectCalendarView(), isActive: self.$navigateToCalendar) { EmptyView() }
                                
                VStack { // MainVStack
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            SearchBar(text: $searchText).padding([.leading, .trailing], 4)
                            HomeContentView(cardWidth: cardWidth)
                        }
                        Spacer()
                    }.resignKeyboardOnDragGesture()
                }
            }
            .navigationBarTitle("Today")
            .navigationBarItems(leading: leading, trailing: trailing)
            .simultaneousGesture(TapGesture().onEnded {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .padding([.horizontal])
            .fullScreenCover(isPresented: self.$sheetRouter.showSheet) {
                self.sheetRouter.sheetView()
            }
            
            .actionSheet(isPresented: $showActionSheet) {
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
            }.toolbar {
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        self.navigateToActivityItem = true
                    }) {
                        Image(systemName: "list.bullet")
                            .configureTabIcon()
                    }
                    Spacer()
                    Button(action: {
                        self.showActionSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .configureTabIcon()
                    }
                    Spacer()
                    Button(action: {
                        self.navigateToCalendar = true
                    }) {
                        Image(systemName: "calendar")
                            .configureTabIcon()
                    }
                }
                
            }
            
        }
    }
    
    private var leading: some View {
        Text("TUESDAY, MAY 12")
            .font(.footnote)
            .foregroundColor(.secondary)
            .bold()
    }
    
    private var trailing: some View {
        UserProfileView().onTapGesture {
            self.sheetRouter.sheetDestination = .profile
        }
    }
    
    private var cardWidth: CGFloat {
        bounds.size.width - 40
    }
    
    private var bounds: CGRect { return UIScreen.main.bounds }
}

fileprivate extension Image {
    
    func configureTabIcon() -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: ToolBarView.listButtonEdge, height: ToolBarView.listButtonEdge)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
