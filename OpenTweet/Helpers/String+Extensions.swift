//
//  String+Extensions.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

extension String {
    func date() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)!
    }
    
    func updateArrtibutes() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let linkMatches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        linkMatches.forEach { match in
            attributedString.addAttributes([.foregroundColor: UIColor.blue], range: match.range)
        }
        
        let regex = try? NSRegularExpression(pattern: "\\@\\w+")
        let mentionMatches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        mentionMatches?.forEach { match in
            attributedString.addAttributes([.foregroundColor: UIColor.blue], range: match.range)
        }
        
        return attributedString
    }
}
