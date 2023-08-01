//
//  FriendDetailView.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import MapKit
import SwiftUI
struct FriendDetailView: View {
    private let user: User

    @ObservedObject private var viewModel: FriendDetailViewModel
    init(user: User,
         viewModel: FriendDetailViewModel = .init())
    {
        self.user = user
        self.viewModel = viewModel
        viewModel.setRegion(with: user)
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ScrollView {
                VStack(spacing: 12) {
                    NetworkImageView(url: user.picture.large)
                        .clipShape(Circle())
                        .frame(width: size.width * 0.3)
                        .background(Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 2))
                        .shadow(color: .black.opacity(0.2), radius: 10)
                        .padding(.top)
                    VStack(spacing: 8) {
                        Text(user.name.first)
                            .font(.title.bold())

                        Text(user.name.last)
                            .font(.title2)
                            .opacity(0.7)
                        HStack(spacing: 12) {
                            Button {
                                viewModel.call(with: user.phone)
                            } label: {
                                FriendDetailCell {
                                    Image(systemName: "phone.fill")
                                }
                            }

                            Button {
                                viewModel.sendSms(with: user.phone)
                            } label: {
                                FriendDetailCell {
                                    Image(systemName: "envelope.fill")
                                }
                            }
                        }
                        .padding()

                        FriendDetailCell {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Mobile")
                                        .font(.caption)

                                    Button {
                                        viewModel.call(with: user.phone)
                                    } label: {
                                        Text(user.phone)
                                    }
                                }
                                .padding(.leading)
                                Spacer()
                            }
                        }.padding(.horizontal)
                        FriendDetailCell {
                            HStack {
                                Button {
                                    viewModel.mailTo(to: user.email)
                                } label: {
                                    Text(user.email)
                                }
                                .padding(.leading)
                                Spacer()
                            }
                        }.padding(.horizontal)
                            .padding(.top)
                        FriendDetailCell {
                            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.mapAnnotation) {
                                MapPin(coordinate: $0.coordinate)
                            }

                        }.frame(height: size.width * 0.5)
                            .padding()
                    }.padding(.top, 24)
                }
            }
        }
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if let user: User = PreviewData.loadArray(name: "FriendList")?.first {
                NavigationView {
                    FriendDetailView(user: user)
                        .preferredColorScheme(.dark)
                }
            }
        }
    }
}

struct FriendMapModel: Identifiable {
    let id = UUID()
    let user: User
    var coordinate: CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)
    init(user: User) {
        self.user = user
        self.coordinate = CLLocationCoordinate2D(latitude: user.location.coordinates.latitude.toDouble(), longitude: user.location.coordinates.longitude.toDouble())
    }
}
