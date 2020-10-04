//
//  LoginView.swift
//  TaskManager
//
//  Created by Olgu on 4.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        GeometryReader { metrics in
            VStack (spacing: 38) {
                TabView {
                    VStack {
                        Image("loginHeadline1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame( maxHeight: metrics.size.height / 2)
                        VStack {
                            Text("Work Together")
                                .font(.system(size: 40, weight: .bold))
                            Text("Get everyone around you always in-sync with shared lists and assigned tasks")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    VStack (spacing: 20) {
                        Image("loginHeadline2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame( maxHeight: metrics.size.height / 2)
                        VStack {
                            Text("Get Organized")
                                .font(.system(size: 40, weight: .bold))
                            Text("Capture and organize tasks the moment they pop into your head")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                loginButtons
                Spacer()
            }
        }.edgesIgnoringSafeArea(.top)
    }
        
    private var loginButtons: some View {
        VStack (spacing: 20) {
            Button {
                self.userManager.isLoggedIn = true
            } label: {
                HStack {
                    Image("google")
                    Text("Log In with Google")
                        .font(.system(size: 17.0, weight: .semibold))
                }
            }
            Button {
                self.userManager.isLoggedIn = true
            } label: {
                HStack {
                    Image("facebook")
                    Text("Log In with Facebook")
                        .font(.system(size: 17.0, weight: .semibold))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
