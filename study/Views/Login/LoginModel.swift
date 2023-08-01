//
//
//  LoginModel.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//
//
import Foundation

struct LoginModel: Codable {
    var username, password: String

    func isValidUsername() -> Bool {
        let usernameRegex = #"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5}$"#
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
}
