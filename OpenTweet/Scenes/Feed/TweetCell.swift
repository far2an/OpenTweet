//
//  TweetCell.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

struct TweetViewModel {
    var username: String
    var date: Date
    var content: String
    var imageURL: URL?
}

final class TweetCell: UICollectionViewCell, NibLoadable {
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func update(with viewModel: TweetViewModel) {
        imageView.setImage(with: viewModel.imageURL)
        usernameLabel.text = viewModel.username
        dateLabel.text = viewModel.date.string(using: .tweetDateFormatter).appendSeparator()
        contentLabel.attributedText = viewModel.content.updateArrtibutes()
    }
}

private extension String {
    func appendSeparator() -> String {
        ["·", self].joined(separator: " ")
    }
}
