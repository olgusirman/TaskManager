//
//  SelectProjectView.swift
//  TaskManager
//
//  Created by Olgu on 13.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct SelectProjectView: View {
    @Binding var showProjectSelectionView: Bool
    var projects: [Project]
    @Binding var activeProject: Project

    var body: some View {
        Picker("", selection: $activeProject) {
            ForEach(projects) { project in
                Text(project.title)
            }
        }
    }
}

struct SelectProjectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProjectView(showProjectSelectionView: .constant(true),
                          projects: mockProjects,
                          activeProject: .constant(mockProjects.first!))
    }
}
