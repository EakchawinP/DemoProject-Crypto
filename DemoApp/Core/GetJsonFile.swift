//
//  GetJsonFile.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 14/1/2566 BE.
//

import Foundation

public struct GetJsonFile {
    
    public static let shared = GetJsonFile()
    
    public func readLocalFile(forName name: String) -> Data {
        do {
            if let bundlePath = Bundle(identifier: "demo.app.DemoApp")?.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Fail to get json file")
        }
        return Data()
    }
}
