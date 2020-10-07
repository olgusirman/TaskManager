//
//  HomeContentView.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct HomeContentView: View {
    var cardWidth: CGFloat

    var tasks: [Task] = mockTasks
    var projects: [Project] = mockProjects

    var body: some View {
        VStack {
            ProjectsSectionView(projects: projects, cardWidth: cardWidth)

            HomeSectionTitleView(action: {
                debugPrint("Tasks section see all pressed")
            }, title: "Tasks").padding(.horizontal)

            HomeTasksView(cardWidth: cardWidth).padding(.top)

            LazyVStack {
                ForEach(tasks) { task in
                    HomeTaskRow(task: task)
                        .padding([.horizontal])
                }
            }
        }
    }
}

struct ProjectsSectionView: View {
    var projects: [Project]
    var cardWidth: CGFloat

    @State private var navigateToProject = false
    @State private var selectedProject: Project = project1

    var body: some View {
        VStack {
            HomeSectionTitleView(action: {
                debugPrint("Projects section see all pressed")
            }, title: "Projects")
                .padding([.leading, .trailing])

            NavigationLink(destination: MakeEditView(project: self.selectedProject), isActive: self.$navigateToProject) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(projects) { project in
                            HStack {
                                Spacer(minLength: 20)
                                ProjectCardView(project: project, cardWidth: self.cardWidth, tapped: { project in
                                    self.selectedProject = project
                                    self.navigateToProject = true
                                })
                                Spacer(minLength: 20)
                            }
                        }
                    }
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct HomeSectionTitleView: View {
    var action: () -> Void
    var title: String

    var body: some View {
        HStack {
            Text(title).font(.title).bold()
            Spacer()
            Button(action: {
                self.action()
            }) {
                Text("See All")
            }
        }
    }
}

struct HomeTasksView: View {
    var cardWidth: CGFloat

    var body: some View {
        HStack {
            Image(systemName: "bolt.fill")
                .padding([.leading])
            Text("4 new tasks, from Yura and Artem")
                .font(.system(size: 13, weight: .semibold))
            Spacer()
        }
        .frame(width: cardWidth + 40, height: 32)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.blue)
        .foregroundColor(.white)
    }
}

struct HomeTaskRow: View {
    var task: Task

    var body: some View {
        HStack {
            if task.isChecked {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)

            } else {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(task.taskDescription)
                    .font(.system(size: 17))
                Text(task.formattedDate)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            Spacer()

            if task.isLate {
                // Show alert
                HStack {
                    Text(task.formattedAlertDate)
                    Image(systemName: "exclamationmark.square.fill")
                }.foregroundColor(.red)
            }
        }
        .frame(height: 68)
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(cardWidth: CGFloat(375))
    }
}
