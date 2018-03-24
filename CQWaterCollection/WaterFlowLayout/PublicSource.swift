//
//  PublicSource.swift
//  CQWaterCollection
//
//  Created by chenq@kensence.com on 2018/3/24.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit
import SwiftyJSON
class PublicSource: NSObject {
  class func getBundleData(pathName:NSString) -> NSMutableArray {
    
    let DataArray:NSMutableArray = NSMutableArray()
    
    let filthPath = Bundle.main.path(forResource:pathName .appending(".plist"), ofType:nil )
    let array = NSArray(contentsOfFile: filthPath!)!
    
    for i in 0..<array.count {
        let dict:NSDictionary = array[i] as! NSDictionary
        let model = Source()
        model.h = dict.value(forKey: "h") as? CGFloat
        model.w = dict.value(forKey: "w") as? CGFloat
        model.img = (dict.value(forKey: "img") as! String)
        model.price = (dict.value(forKey: "price") as! String)
        DataArray .add(model)
    }
        return DataArray
    }
}

