//
//  String+Extensions.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

extension String {
    func date() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)!
    }
}
