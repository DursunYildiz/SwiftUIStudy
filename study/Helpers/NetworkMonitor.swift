//
//  NetworkMonitor.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
import Network
protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
}

final class NetworkMonitor: ObservableObject, NetworkMonitorProtocol {
    static let shared = NetworkMonitor()

    var isConnected: Bool = false

    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")

    private init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
