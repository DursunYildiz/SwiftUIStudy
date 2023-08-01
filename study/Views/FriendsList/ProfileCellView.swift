//
//  SwiftUIView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import SwiftUI

struct ProfileCellView: View {
    let name: String
    let surname: String
    let url: URL
    init(name: String, surname: String, url: String) {
        self.name = name
        self.surname = surname
        self.url = URL(string: url)!
    }
    var body: some View {
        HStack (spacing: 30){

            AsyncImage(url: self.url) { phase in
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
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.callout.bold())
                    
                Text(surname)
                    .font(.callout)
                    .opacity(0.7)
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
        ProfileCellView()
    }
}
