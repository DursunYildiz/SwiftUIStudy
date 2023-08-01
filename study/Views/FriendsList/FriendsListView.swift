//
//  FriendsListView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct FriendsListView: View {
    @ObservedObject var viewModel: FriendsListViewModel

    init(viewModel: FriendsListViewModel = .init(service: FriendsListNetworkService())) {
        self.viewModel = viewModel
        viewModel.fetchUser()
    }

    var body: some View {
        NavigationView {
            ZStack {
                switch viewModel.requestState {
                case .loading:
                    ProgressView("Loading...")
                case .succes:

                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(0 ..< viewModel.friendsList.count, id: \.self) { index in
                                let user: User = viewModel.friendsList[index]

                                Button {
                                    viewModel.showDetail(with: user)

                                } label: {
                                    ProfileCellView(name: user.name.first, surname: user.name.last, url: user.picture.thumbnail)
                                }
                            }
                        }
                    }

                case .fail:
                    EmptyView()
                }
            }

            .navigationTitle("FriendList")

            .navigate(item: $viewModel.isNavigate) {
                if let user = viewModel.selectedUser {
                    FriendDetailView(user: user)
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                viewModel.logout()
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .foregroundColor(.white)
            })
            )
        }
    }
}

struct FriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListView(viewModel: .init(service: FriendsListMockService()))
            .preferredColorScheme(.dark)
    }
}
