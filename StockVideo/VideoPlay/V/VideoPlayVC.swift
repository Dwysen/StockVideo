//
//  VideoPlayVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/24.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import SnapKit

class VideoPlayVC: BBViewController {

    var image : UIImage!
    
    var videoPlayView : UIView!
    
    var addWatchView : UIView!
    var columnLabel  : UILabel!
    var addWatchBtn : UIButton!
    
    var commentTableView : UITableView!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 200 + 40, width: Common.screenWidth, height: Common.screenHeight - 200 - 40)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let imageView = UIImageView.init(frame: view.bounds)
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        imageView.image = image
//        view.addSubview(imageView)
        
        setupTopView()
        
        setupBottomScrollView()
        
        setupTableView()
        
    }
    
    private func setupTopView(){
        
        videoPlayView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 200))
        videoPlayView.backgroundColor = UIColor.black
        view.addSubview(videoPlayView)
        
        addWatchView = UIView(frame: CGRect(x: 0, y: videoPlayView.maxY, width: Common.screenWidth, height: 40))
        addWatchView.backgroundColor = UIColor.white
        view.addSubview(addWatchView)
        addWatchView.layer.shadowColor = UIColor.black.cgColor
        addWatchView.layer.shadowOffset = CGSize.init(width: 2, height: 3)
        addWatchView.layer.shadowOpacity = 0.8
        addWatchView.layer.shadowRadius = 3
     
        
        
        
        columnLabel = UILabel(frame: CGRect(x: 16, y: 10, width: 300, height: 20))
        columnLabel.text = "栏目栏目"
        columnLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addWatchView.addSubview(columnLabel)
   
        
        addWatchBtn = UIButton()
        addWatchView.addSubview(addWatchBtn)
        addWatchBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.centerY.equalTo(columnLabel)
        }
        addWatchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addWatchBtn.setTitle("+ 关注", for: .normal)
        addWatchBtn.setTitleColor(UIColor.orange, for: .normal)
        
        addWatchBtn.layer.borderWidth = 1
        addWatchBtn.layer.borderColor = UIColor.orange.cgColor
        addWatchBtn.layer.cornerRadius = 5
        addWatchBtn.layer.masksToBounds = true
        
        
        
        
        
    }
    
    private func setupBottomScrollView(){
        
        view.addSubview(scrollView)
        let scrollTopView = Bundle.main.loadNibNamed("VideoPlayTopView", owner: nil, options: nil)?.first as! VideoPlayTopView
        scrollTopView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: 252)
        scrollView.addSubview(scrollTopView)
        
        
    }
    
    private func setupTableView(){
        
        commentTableView = UITableView(frame: CGRect(x: 0, y: 252 + 10, width: Common.screenWidth, height: 500 ))
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.rowHeight = 230
        commentTableView.showsVerticalScrollIndicator = false
        commentTableView.isScrollEnabled = false
        commentTableView.register(UITableViewCell.classForCoder(),forCellReuseIdentifier: "cell")
        
        let grayView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 22))
        grayView.backgroundColor = UIColor.gray
        commentTableView.tableHeaderView = grayView
    
        scrollView.addSubview(commentTableView)
    
  
        
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: 1200)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
}

extension VideoPlayVC : UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
