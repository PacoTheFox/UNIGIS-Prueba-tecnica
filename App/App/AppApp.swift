//
//  AppApp.swift
//  App
//
//  Created by Javier Aguirre San Román on 14/02/24.
//

import SwiftUI

@main
struct AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MovieViewModel())
        }
    }
}
