//
//  NetworkImageView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct NetworkImageView: View {
    private let url: String
    init(url: String) {
        self.url = url
    }

    var body: some View {
        ZStack {
            if let imageUrl = URL(string: url) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    case .success(let image):
                        // Image loaded successfully
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)

                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.red)
                    @unknown default:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    }
                }
            }
            else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct NetworkImageView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImageView(url: "")
    }
}
