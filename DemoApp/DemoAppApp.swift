//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by Eakchawin Pinngearn on 12/1/2566 BE.
//

import SwiftUI

@main
struct DemoAppApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            CrytoInfoView(viewModel: CrytoInfoViewModel())
        }
    }
}
