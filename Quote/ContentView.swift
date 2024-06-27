//
//  ContentView.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import SwiftUI
import NukeUI

@MainActor
struct ContentView: View {
    @EnvironmentObject var quoteLoader: QuoteLoader
    private let cornerRadius: CGFloat = 10
    @State private var quotes: [Quote] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(Date.currentDate)
                            .font(.system(size: 40, weight: .heavy))
                        Text(Date.currentWeekday)
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundColor(Color.descriptionFontColor)
                    }
                    Spacer()
                }
                .padding([.top, .leading, .trailing])
                Divider()
                    .padding([.leading, .trailing])
                QuoteCardRow(quote: quoteLoader.todayQuote)
                    .padding()
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        QuotesList()
                            .environmentObject(quoteLoader)
                    } label: {
                        Image(systemName: "calendar")
                    }

                }
            })
        }
        .task {
            await self.quoteLoader.fetchTodayQuote()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(QuoteLoader())
        .environment(\.locale, .init(identifier: "zh"))
}


extension ContentView {
    @ViewBuilder
    private var cardView: some View {
        if let todayQuote = quoteLoader.todayQuote {
            switch todayQuote.style {
            case .zstack:
                zstackCardView(quote: todayQuote)
            case .vertical:
                verticalCardView(quote: todayQuote)
            }
        } else {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
    
    
    @ViewBuilder
    private func backgroundImage(quote: Quote) -> some View {
        VStack {
            if let imageURL = quote.imageURL {
                LazyImage(url: imageURL, content: { phase in
                    switch phase.result {
                    case .success:
                        phase.image?
                            .resizable()
                            .aspectRatio(quote.aspectRatio, contentMode: .fit)
                    case .failure:
                        Rectangle()
                            .aspectRatio(quote.aspectRatio, contentMode: .fit)
                            .foregroundColor(.secondary)
                    case .none, .some:
                        Rectangle()
                            .aspectRatio(quote.aspectRatio, contentMode: .fit)
                            .foregroundColor(.secondary)
                    }
                })
            }
        }
    }
    
    @ViewBuilder
    private func zstackCardView(quote: Quote) ->  some View {
        backgroundImage(quote: quote)
            .overlay(alignment: .bottomLeading) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(quote.tag)
                        Text(quote.title)
                            .font(.system(size: 25))
                            .textSelection(.enabled)
                        if let source = quote.source {
                            HStack {
                                Spacer()
                                Text(source)
                            }
                        }
                    }
                    .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(28)
            }
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.boundColor, lineWidth: 2)
            )
            .padding()
            .shadow(radius: 20)
    }
    
    @ViewBuilder
    private func verticalCardView(quote: Quote) -> some View {
        VStack(alignment: .leading) {
            backgroundImage(quote: quote)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(quote.tag)
                    .foregroundColor(Color.descriptionFontColor)
                Text(quote.title)
                    .font(.system(size: 20))
                    .textSelection(.enabled)
                if let source = quote.source {
                    HStack {
                        Spacer()
                        Text(source)
                    }
                }
            }
            .padding()
        }
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.boundColor, lineWidth: 2)
        )
        .padding()
    }
}

