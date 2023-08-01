//
//  FriendDetailViewModel.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import MapKit
import SwiftUI
final class FriendDetailViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    var mapAnnotation: [FriendMapModel] = []
    func call(with phone: String) {
        let telephone = "tel://"
        let formattedString = telephone + phone
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }

    func sendSms(with phone: String) {
        let sms = "sms:"
        let formattedString = sms + phone
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }

    func mailTo(to mail: String) {
        let mailto = "mailto:"
        let formattedString = mailto + mail
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }

    func setRegion(with user: User) {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: user.location.coordinates.latitude.toDouble(), longitude: user.location.coordinates.longitude.toDouble()), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

        self.mapAnnotation = [.init(user: user)]
    }
}
