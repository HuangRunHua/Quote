//
//  QuoteCardRow.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import SwiftUI
import NukeUI

@MainActor
struct QuoteCardRow: View {
    private let cornerRadius: CGFloat = 10
    var useLocalImage: Bool = false
    var quote: Quote?
    var showDate: Bool = false
    var body: some View {
        cardView
    }
}

#Preview("Default") {
    QuoteCardRow(quote: Quote.preview[1])
}

#Preview {
    QuoteCardRow(useLocalImage: true, quote: Quote.preview[1], showDate: true)
}

#Preview("Local Image Not Showing Date") {
    QuoteCardRow(useLocalImage: true, quote: Quote.preview[1], showDate: false)
}

extension QuoteCardRow {
    @ViewBuilder
    private var cardView: some View {
        if let quote = quote {
            switch quote.style {
            case .zstack:
                zstackCardView(quote: quote)
            case .vertical:
                verticalCardView(quote: quote)
            }
        } else {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
    
    
    @ViewBuilder
    private func backgroundImage(quote: Quote) -> some View {
        VStack {
            if self.useLocalImage {
                Image("test")
                    .resizable()
                    .aspectRatio(quote.aspectRatio, contentMode: .fit)
            } else {
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
                        if showDate {
                            HStack {
                                Spacer()
                                Text(quote.date)
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
                if showDate {
                    HStack {
                        Spacer()
                        Text(quote.date)
                            .foregroundColor(Color.descriptionFontColor)
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
    }
}
