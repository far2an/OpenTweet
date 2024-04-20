//
//  FeedViewModel.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TimelineViewModel {
    let tweets: [TweetViewModel]
}

protocol FeedViewModelProtocol {
    var timeline: TimelineViewModel { get }
    
    func fetchTimeline()
}

final class FeedViewModel {
    private let service: NetworkServiceProtocol

    var timeline = TimelineViewModel(tweets: [])
    
    init(service: NetworkServiceProtocol = NetworkService.shared) {
        self.service = service
    }
}

extension FeedViewModel: FeedViewModelProtocol {
    func fetchTimeline() {
        self.timeline = service.timeline().convert()
    }
}

