//
//  HomeNavigationBarView.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct HomeNavigationBarView: View {
    var body: some View {
        HStack {
            HeaderDateView()
            Spacer()
            UserProfileView()
        }
    }
}

struct HeaderDateView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TUESDAY, MAY 12").foregroundColor(.secondary).bold().font(.footnote) // TODO: format these date
            Text("Today").font(.largeTitle).bold() // Format these date depends on the other date
        }
    }
}

struct UserProfileView: View {
    var body: some View {
        Image(getRandomUser().profileImageName).resizable().aspectRatio(contentMode: .fill).frame(width: 44, height: 44, alignment: .trailing).cornerRadius(22)
    }
}

struct HomeNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBarView()
    }
}
