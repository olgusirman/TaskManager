//
//  ProfileView.swift
//  TaskManager
//
//  Created by Olgu on 4.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    fileprivate let teamMembers = [getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser()]
    
    var body: some View {
        ScrollView {
            header
                .frame(height: 240)
            VStack(alignment: .leading) {
                VStack (alignment: .leading, spacing: 20) {
                    Group {
                        HStack {
                            Text("Victoria Mak")
                                .font(.system(size: 34, weight: .bold))
                            Spacer()
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                        }.padding(.trailing)
                        Text("victoriamak@kukutro.com")
                            .foregroundColor(.secondary)
                    }
                    // TODO: Do some padding to group here
                    Divider()
                }
                teamMembersView
                statisticsView
            }
            .padding([.leading])
        }
        .edgesIgnoringSafeArea(.top)
    }

    private var header: some View {
        GeometryReader { geometry in
            ZStack {
                if geometry.frame(in: .global).minY <= 0 {
                    Image("profileHeader")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: geometry.frame(in: .global).minY / 9)
                        .clipped()
                } else {
                    Image("profileHeader")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                }
            }
        }
    }
    
    private var teamMembersView: some View {
        VStack(alignment: .leading) {
            Text("Your Team")
                .font(.system(size: 22, weight: .bold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(teamMembers) { user in
                        LazyHStack {
                            AssignedUserView(user: user)
                        }
                    }
                }
            }
            Divider()
        }
    }
    
    private var statisticsView: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text("Statistics")
                .font(.system(size: 22, weight: .bold))
            HStack {
                Text("Tasks")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }.padding(.trailing)
            // TODO: Slider on progress
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

let articleContent =

    """
    Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    At vero eos et accusam et justo duo dolores et ea rebum.
    Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    """
