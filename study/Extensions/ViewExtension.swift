//
//  ViewExtension.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI
extension View {
    func navigate(
        item: Binding<Bool>,
        dissmisAction: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        background(NavigationLink(destination: NavigationLazyView(content()),
                                  isActive: Binding<Bool>(
                                      get: {
                                          item.wrappedValue
                                      }, set: { val in
                                          item.wrappedValue = val
                                          if !val, dissmisAction != nil {
                                              dissmisAction?()
                                          }
                                      }
                                  ), label: {
                                      EmptyView()
                                  }))
    }
}
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
