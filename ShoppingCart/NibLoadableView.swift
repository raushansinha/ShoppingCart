//
//  NibLoadableView.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/24/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

