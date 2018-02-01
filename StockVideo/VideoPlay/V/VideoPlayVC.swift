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

    
    let testStr = ["第一层，一般情况下是杀死就好了，不会“给猴看”；第二层就很严重了，一般情况下会是规模性封杀（参考17年6月份的娱乐账号），但是也不会告诉你为什么，让大家去猜、去找红线，这样才能起到足够的震慑力。"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？", " 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"]
    
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
        
        self.navigationController?.isNavigationBarHidden = true
        
        setupTopView()
        
//        setupBottomScrollView()
        
        setupTableView()
        
    }
    
    private func setupTopView(){
        
        videoPlayView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 200))
        videoPlayView.backgroundColor = UIColor.black
        view.addSubview(videoPlayView)
        
        addWatchView = UIView(frame: CGRect(x: 0, y: videoPlayView.maxY, width: Common.screenWidth, height: 40))
        addWatchView.backgroundColor = UIColor.white
        view.addSubview(addWatchView)
       
        
        let layerView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 40))
        addWatchView.addSubview(layerView)
        layerView.backgroundColor = UIColor.white
        layerView.layer.shadowColor = UIColor.black.cgColor
        layerView.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        layerView.layer.shadowOpacity = 0.05
        layerView.layer.shadowRadius = 3
        
        columnLabel = UILabel(frame: CGRect(x: 16, y: 7, width: 300, height: 20))
        columnLabel.text = "栏目栏目"
        columnLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        layerView.addSubview(columnLabel)
   
        addWatchBtn = UIButton()
        layerView.addSubview(addWatchBtn)
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
    
//    private func setupBottomScrollView(){
//
//        view.addSubview(scrollView)
//        let scrollTopView = Bundle.main.loadNibNamed("VideoPlayTopView", owner: nil, options: nil)?.first as! VideoPlayTopView
//        scrollTopView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: 252)
//        scrollView.addSubview(scrollTopView)
//
//
//    }
    
    private func setupTableView(){
        
        commentTableView = UITableView(frame: CGRect(x: 0, y: 240, width: Common.screenWidth, height: Common.screenHeight - 240 ))
        commentTableView.delegate = self
        commentTableView.dataSource = self
  
        commentTableView.showsVerticalScrollIndicator = false
        
        commentTableView.register(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        commentTableView.separatorStyle = .none
        
//        commentTableView.rowHeight = UITableViewAutomaticDimension 
        commentTableView.estimatedRowHeight = 200
        
//        let grayView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 22))
//        grayView.backgroundColor = UIColor.gray
        
        let tableTopView = Bundle.main.loadNibNamed("VideoPlayTopView", owner: nil, options: nil)?.first as! VideoPlayTopView
        commentTableView.tableHeaderView = tableTopView
        
        view.addSubview(commentTableView)
        view.bringSubview(toFront: addWatchView)
        
//        scrollView.addSubview(commentTableView)
//        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: 1200)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
}

extension VideoPlayVC : UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return testStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
        
        cell.contentTextLabel.attributedText = Common.getAttributeStringWithString(testStr[indexPath.row], lineSpace: 2)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension VideoPlayVC : tapAvatarDelegate {
    
    func tapImg() {
        let vc = SomeoneViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
