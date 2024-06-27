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
    @Environment(\.openURL) private var openURL
    private let cornerRadius: CGFloat = 10
    @State private var quotes: [Quote] = []
    @State private var today = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(Date.monthDayDateChinaStyle(date: today))
                            .font(.system(size: 40, weight: .heavy))
                        Text(Date.weekdayChinaStyle(date: today))
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
                    .onTapGesture {
                        if let jumpScheme = quoteLoader.todayQuote?.jumpScheme, let url = URL(string: "jumpScheme") {
                            openURL(url)
                        }
                    }
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
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.today = Date()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(QuoteLoader())
        .environment(\.locale, .init(identifier: "zh"))
}
