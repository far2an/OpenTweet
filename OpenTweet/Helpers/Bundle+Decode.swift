//
//  Bundle+Decode.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

extension Bundle {
    private func failableDecode<T: Decodable>(jsonFileNamed fileName: String, decoder: JSONDecoder) throws -> T {
        guard let url = self.url(forResource: fileName, withExtension: "json") else {
            throw JSONNotFoundError()
        }

        return try decoder.decode(T.self, from: url)
    }

    func decode<T: Decodable>(jsonFileNamed fileName: String, decoder: JSONDecoder = JSONDecoder()) -> T {
        try! failableDecode(jsonFileNamed: fileName, decoder: decoder)
    }
}

extension JSONDecoder {
    final func decode<T: Decodable>(_ type: T.Type, from url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try decode(T.self, from: data)
    }
}

struct JSONNotFoundError: Error {}
