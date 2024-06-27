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
    var quote: Quote?
    var body: some View {
        cardView
    }
}

#Preview {
    QuoteCardRow(quote: Quote.preview[0])
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
//            .padding()
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
    }
}
