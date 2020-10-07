//
//  Blur.swift
//  TaskManager
//
//  Created by Olgu on 6.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
