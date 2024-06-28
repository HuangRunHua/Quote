//
//  Quote.swift
//  Quote
//
//  Created by Runhua Huang on 2024/6/27.
//

import Foundation

struct Quote: Identifiable, Codable {
    var id: Int
    var tag: String
    var title: String
    var cardStyle: String
    var date: String
    var image: String
    var source: String?
    var coverImageWidth: CGFloat
    var coverImageHeight: CGFloat
    var jumpScheme: String?
    
    
    var imageURL: URL? {
        return URL(string: self.image)
    }
    
    var aspectRatio: CGFloat {
        return coverImageWidth/coverImageHeight
    }
    
    var style: CardStyle {
        return CardStyle(rawValue: self.cardStyle) ?? .zstack
    }
    
    static let preview: [Quote] = [
        Quote(
            id: 0,
            tag: "信鸽辉光",
            title: "跨过星河迈过月亮去迎接更好的自己。",
            cardStyle: "zstack",
            date: "2024年6月27日",
            image: "https://www.economist.com/cdn-cgi/image/width=1424,quality=80,format=auto/content-assets/images/20240622_LDD003.jpg",
            source: "《小小巴黎书店》",
            coverImageWidth: 1280,
            coverImageHeight: 720
        ),
        Quote(
            id: 1, 
            tag: "苹果格调",
            title: "如果你瞄准月亮\n即使迷失\n也是落在璀璨星辰之间",
            cardStyle: "zstack",
            date: "2024年6月29日",
            image: "https://www.economist.com/cdn-cgi/image/width=1424,quality=80,format=auto/content-assets/images/20240622_CUD001.jpg",
            coverImageWidth: 4288,
            coverImageHeight: 4800
        )
    ]
}
