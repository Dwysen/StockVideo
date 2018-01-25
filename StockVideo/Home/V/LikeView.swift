//
//  LikeView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/23.
//  Copyright © 2018年 BoXin. All rights reserved.
//

// Banner版本一

//import UIKit
//
//class LikeView: UIView {
//
//    var CollectionView: UICollectionView?
//    var flowlayout = UICollectionViewFlowLayout()
//    var pageControl = UIPageControl()
//
//    var imgArr : [String]? {
//
//        didSet {
//
//        }
//
//    }
//
//    convenience init(frame: CGRect,imgArr:[String]) {
//        self.init(frame: frame)
//        self.imgArr = imgArr
//
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.createSubviews(frame: frame)
//    }
//
//    func createSubviews(frame: CGRect){
//        CollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
//            , collectionViewLayout: flowlayout)
//        flowlayout.itemSize = CGSize(width:frame.size.width, height:frame.size.height)
//        flowlayout.minimumInteritemSpacing = 0;
//        flowlayout.minimumLineSpacing = 0;
//        flowlayout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        CollectionView!.backgroundColor = UIColor.lightGray
//        CollectionView!.isPagingEnabled = true
//        CollectionView!.dataSource  = self
//        CollectionView!.delegate = self
//        CollectionView!.showsHorizontalScrollIndicator = false
//        CollectionView!.showsVerticalScrollIndicator = false
//        CollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        self.addSubview(CollectionView!)
//        pageControl = UIPageControl.init(frame: CGRect(x:0,y: 0,width:frame.size.width / 2,height:30))
//        pageControl.center = CGPoint(x:frame.size.width / 2, y:frame.size.height - 20);
//        self.addSubview(pageControl);
//
//
//    }
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension LikeView:UICollectionViewDelegate, UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = CollectionView?.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//        for v in cell!.contentView.subviews {
//            v.removeFromSuperview()
//        }
//
//        let newView = HotView.newInstance()
//        newView?.frame = CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: Common.singleBlockHeight)
//        newView?.bgImgView.image = UIImage.init(named: imgArr![indexPath.item])
//        cell?.contentView.addSubview(newView!)
//        return cell!
//
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imgArr!.count
//    }
//}

