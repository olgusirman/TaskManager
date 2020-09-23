//
//  Utility+.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }

    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
