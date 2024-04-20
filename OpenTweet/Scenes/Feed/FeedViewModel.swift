//
//  FeedViewModel.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

protocol FeedViewModelProtocol {
    var timeline: TimelineViewModel { get }
    
    func fetchTimeline()
    func tweetTapped(with id: String) -> TimelineViewModel?
}

struct TimelineViewModel {
    let tweets: [TweetViewModel]
}

final class FeedViewModel {
    private let service: NetworkServiceProtocol
    
    private var timelineModel: Timeline?

    var timeline: TimelineViewModel
    
    init(service: NetworkServiceProtocol = NetworkService.shared, 
         timeline: TimelineViewModel = TimelineViewModel(tweets: [])) {
        self.service = service
        self.timeline = timeline
    }
}

extension FeedViewModel: FeedViewModelProtocol {
    func tweetTapped(with id: String) -> TimelineViewModel? {
        guard let tweet = timelineModel?.tweets.first(where: { $0.id == id }) else {
            return nil
        }
        
        var tweets = [tweet]

        let replies = timelineModel?.tweets.filter { $0.inReplyTo == id } ?? []
        if let parent = timelineModel?.tweets.first(where: { $0.id == tweet.inReplyTo }), replies.isEmpty {
            tweets.insert(parent, at: 0)
        } else {
            tweets.append(contentsOf: replies)
        }
        return Timeline(tweets: tweets).convert()
    }
    
    func fetchTimeline() {
        let result = service.timeline()
        timeline = result.convert()
        timelineModel = result
    }
}

