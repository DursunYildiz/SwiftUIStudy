//
//  CostumTextField.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//

import SwiftUI
struct CostumTextField: View {
    private var placeHolder: String
    var isSecureField: Bool = false
    @Binding var text: String
    init(placeHolder: String = "",
         text: Binding<String>,
         isSecureField: Bool = false)
    {
        self.placeHolder = placeHolder
        _text = text
        self.isSecureField = isSecureField
    }

    var body: some View {
        Group {
            if isSecureField {
                SecureField(placeHolder, text: $text)
            } else {
                TextField(placeHolder, text: $text)
            }
        }

        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
