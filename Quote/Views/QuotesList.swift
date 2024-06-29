//
//  QuotesList.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import SwiftUI

struct QuotesList: View {
    @EnvironmentObject var quoteLoader: QuoteLoader
    @Environment(\.openURL) private var openURL
    var body: some View {
        VStack {
            if quoteLoader.quotes.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                ScrollView {
                    ForEach(quoteLoader.quotes) { quote in
                        QuoteCardRow(quote: quote, showDate: true)
                            .padding()
                            .onTapGesture {
                                if let jumpScheme = quote.jumpScheme, let url = URL(string: jumpScheme) {
                                    openURL(url)
                                }
                            }
                    }
                }
            }
        }
        .navigationTitle("历史")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await self.quoteLoader.fetchQuotes()
        }
    }
}

#Preview {
    NavigationView {
        QuotesList()
            .environmentObject(QuoteLoader())
    }
}
