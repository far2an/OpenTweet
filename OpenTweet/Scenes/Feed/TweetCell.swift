//
//  TweetCell.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

struct TweetViewModel {
    var id: String
    var username: String
    var date: Date
    var content: String
    var imageURL: URL?
}

enum AnimationType {
    case expand
    case shrink
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
    
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func update(with viewModel: TweetViewModel) {
        imageView.setImage(with: viewModel.imageURL)
        usernameLabel.text = viewModel.username
        dateLabel.text = viewModel.date.string(using: .tweetDateFormatter).appendSeparator()
        contentLabel.attributedText = viewModel.content.updateArrtibutes()
    }
    
    func animate(type: AnimationType) {
        if animator.isRunning {
            animator.stopAnimation(true)
        }
        
        switch type {
        case .expand:
            let shouldExpand = self.transform == .identity
            animator.addAnimations {
                self.transform = shouldExpand ? CGAffineTransform(scaleX: 1.05, y: 1.05) : .identity
                self.backgroundColor = shouldExpand ? .systemGray6 : nil
            }
        case .shrink:
            animator.addAnimations {
                self.transform = .identity
                self.backgroundColor = nil
            }
        }
        
        animator.startAnimation()
    }
}

private extension String {
    func appendSeparator() -> String {
        ["·", self].joined(separator: " ")
    }
}
