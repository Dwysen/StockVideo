//
//  SomeoneLikeViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/29.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit



class SomeoneLikeViewController: UIViewController {

    let imgArr = ["stock-photo-1","stock-photo-2","stock-photo-3","stock-photo-4","stock-photo-5"]
    
    private let reuseIdentifier = "Cell"
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupCollectionView()
        
        setupTableView()

    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: 5 * 230 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 230
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
    }
    
//    private func setupCollectionView(){
//
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        self.collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flowLayout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SomeoneLikeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonCell
        cell.bgImgView.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
}
