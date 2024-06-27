//
//  QuoteLoader.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import Foundation

enum DatabaseLink {
    // MARK: - Github平台
    static let todayQuoteURL: String = "https://github.com/HuangRunHua/Quote/raw/main/today.json"
    static let historyQuotesURL: String = "https://github.com/HuangRunHua/Quote/raw/main/history.json"
    // MARK: - Gitee平台
    static let todayQuoteURLFromGitee: String = "https://gitee.com/huangrunhua/Quote/raw/main/today.json"
    static let historyQuotesURLFromGitee: String = "https://gitee.com/huangrunhua/Quote/raw/main/history.json"
}

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
    
    // MARK: - 获取今日Quote用
    private func _fetchRemoteTodayQuote(from urlString: String) async {
        guard let databaseURL = URL(string: urlString) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: databaseURL)
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self._parseSingleQuoteJsonData(data: data)
                }
            }
        } catch {
            print("Error in _fetchRemoteTodayQuote: \(error.localizedDescription)")
        }
    }
    
    private func _parseSingleQuoteJsonData(data: Data) {
        let decoder = JSONDecoder()
        do {
            self.todayQuote = try decoder.decode(Quote.self, from: data)
        } catch {
            print("Error in _parseSingleQuoteJsonData: \(error)")
        }
    }
    
    func fetchTodayQuote() async {
        await self._fetchRemoteTodayQuote(from: DatabaseLink.todayQuoteURLFromGitee)
    }
    
    // MARK: - 获取历史Quotes用
    private func _fetchRemoteHistoryQuotes(from urlString: String) async {
        guard let databaseURL = URL(string: urlString) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: databaseURL)
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self._parseQuotesJsonData(data: data)
                }
            }
        } catch {
            print("Error in _fetchRemoteHistoryQuotes: \(error.localizedDescription)")
        }
    }
    
    private func _parseQuotesJsonData(data: Data) {
        let decoder = JSONDecoder()
        do {
            self.quotes = try decoder.decode([Quote].self, from: data)
        } catch {
            print("Error in _parseQuotesJsonData: \(error)")
        }
    }
    
    func fetchQuotes() async {
        await self._fetchRemoteHistoryQuotes(from: DatabaseLink.historyQuotesURLFromGitee)
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
