//
//  NavigationLazyView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
