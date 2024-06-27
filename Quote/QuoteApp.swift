//
//  QuoteApp.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import SwiftUI

@main
struct QuoteApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(quote: Quote.preview[0])
        }
    }
}
