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
    let bgColor: Color = .init(red: 6/255, green: 5/255, blue: 12/255)
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
                                    text: $viewModel.model.userName)
                        .focused($focusedField, equals: .username)
                    Text("Password")
                        .font(.callout.bold())
                        .padding(.top, 15)
                    CostumTextField(placeHolder: "Password",
                                    text: $viewModel.model.password,
                                    isSecureField: true)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.done)
                    Button {} label: {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(bgColor)
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
                .fill(bgColor)
                .ignoresSafeArea()
        )
        .onSubmit {
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}

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

struct BlurView: UIViewRepresentable {
    func updateUIView(_: UIVisualEffectView, context _: Context) {}

    var effect: UIBlurEffect.Style
    func makeUIView(context _: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
}

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context _: Context) -> TransparentBlurViewHelper {
        TransparentBlurViewHelper(removeAllFilters: removeAllFilters)
    }

    func updateUIView(_: TransparentBlurViewHelper, context _: Context) {}
}

final class TransparentBlurViewHelper: UIVisualEffectView {
    init(removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        if subviews.indices.contains(1) {
            subviews[1].alpha = 0
        }
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else {
                /// Removing All Expect Blur Filter
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }

    override func traitCollectionDidChange(_: UITraitCollection?) {}

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
