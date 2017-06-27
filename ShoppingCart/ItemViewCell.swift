//
//  ItemViewCell.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/24/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell, DropShadow, NibLoadableView {

    @IBOutlet weak var ItemTitle: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemDetails: UILabel!
    @IBOutlet weak var ItemThumb: UIImageView!
    @IBOutlet weak var ItemType: UILabel!
    
    var item: Item!
    
    func configureCell(item: Item) {
        
        self.item = item;
        
        ItemTitle.text = item.title
        ItemPrice.text = "$\(item.price)"
        ItemDetails.text = item.details
        ItemType.text = item.toItemType?.type
        ItemThumb.image = item.toimage?.image as? UIImage
    }
}
