//
//  UICollectionView+Extensions.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Unknown cell reuse identifier \(T.identifier)")
        }
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Unknown supplementary view reuse identifier \(T.identifier)")
        }
        return view
    }
    
    public func register<T: UICollectionViewCell>(cell: T.Type) where T: ClassLoadable {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    public func register<T: UICollectionViewCell>(cell: T.Type) where T: NibLoadable {
        register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }
}
