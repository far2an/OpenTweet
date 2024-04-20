//
//  Date+Extension.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

extension Date {
    func string(using dateFormatter: DateFormatter) -> String {
        dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    static let tweetDateFormatter = DateFormatter(format: "dd.MM.yy")

    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}
