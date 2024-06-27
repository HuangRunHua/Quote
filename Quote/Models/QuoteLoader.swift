//
//  QuoteLoader.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import Foundation

final class QuoteLoader: ObservableObject, Decodable {
    @Published var todayQuote: Quote?
    @Published var quotes: [Quote] = []
    
    enum CodingKeys: CodingKey {
        case quotes
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        quotes = try value.decode([Quote].self, forKey: .quotes)
    }
    
    init() {}
    
    func fetchTodayQuote() async {
        self.todayQuote = load("demo.json")
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
