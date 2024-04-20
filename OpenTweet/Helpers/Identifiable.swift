//
//  Identifiable.swift
//  OpenTweet
//
//  Created by Farzan Abdollahi on 20.04.24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

public protocol Identifiable {
    /// The type's identifier
    static var identifier: String { get }
}

extension Identifiable {
    /// Default implementation – returns the type name itself
    public static var identifier: String {
        String(describing: self)
    }
}

public protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibLoadable where Self: Identifiable {
    public static var nib: UINib {
        UINib(nibName: identifier, bundle: .main)
    }
}

extension UIView: Identifiable {}
