//
//  SwiftUIView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct ProfileCellView: View {
    private let name: String
    private let surname: String
    private let url: String
    init(name: String, surname: String, url: String) {
        self.name = name
        self.surname = surname
        self.url = url
    }

    var body: some View {
        HStack(spacing: 30) {
            NetworkImageView(url: url)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.callout.bold())
                    .foregroundColor(.white)

                Text(surname)
                    .font(.callout)
                    .opacity(0.7)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(TransparentBlurView(removeAllFilters: true)
            .blur(radius: 9, opaque: true)
            .background(.white.opacity(0.05))
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
            .stroke(.white.opacity(0.3), lineWidth: 2))
        .shadow(color: .black.opacity(0.2), radius: 10)
        .padding(.horizontal, 10)
    }
}

struct ProfileCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCellView(name: "Dummy", surname: "Dummy", url: "")
            .preferredColorScheme(.dark)
    }
}
