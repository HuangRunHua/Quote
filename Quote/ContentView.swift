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
    private let cornerRadius: CGFloat = 10
    var quote: Quote
    var body: some View {
        NavigationView {
            ScrollView {
                cardView
            }
            .navigationTitle(Text("June 27"))
        }
    }
}

#Preview {
    ContentView(quote: Quote.preview[1])
}


extension ContentView {
    @ViewBuilder
    private var cardView: some View {
        switch quote.cardStyle {
        case .zstack:
            zstackCardView
        case .vertical:
            verticalCardView
        }
    }
    
    
    @ViewBuilder
    private var backgroundImage: some View {
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
    
    private var zstackCardView: some View {
        backgroundImage
            .overlay(alignment: .bottomLeading) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(quote.tag)
                        Text(quote.title)
                            .font(.system(size: 25))
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
    
    
    private var verticalCardView: some View {
        VStack(alignment: .leading) {
            backgroundImage
            
            VStack(alignment: .leading, spacing: 10) {
                Text(quote.tag)
                    .foregroundColor(Color.descriptionFontColor)
                Text(quote.title)
                    .font(.system(size: 20))
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

