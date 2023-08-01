//
//
//  LoginViewModel.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//
//
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var model: LoginModel = .init(username: "", password: "")
    @Published var showingAlert = false
    func login() {
        guard model.isValidUsername() else {
            showingAlert.toggle()
            return
        }
        AppState.shared.navigation = .friendsList
    }
}
