//
//  FriendsListDbManager.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
import RealmSwift
final class FriendsListDbManager: FriendsListServiceProtocol {
    static let shared: FriendsListDbManager = .init()
    func fetchFriendsList(completion: @escaping (Result<[User], Error>) -> Void) {
        if let localRealm = localRealm {
            var friendsList: [User] = []
            let allFriends = localRealm.objects(FriendsListDbModel.self)
            allFriends.forEach { friends in
                guard let friend = friends.friend else { return }
                friendsList.append(friend)
            }
            completion(.success(friendsList))
        }
    }

    private(set) var localRealm: Realm?

    private init() {
        openRealm()
    }

    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion > 1 {}
            })

            Realm.Configuration.defaultConfiguration = config

            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }

    func addFriends(friend: [User]) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    friend.forEach { user in
                        let newCourse = FriendsListDbModel()
                        newCourse.friend = user

                        localRealm.add(newCourse)
                    }

                    print("Added friendsList")
                }
            } catch {
                print("Error adding friendsList to Realm", error)
            }
        }
    }
}

final class FriendsListDbModel: Object {
    @objc private dynamic var friendData: Data?

    var friend: User? {
        get {
            if let data = friendData {
                return try? JSONDecoder().decode(User.self, from: data)
            }
            return nil
        }
        set {
            friendData = try? JSONEncoder().encode(newValue)
        }
    }
}
