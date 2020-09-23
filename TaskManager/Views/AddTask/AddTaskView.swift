//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Olgu on 13.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct AddTaskView: View {
    // MARK: Title - Description

    @State private var title: String = ""
    @State private var description: String = ""

    // MARK: ProjectSelection

    @State private var showProjectSelectionPicker = false
    @State private var activeProjectIndex: Int = 0

    fileprivate var projects = mockProjects

    // MARK: DueDate

    @State private var showDatePicker = false
    @State private var activeDate = Date()

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var dateString: String {
        return formatter.string(from: activeDate)
    }

    // MARK: Assigned

    fileprivate let users = [getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser()]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        TextField("Title", text: $title)
                            .font(.headline)
                            .frame(minHeight: 65.0)
                        Divider()
                        TextField("Description", text: $description).frame(minHeight: 57.0)
                        Divider()

                        HStack {
                            Text("Project")
                            Spacer()
                            Text(projects[activeProjectIndex].title)
                                .foregroundColor(self.showProjectSelectionPicker ? .blue : .primary)
                                .padding([.trailing])
                        }
                        .frame(minHeight: 57.0)
                        .onTapGesture {
                            withAnimation {
                                self.showProjectSelectionPicker.toggle()
                            }
                        }
                    }

                    if showProjectSelectionPicker {
                        Picker("", selection: $activeProjectIndex) {
                            ForEach(0 ..< self.projects.count) { index in
                                Text(self.projects[index].title)
                            }
                        }.labelsHidden()
                    }

                    Divider()

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Due Date")
                            Spacer()
                            Text(dateString)
                                .foregroundColor(self.showDatePicker ? .blue : .primary)
                                .padding([.trailing])
                        }.frame(minHeight: 57.0)
                            .onTapGesture {
                                withAnimation {
                                    self.showDatePicker.toggle()
                                }
                            }
                    }

                    if showDatePicker {
                        DatePicker("", selection: $activeDate).labelsHidden()
                    }

                    Divider()

                    VStack(alignment: .leading) {
                        Text("Assigned")
                            .fontWeight(.semibold)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(users) { user in
                                    HStack {
                                        AssignedUserView(user: user)
                                    }
                                }
                            }
                        }.padding([.trailing])
                    }
                }
                .padding([.leading])
            }
            .resignKeyboardOnDragGesture()
            .navigationBarTitle(Text("Add Task"), displayMode: .automatic)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }

    private var leading: some View {
        Button(action: {
            debugPrint("Leading pressed")
        }, label: {
            Text("Cancel")
        })
    }

    private var trailing: some View {
        Button(action: {
            debugPrint("Trailing pressed")
        }, label: {
            Text("Done")
        })
    }
}

struct AssignedUserView: View {
    var user: User
    @State fileprivate var selected = false

    var userFirstName: String {
        user.name.components(separatedBy: " ").first ?? ""
    }

    var body: some View {
        VStack {
            ZStack {
                Image(user.profileImageName)
                    .clipShape(Circle())
                if selected {
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)
                            .opacity(0.8)
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                }
            }
            Text(userFirstName)
        }.onTapGesture {
            self.selected.toggle()
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
