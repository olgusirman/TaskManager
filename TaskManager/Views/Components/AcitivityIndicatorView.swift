//
//  AcitivityIndicatorView.swift
//  GithubCombineExample
//
//  Created by Olgu on 6.02.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool

    func makeUIView(context _: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context _: Context) {
        if shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isRefreshing: Bool

    final class Cordinator: NSObject {
        @Binding var isRefreshing: Bool

        init(isRefreshing: Binding<Bool>) {
            _isRefreshing = isRefreshing
        }
    }

    func makeCoordinator() -> ActivityIndicatorView.Cordinator {
        return Cordinator(isRefreshing: $isRefreshing)
    }

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context _: Context) {
        if isRefreshing {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
