//
//  studyApp.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//

import SwiftUI

@main
struct studyApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}
