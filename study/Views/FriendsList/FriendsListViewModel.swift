//
//  FriendsListViewModel.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

class FriendsListViewModel: ObservableObject {
    @Published var friendsList: [User] = []
    @Published var requestState: RequestState = .loading
    @Published var isNavigate: Bool = false
    @Published var selectedUser: User?
    private var service: FriendsListServiceProtocol
    init(
        service: FriendsListServiceProtocol = FriendsListNetworkService())
    {
        self.service = service
    }

    func fetchUser() {
        requestState = .loading
        service.fetchFriendsList { [weak self] result in
            switch result {
            case .success(let friendsList):
                DispatchQueue.main.async {
                    self?.requestState = .succes
                    self?.friendsList = friendsList
                }
            case .failure(let error):
                self?.requestState = .fail
                print("Error fetching user: \(error)")
            }
        }
    }

    enum RequestState {
        case loading
        case succes
        case fail
    }

    func showDetail(with user: User) {
        selectedUser = user
        isNavigate.toggle()
    }
    func logout() {
        AppState.shared.navigation = .login
    }
}
