//
//  RootView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        switch appState.navigation {
        case .login:
            LoginView()
                .transition(.opacity)
        case .friendsList:
            FriendsListView(viewModel: .init(service: appState.networkMonitor.isConnected ? FriendsListNetworkService() : FriendsListDbManager.shared))
        }
    }
}
