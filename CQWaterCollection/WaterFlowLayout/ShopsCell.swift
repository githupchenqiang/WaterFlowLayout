//
//  ShopsCell.swift
//  CQWaterCollection
//
//  Created by chenq@kensence.com on 2018/3/23.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit
import Kingfisher
class ShopsCell: UICollectionViewCell {
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        backgroundColor = .red
    }
    
    func setShopsData(shop:Source){
        let url = URL(string: shop.img!)
       Image.kf.setImage(with: url)
        label.text = shop.price
    }
    
}
