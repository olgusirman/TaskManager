//
//  ProfileView.swift
//  TaskManager
//
//  Created by Olgu on 4.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    private let teamMembers = [getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser()]

    private var allTasks: Int = 145
    private var doneTasks: Int = 126
    private var activitySection = section1

    private var tasksPercentage: Int {
        return Int((doneTasks / allTasks) * 100)
    }
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            header
                .frame(height: 240)
            VStack(alignment: .leading) {
                VStack (alignment: .leading) {
                    Group {
                        HStack {
                            Text("Victoria Mak")
                                .font(.system(size: 34, weight: .bold))
                            Spacer()
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                        }
                        Text("victoriamak@kukutro.com")
                            .foregroundColor(.secondary)
                    }.padding(.horizontal)
                    // TODO: Do some padding to group here
                    Divider().padding(.leading)
                }
                teamMembersView
                statisticsView
                ActivitySectionnView(activities: activitySection).padding(.horizontal)
            }
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
            Group {
                HStack {
                    Text("Your Team")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    Button("See All") {
                        debugPrint(#function)
                    }
                }.padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(teamMembers) { user in
                            LazyHStack {
                                AssignedUserView(user: user)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
            Divider().padding(.leading)
        }
    }
    
    private var statisticsView: some View {
        VStack (alignment: .leading, spacing: 20) {
            Group {
                Text("Statistics")
                    .font(.system(size: 22, weight: .bold))
                HStack {
                    Text("Tasks")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            slider
            Divider()
                .padding(.leading)
            HStack {
                Text("Projects")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }.padding(.horizontal)
            Divider()
                .padding(.leading)
        }
    }
    
    private var slider: some View {
        VStack {
            ProgressView("", value: Float(doneTasks), total: Float(allTasks))
            HStack {
                Text("\(allTasks)")
                    .fontWeight(.semibold)
                Text("/ \(doneTasks) done")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(tasksPercentage)%")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct ActivitySectionnView: View {
    var activities: ActivityPageModel
    
    var body: some View {
        VStack (alignment: .leading) {
            Section(header: sectionHeader) {
                ActivitySectionRowView(activities: activities.activities)
            }
        }
    }
    
    private var sectionHeader: some View {
        Text("Today").font(.title).bold()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
