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
            tag: "时光女王",
            title: "因为从心底害怕自己不值得被爱，我们独来独往，”那一段是这样的，“然而就是因为独来独往，才让我们以为自己不值得被爱。有一天，你不知道是什么时候，你会驱车上路。有一天，你不知道是什么时候，你会遇到他（她）。你会被爱，因为你今生第一次真正不再孤单。你会选择不再孤单下去。",
            cardStyle: "vertical",
            date: "2024年6月27日",
            image: "https://www.economist.com/cdn-cgi/image/width=1424,quality=80,format=auto/content-assets/images/20240622_CUD001.jpg",
            source: "《岛上书店》",
            coverImageWidth: 1280,
            coverImageHeight: 720
        )
    ]
}
