//
//  PreviewData.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
final class PreviewData {
    static func load<T: Codable>(name: String) -> T? {
        let packageURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
        let fileURL = packageURL.appendingPathComponent(name + ".json")
        do {
            let data = try Data(contentsOf: fileURL)

            let result = try JSONDecoder().decode(T.self, from: data)

            return result
        } catch {
            return nil
        }
    }

    static func loadArray<T: Codable>(name: String) -> [T]? {
        let packageURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
        let fileURL = packageURL.appendingPathComponent(name + ".json")
        do {
            let data = try Data(contentsOf: fileURL)
            let result = try JSONDecoder().decode([T].self, from: data) // Decode an array of objects
            return result
        } catch {
            return nil
        }
    }
}
