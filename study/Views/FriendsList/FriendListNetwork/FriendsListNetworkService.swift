//
//  FriendsListNetworkService.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
protocol FriendsListServiceProtocol {
    func fetchFriendsList(completion: @escaping (Result<[User], Error>) -> Void)
}

final class FriendsListNetworkService: FriendsListServiceProtocol {
    func fetchFriendsList(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.friendList) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let response = try JSONDecoder().decode(FriendList.self, from: data!)

                if !response.results.isEmpty {
                    completion(.success(response.results))
                    FriendsListDbManager.shared.addFriends(friend: response.results)
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class FriendsListMockService: FriendsListServiceProtocol {
    func fetchFriendsList(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let friendList: [User] = PreviewData.loadArray(name: "FriendList")
        else {
            completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
            return
        }
        completion(.success(friendList))
    }
}
