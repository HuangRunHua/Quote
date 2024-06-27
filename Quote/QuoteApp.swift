//
//  QuoteApp.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import SwiftUI

@main
struct QuoteApp: App {
    @StateObject private var quoteLoader = QuoteLoader()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quoteLoader)
        }
    }
}
