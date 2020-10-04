//
//  AddProjectView.swift
//  TaskManager
//
//  Created by Olgu on 13.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct AddProjectView: View {
    @State private var title: String = ""
    fileprivate let users = [getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser(), getRandomUser()]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        TextField("Title", text: $title)
                            .font(.headline)
                            .frame(minHeight: 65.0)
                        Divider()
                    }

                    // Cover views
                    VStack(alignment: .leading) {
                        Text("Cover")
                            .fontWeight(.semibold)

                        // Cover samples
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 5) { _ in
                                    ProjectCoverView(index: Int.random(in: 0 ..< 3))
                                }
                            }
                        }.padding([.trailing])
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
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }

    private var trailing: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Done")
        })
    }
}

struct ProjectCoverView: View {
    var index: Int
    @State fileprivate var selected = false

    fileprivate let ratio: CGFloat = 1.0

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("sampleCover\(index)")

            if selected {
                Image(systemName: "largecircle.fill.circle")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .alignmentGuide(HorizontalAlignment.trailing) {
                        $0.width + 4.0
                    }
                    .alignmentGuide(VerticalAlignment.top) {
                        $0[.bottom] - ($0.height + 8.0)
                    }
            } else {
                Image(systemName: "circle")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .alignmentGuide(HorizontalAlignment.trailing) {
                        $0.width + 4.0
                    }
                    .alignmentGuide(VerticalAlignment.top) {
                        $0[.bottom] - ($0.height + 8.0)
                    }
            }

        }.onTapGesture {
            // withAnimation {
            self.selected.toggle()
            // }
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
