//
//  Timeline.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

struct Timeline: Decodable {
    let tweets: [Tweet]
}

extension Timeline {
    private enum CodingKeys: String, CodingKey {
        case tweets = "timeline"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tweets = try container.decode([Tweet].self, forKey: .tweets)
    }
}

extension Timeline {
    func convert() -> TimelineViewModel {
        TimelineViewModel(tweets: tweets.map {
            TweetViewModel(id: $0.id,
                           username: $0.author,
                           date: $0.dateString.date(),
                           content: $0.content,
                           imageURL: $0.avatar)
        })
    }
}
