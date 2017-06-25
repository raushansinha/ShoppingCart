//
//  UITableView+Ext.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/24/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_:T.Type) where T: ReusableView, T:NibLoadableView {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T
            else {
                fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UITableViewCell:  ReusableView { }
