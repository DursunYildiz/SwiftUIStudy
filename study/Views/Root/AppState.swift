//
//  AppState.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
final class AppState: ObservableObject {
    enum Navigation {
        case login, friendsList
    }

    @Published var navigation: Navigation = .login

    static let shared = AppState()
    private init() {}
    private(set) var networkMonitor: NetworkMonitorProtocol = NetworkMonitor.shared
}
