//
//  Tweet.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    let id: String
    let author: String
    let content: String
    let avatar: URL?
    let dateString: String
    let inReplyTo: String?
}

extension Tweet {
    private enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case avatar
        case dateString = "date"
        case inReplyTo
    }
}
