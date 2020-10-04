//
//  MakeEditView.swift
//  TaskManager
//
//  Created by Olgu on 6.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct MakeEditView: View {
    var project: Project

    var body: some View {
        MakeEditContentView(project: project)
            .navigationBarItems(trailing: Image(systemName: "line.horizontal.3.decrease.circle.fill"))
            .navigationBarTitle(Text(project.description), displayMode: .automatic)
    }
}

struct MakeEditContentView: View {
    var project: Project
    var tasks: [Task] = mockTasks

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                projectNavigationPlan
                projectUserAndTimePlan

                // Big Image
                Image("projectBackground")
                    .aspectRatio(contentMode: .fit)

                actionButtons

                Divider()

                HStack {
                    Text("Subtasks")
                        .font(.title)
                        .bold()
                    Spacer()
                }

                LazyVStack {
                    ForEach(tasks) { task in
                        HomeTaskRow(task: task)
                    }
                }
            }.padding([.horizontal])
        }
    }

    private var cardWidth: CGFloat {
        bounds.size.width - 40
    }

    private var bounds: CGRect { return UIScreen.main.bounds }

    var projectNavigationPlan: some View {
        HStack {
            Text("In Design")
            Image(systemName: "chevron.right")
            Text("New Kit")
            Image(systemName: "chevron.right")
            Text("Website Launch")
        }.font(.system(size: 17))
    }

    var projectUserAndTimePlan: some View {
        HStack {
            HStack {
                Image(getRandomUser().profileImageName)
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44, alignment: .trailing)
                Text("For You")
            }
            HStack {
                Image(systemName: "clock")
                Text("Due Nov 12, 2020")
            }.foregroundColor(.blue)
        }
    }

    // HStack
    // Like Done
    var actionButtons: some View {
        HStack {
            Button(action: {
                debugPrint("Heart button pressed")
            }, label: {
                HStack {
                    Image(systemName: "heart.fill")
                    Text("Like")
                }
                .aspectRatio(CGSize(width: 164, height: 48), contentMode: .fill)
                .frame(maxWidth: .infinity,
                       minHeight: 48.0)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
            })

            Button(action: {
                debugPrint("Checkmark button pressed")
            }, label: {
                HStack {
                    Image(systemName: "checkmark")
                    Text("Done")
                }
                .aspectRatio(CGSize(width: 164, height: 48), contentMode: .fill)
                .frame(maxWidth: .infinity,
                       minHeight: 48.0)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
            })
        }
    }
}

struct MakeEditView_Previews: PreviewProvider {
    static var previews: some View {
        MakeEditView(project: project1)
    }
}
