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
    
    @State private var searchText = ""
    @State private var showProfileView = false
    
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
                VStack { // MainVStack
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            SearchBar(text: $searchText).padding([.leading, .trailing], 4)
                            HomeContentView(cardWidth: cardWidth)
                        }
                        Spacer()
                    }.resignKeyboardOnDragGesture()
                    
                    ZStack {
                        BlurView(style: .systemUltraThinMaterial)
                        ToolBarView()
                            .frame(idealWidth: .infinity).padding([.leading, .trailing])
                    }
                    .frame(width: bounds.size.width, height: 44, alignment: .bottom)
                }
            }
            .navigationBarTitle("Today")
            .navigationBarItems(leading: leading, trailing: trailing)
            .simultaneousGesture(TapGesture().onEnded {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .padding([.horizontal])
            .fullScreenCover(isPresented: $showProfileView) {
                ProfileView()
            }
//            .sheet(isPresented: $showProfileView) {}
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
            self.showProfileView = true
        }
    }
    
    private var cardWidth: CGFloat {
        bounds.size.width - 40
    }
    
    private var bounds: CGRect { return UIScreen.main.bounds }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
