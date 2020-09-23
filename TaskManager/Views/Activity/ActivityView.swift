//
//  ActivityView.swift
//  TaskManager
//
//  Created by Olgu on 30.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        ActivityContentView()
            // .padding()
            .navigationBarItems(trailing: Image(systemName: "line.horizontal.3.decrease.circle.fill"))
            .navigationBarTitle("Activity", displayMode: .automatic)
    }
}

struct ActivityContentView: View {
    @State private var searchText = ""

    var activities = activitiesMock

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    SearchBar(text: $searchText)
                    ForEach(activities) { activitySection in
                        ActivitySectionView(activities: activitySection)
                    }
                }.padding([.horizontal])
            }.resignKeyboardOnDragGesture()
        }
    }
}

struct ActivitySectionView: View {
    var activities: ActivityPageModel

    var body: some View {
        VStack {
            Section(header: ActivitySectionHeaderView(day: "Today", dateDescription: "Feb 23")) {
                ActivitySectionRowView(activities: activities.activities)
            }
        }
    }
}

struct ActivitySectionHeaderView: View {
    var day: String
    var dateDescription: String

    var body: some View {
        HStack {
            Text(day)
                .font(.title)
                .bold()
            Text(dateDescription)
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct ActivitySectionRowView: View {
    var activities: [Activity]

    var body: some View {
        VStack {
            ForEach(activities) { activity in
                ActivityRowView(activity: activity)
            }
        }
    }
}

struct ActivityRowView: View {
    var activity: Activity

    var body: some View {
        HStack {
            HStack(alignment: .top) {
                Image(activity.user.profileImageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)

                VStack(alignment: .leading) {
                    Text(activity.title)
                    // .font(.headline)
                    Text(activity.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                }
            }
            Spacer()

            // TODO: configure depends on the type
            Image(systemName: "heart.fill")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
