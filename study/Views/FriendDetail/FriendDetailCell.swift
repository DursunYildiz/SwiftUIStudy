//
//  FriendDetailCell.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct FriendDetailCell<Content: View>: View {
    @ViewBuilder let content: () -> Content
    var body: some View {
        content()

            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
            )
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .background(RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 2))
            .shadow(color: .black.opacity(0.2), radius: 10)
    }
}

struct FriendDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailCell {}
    }
}
