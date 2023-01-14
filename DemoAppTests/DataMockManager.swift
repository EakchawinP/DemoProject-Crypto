//
//  DataMockManager.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation

private class DataManagerClass {}

class DataMockManager<T: Codable>: NSObject {
    static func get(name: String) throws -> T {
        let data = DataManager.getSampleData(name: name)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum DataManager {
    static func getDataFromFile(name: String) -> [[String: Any]] {
        if let path = Bundle(for: DataManagerClass.self).path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: Any] {
                    return [jsonResult]
                } else if let jsonResult = jsonResult as? [[String: Any]] {
                    return jsonResult
                }
            } catch {
                // handle error
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path. demo.app.DemoApp")
        }
        return []
    }

    static func getSampleData(name: String) -> Data {
        if let path = Bundle(for: DataManagerClass.self).path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return Data()
            }
        }
        return Data()
    }
}
