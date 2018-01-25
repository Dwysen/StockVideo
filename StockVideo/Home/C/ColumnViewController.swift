//
//  ColumnViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/24.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class ColumnViewController: UIViewController {

    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

    
    }

    private func setupCollectionView(){
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.scrollViewHeight ), collectionViewLayout: flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(ColumnCollectionCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ColumnViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColumnCollectionCell
        

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VideoPlayVC()
        vc.title = String( indexPath.row )
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Common.screenWidth / 2, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
}
