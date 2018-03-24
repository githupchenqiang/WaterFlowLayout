//
//  ViewController.swift
//  CQWaterCollection
//
//  Created by chenq@kensence.com on 2018/3/23.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(CollectionView);
        loaddata()
        CollectionView.reloadData()
    }
    
    
    func loaddata() {
        self.shopsArray = PublicSource.getBundleData(pathName: "1")
    }

    private lazy var shopsArray: NSMutableArray = {
        let shop = NSMutableArray()
        return shop
    }()

    lazy var CollectionView:UICollectionView = {
        let layout:cqWaterFlowLayout = cqWaterFlowLayout()
        layout.delegate = self
        let collection = UICollectionView(frame:CGRect(x: 0, y: 0, width:view.frame.size.width, height:view.frame.size.height), collectionViewLayout: layout)
    collection.backgroundColor = UIColor.white
        collection.register(UINib.init(nibName: "ShopsCell", bundle: nil), forCellWithReuseIdentifier: "shops")
        collection.dataSource = self
        return collection;
    }()
}


extension ViewController:UICollectionViewDataSource,cqWaterFlowLayoutDelegate,UITableViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShopsCell = CollectionView.dequeueReusableCell(withReuseIdentifier: "shops", for: indexPath) as! ShopsCell
          let model:Source = shopsArray[indexPath.row] as! Source
        cell.setShopsData(shop: model)
        return cell
    }
    
    func columnCountInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 3
    }
    
    func waterflowLayout(waterflowLayout: cqWaterFlowLayout, heightForItemIndex: NSInteger, itemWidth: CGFloat) -> CGFloat {
        let model:Source = shopsArray[heightForItemIndex] as! Source
        
        return itemWidth * model.h! / model.w!
    }
    
    func columnMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 5
    }
    
    func rowMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 10;
    }
    
    func edgeInsetsInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
}

