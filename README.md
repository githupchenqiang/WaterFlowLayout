# WaterFlowLayout
自定义流水布局
![自定义流水布局](/water.gif)
网络图片加载使用了 Kingfisher  https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet

代码示例
```
下载项目只需要将cqWaterFlowLayout.swift放入到你的工程中
!!!在初始化时只需要将UICollectionViewLayout换为cqWaterFlowLayout并遵循代理,在代理方法中传入数据,

lazy var CollectionView:UICollectionView = {
let layout:cqWaterFlowLayout = cqWaterFlowLayout()
layout.delegate = self
let collection = UICollectionView(frame:CGRect(x: 0, y: 0, width:view.frame.size.width, height:view.frame.size.height), collectionViewLayout: layout)
collection.backgroundColor = UIColor.white
collection.register(UINib.init(nibName: "ShopsCell", bundle: nil), forCellWithReuseIdentifier: "shops")
collection.dataSource = self
return collection;
}()

//代理方法
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

   ///item列数
func columnCountInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
return 3
}

  //返回的是item的高度
func waterflowLayout(waterflowLayout: cqWaterFlowLayout, heightForItemIndex: NSInteger, itemWidth: CGFloat) -> CGFloat {
let model:Source = shopsArray[heightForItemIndex] as! Source

return itemWidth * model.h! / model.w!
}

 ///item左右间距
func columnMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
return 5
}
 ///item上下的间距
func rowMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
return 10;
}
   ///layout距离边框的距离
func edgeInsetsInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> UIEdgeInsets {
return UIEdgeInsetsMake(0, 10, 10, 10)
}

}


```
