//
//  DataProvider.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func timeline() -> Timeline
    func getData(from url: URL) async throws  -> (Data, URLResponse)
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private init() {}
    
    func timeline() -> Timeline {
        let timeline: Timeline = Bundle.main.decode(jsonFileNamed: "timeline")
        return timeline
    }
    
    func getData(from url: URL) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(from: url)
    }
}
