//
//  ProjectCardView.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ProjectCardView: View {
    var project: Project
    var cardWidth: CGFloat
    var tapped: (Project) -> Void

    // 335 / 200
    private let cardRatio: CGFloat = 1.675

    var body: some View {
        return
            contentView
                .fixedSize(horizontal: false, vertical: false)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding([.leading, .trailing, .bottom], 8)
                .aspectRatio(cardRatio, contentMode: .fill)
                .frame(idealWidth: cardWidth)
                .onTapGesture {
                    self.tapped(self.project)
                }
    }

    private var contentView: some View {
        ZStack {
            Image("cardBackground")
                .renderingMode(.original)
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Spacer()
                        Text(project.title.uppercased())
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.gray)
                        Text(project.description.localizedCapitalized)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    }.padding([.leading, .trailing])
                    Spacer()
                }
                CardBottomView(memberCount: project.memberCount)
            }
        }
    }
}

struct CardBottomView: View {
    var memberCount: Int

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 56)
            CardBottomDataView(memberCount: memberCount)
        }
    }
}

struct CardBottomDataView: View {
    var memberCount: Int

    var body: some View {
        HStack(spacing: 12) {
            Text("\(memberCount) Members").foregroundColor(.black).fontWeight(.semibold) // TODO: handle plural - single situation depends on the count
            Spacer()
            HStack {
                memberImage(user: getRandomUser())
                memberImage(user: getRandomUser())
                memberImage(user: getRandomUser())
                Image(systemName: "chevron.right").foregroundColor(.gray)
            }
        }.padding([.leading, .trailing])
    }

    private func memberImage(user: User) -> some View {
        Image(user.profileImageName)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 32, height: 32, alignment: .trailing).cornerRadius(16)
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCardView(project: project1, cardWidth: 375, tapped: { _ in })
    }
}
