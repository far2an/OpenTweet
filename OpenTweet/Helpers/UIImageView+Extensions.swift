//
//  UIImage+Extensions.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    public func setImage(with url: URL?, placeholder: UIImage = UIImage(imageLiteralResourceName: "placeholder")) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        self.image = placeholder
        Task { [weak self] in
            let (data, _) = try await NetworkService.shared.getData(from: url)
            guard let image = UIImage(data: data) else {
                return
            }
            
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            self?.image = image
        }
    }
}
