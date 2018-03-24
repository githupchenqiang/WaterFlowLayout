//
//  cqWaterFlowLayout.swift
//  CQWaterCollection
//
//  Created by chenq@kensence.com on 2018/3/23.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

protocol cqWaterFlowLayoutDelegate:NSObjectProtocol {
    
    //返回的是item的高度
    func  waterflowLayout(waterflowLayout:cqWaterFlowLayout,heightForItemIndex:NSInteger,itemWidth:CGFloat)->CGFloat
    ///item列数
     func columnCountInWaterflowLayout(waterflowLayout:cqWaterFlowLayout) -> CGFloat
    
    ///item左右间距
     func columnMarginInWaterflowLayout(waterflowLayout:cqWaterFlowLayout) -> CGFloat
    ///item上下的间距
     func rowMarginInWaterflowLayout(waterflowLayout:cqWaterFlowLayout) -> CGFloat
    
    ///layout距离边框的距离
    func edgeInsetsInWaterflowLayout(waterflowLayout:cqWaterFlowLayout) -> UIEdgeInsets
}

class cqWaterFlowLayout: UICollectionViewLayout {

    ///声明代理
    weak var delegate:cqWaterFlowLayoutDelegate?
    ///默认的列数
    let defaltcolumnCount   = 3
    ///每一列之间的距离
    let defaltColumnMargin = 10
    ///每一行之间的距离
    let defaltRowMargin = 10
    /** 边缘间距 */
    let defaultEdgeInsets:UIEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    /** 存放所有cell的布局属性 */
//    var attrsArray:NSMutableArray?
    /** 存放所有列的当前高度 */
//    var columnHeights:NSMutableArray?
    //内容高度
    var contentHeight:CGFloat?
   
    func Rowmargin() -> CGFloat {
        if (delegate != nil) {
            return  (delegate?.rowMarginInWaterflowLayout(waterflowLayout: self))!
        }else{
            return CGFloat(defaltRowMargin)
        }
    }
    
    
    func columnMargin() -> CGFloat {
        if delegate != nil {
            return (delegate?.columnMarginInWaterflowLayout(waterflowLayout: self))!
        }else
        {
            return CGFloat(defaltColumnMargin);
        }
    }
    
    func columCount() -> NSInteger {
        if delegate != nil {
            return NSInteger((delegate?.columnCountInWaterflowLayout(waterflowLayout: self))!)
        }else
        {
            return defaltcolumnCount
        }
    }
    
    
    func edgeInsets() -> UIEdgeInsets {
        if delegate != nil {
            return (delegate?.edgeInsetsInWaterflowLayout(waterflowLayout: self))!
        }else
        {
            return defaultEdgeInsets
        }
    }

        /** 存放所有列的当前高度 */
    private lazy var columnHeights:NSMutableArray = {
        var array = NSMutableArray()
        return array
    }()
        /** 存放所有cell的布局属性 */
    private lazy var attrsArray:NSMutableArray = {
       var attrs = NSMutableArray()
        return attrs
    }()
    
    /// 初始化
    override func prepare() {
        super.prepare()
        contentHeight = 0
        
        //清除之前计算的高度
    self.columnHeights.removeAllObjects()
        
        for _ in 0..<columCount() {
            columnHeights.add(edgeInsets().top)
        }
        
        //清除之前所有的布局
        self.attrsArray.removeAllObjects()
        ///穿件每一个cell对应的布局属性
        let count:NSInteger = (collectionView?.numberOfItems(inSection: 0))!
        for i in 0..<count {
            //创建位置
            let indexpath:NSIndexPath = NSIndexPath(item: i, section: 0)
            //获取indexpath位置cell对应的布局属性
            let atts:UICollectionViewLayoutAttributes = layoutAttributesForItem(at: indexpath as IndexPath)!
            attrsArray.add(atts)
        }
    }
    //决定cell的排布位置
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (attrsArray as! [UICollectionViewLayoutAttributes])
    }
    
    
    //返回indexpath位置cell对应的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //创建布局属性
        let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        //collectionview的宽度
        let collectionViewW = collectionView?.frame.size.width
    
        
        //设置布局属性的frame
        
        let w:CGFloat  = (collectionViewW! - edgeInsets().left - edgeInsets().right - CGFloat((columCount() - 1))*self.columnMargin())/CGFloat(self.columCount())
        
        let h:CGFloat = (delegate?.waterflowLayout(waterflowLayout: self, heightForItemIndex: indexPath.item, itemWidth: w))!
        //找出最短的那一列
        var desColumn = 0;
        var minColumnHeight:CGFloat = self.columnHeights[0] as! CGFloat
        for i in 0..<columCount() {
            //取第i列的高度
            let columnHeigh:CGFloat = self.columnHeights[i] as! CGFloat
            if minColumnHeight > columnHeigh {
                minColumnHeight = columnHeigh
                desColumn = i
            }
        }
        let x:CGFloat = self.edgeInsets().left + CGFloat(desColumn) * (w + columnMargin())
        var y:CGFloat = minColumnHeight;
        if y != edgeInsets().top{
            y += Rowmargin()
        }
        attributes.frame = CGRect(x: x, y: y, width: w, height: h)
        
        //跟新最短的那列的高度
        columnHeights[desColumn] = (attributes.frame.maxY)
        //记录内容的高度
        let columnheight:CGFloat = columnHeights[desColumn] as! CGFloat
        if self.contentHeight! < columnheight {
            self.contentHeight = columnheight
        }
        return attributes
    }
  
    override var collectionViewContentSize: CGSize{
        get{
            return CGSize(width: 0, height: self.contentHeight! + self.edgeInsets().bottom)
        }
    }
    
    
    
}
