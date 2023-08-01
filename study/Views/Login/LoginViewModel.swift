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
    @Published var model: LoginModel = .init(userName: "", password: "")
   
    func login() {
        
    }

}
