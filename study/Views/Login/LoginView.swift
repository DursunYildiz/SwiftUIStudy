//
//
//  LoginView.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//
//
import SwiftUI
struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel

    enum FocusedField {
        case username, password
    }

    @FocusState private var focusedField: FocusedField?
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text("Welcome")
                    .font(.title.bold())
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.callout.bold())
                    CostumTextField(placeHolder: "Username",
                                    text: $viewModel.model.username)
                        .focused($focusedField, equals: .username)
                    Text("Password")
                        .font(.callout.bold())
                        .padding(.top, 15)
                    CostumTextField(placeHolder: "Password",
                                    text: $viewModel.model.password,
                                    isSecureField: true)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.done)
                    Button {
                        endEditing()
                        viewModel.login()
                    } label: {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.bgColor)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .padding(.top, 30)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 35)
            .padding(.bottom, 25)
            .background(TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
            )
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 2))
            .shadow(color: .black.opacity(0.2), radius: 10)
            .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Rectangle()
                .fill(Color.bgColor)
                .ignoresSafeArea()
        )
        .onSubmit {
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
        .alert("Unvalid username", isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) {}
        }
        .onTapGesture {
            endEditing()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
