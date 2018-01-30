//
//  SomeoneViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/26.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import MJRefresh

extension UINavigationController {
    func setAlpha(){
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}

class SomeoneViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight)
        return scrollView
    }()
    
    
    var headBackImgView: UIImageView!
    
    var backArrBtn : UIButton!
    
    var avatarImgView: UIImageView!
    
    var nameLabel : UILabel!
    var introduceLabel : UILabel!
    var fansLabel : UILabel!
    var fansCountLabel : UILabel!
    var watchLabel : UILabel!
    var watchCountLabel : UILabel!
    
    var btnBackView: UIView!
    var dynamicStateBtn: UIButton!
    var likeBtn: UIButton!
    var indicatorView: UIView!
    var lineView : UIView!
    
    var collectionView : UICollectionView!
    
    var testArr = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    
    let footer = MJRefreshAutoNormalFooter()
    
    let likeViewFooter = MJRefreshAutoNormalFooter()
    
    var likeCollectionView : UIView!
    
    
    private let singleCellHeight =  ( Common.screenWidth - 2 * 5 - 2 * 3 ) / 3
    
    //    private lazy var likeColleciontView:UICollectionView = {
    
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI(){
        
        navigationController?.isNavigationBarHidden = true
        
        //        navigationController?.setAlpha()
        
        view.addSubview(scrollView)
        
        headBackImgView = UIImageView(frame: CGRect(x: 0, y: -20, width: Common.screenWidth, height: 200))
        // 否则子控件返回按钮不响应
        headBackImgView.isUserInteractionEnabled = true
        headBackImgView.contentMode = .scaleAspectFill
        headBackImgView.layer.masksToBounds = true
        
        
        headBackImgView.image = UIImage.init(named: "background")
        scrollView.addSubview(headBackImgView)
        headBackImgView.addSubview(Common.getBlackView(frame: headBackImgView.bounds))
        
        backArrBtn = UIButton()
        headBackImgView.addSubview(backArrBtn)
        backArrBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        backArrBtn.setImage(UIImage.init(named: "backImage"), for: .normal)
        backArrBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        
        avatarImgView = UIImageView(frame: CGRect(x: 20, y: 80, width: 60, height: 60))
        avatarImgView.layer.cornerRadius = 30
        avatarImgView.layer.masksToBounds = true
        avatarImgView.layer.borderColor = UIColor.white.cgColor
        avatarImgView.layer.borderWidth = 2
        headBackImgView.addSubview(avatarImgView)
        // 设置特定圆角
        
        nameLabel = UILabel()
        headBackImgView.addSubview(nameLabel)
        nameLabel.text = "aaaaaaaaaaaaaaaa"
        nameLabel.textColor = UIColor.white
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImgView.snp.right).offset(20)
            make.top.equalTo(avatarImgView)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        
        introduceLabel = UILabel()
        headBackImgView.addSubview(introduceLabel)
        introduceLabel.text = "aaaaaaaaaaaaaaaa"
        introduceLabel.textColor = UIColor.init(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        introduceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImgView.snp.right).offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        
        
        fansLabel = UILabel()
        headBackImgView.addSubview(fansLabel)
        fansLabel.text = "粉丝"
        fansLabel.sizeToFit()
        fansLabel.textColor = UIColor.white
        fansLabel.font = UIFont.systemFont(ofSize: 12)
        fansLabel.snp.makeConstraints { (make) in
            make.left.equalTo(introduceLabel)
            make.top.equalTo(introduceLabel.snp.bottom).offset(16)
        }
        
        fansCountLabel = UILabel()
        headBackImgView.addSubview(fansCountLabel)
        fansCountLabel.text = "22222"
        fansCountLabel.sizeToFit()
        fansCountLabel.textColor = UIColor.white
        fansCountLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        fansCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(fansLabel.snp.right).offset(10)
        }
        
        watchLabel = UILabel()
        headBackImgView.addSubview(watchLabel)
        watchLabel.text = "关注"
        watchLabel.sizeToFit()
        watchLabel.textColor = UIColor.white
        watchLabel.font = UIFont.systemFont(ofSize: 12)
        watchLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(fansCountLabel.snp.right).offset(50)
        }
        
        watchCountLabel = UILabel()
        headBackImgView.addSubview(watchCountLabel)
        watchCountLabel.text = "22222"
        watchCountLabel.sizeToFit()
        watchCountLabel.textColor = UIColor.white
        watchCountLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        watchCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(watchLabel.snp.right).offset(10)
        }
        
        btnBackView = UIView()
        scrollView.addSubview(btnBackView)
        scrollView.bringSubview(toFront: btnBackView)
        btnBackView.backgroundColor = UIColor.white
        btnBackView.layer.cornerRadius = 15
        btnBackView.layer.masksToBounds = true
        btnBackView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            //            make.left.right.equalToSuperview()
            make.top.equalTo(headBackImgView.snp.bottom).offset(-13)
        }
        
        //        btnBackView.layer.addSublayer(myLayer)
        //        btnBackView.backgroundColor = UIColor.clear
        
        //        findBtn.setTitleColor(UIColor.black, for: .normal)
        dynamicStateBtn = UIButton()
        btnBackView.addSubview(dynamicStateBtn)
        dynamicStateBtn.tag = 1
        dynamicStateBtn.setTitle("动态", for: .normal)
        dynamicStateBtn.setTitleColor(UIColor.black, for: .normal)
        dynamicStateBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        dynamicStateBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        likeBtn = UIButton()
        btnBackView.addSubview(likeBtn)
        likeBtn.tag = 2
        likeBtn.setTitle("喜欢", for: .normal)
        likeBtn.setTitleColor(UIColor.black, for: .normal)
        likeBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        likeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(40)
            
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        indicatorView = UIView()
        btnBackView.addSubview(indicatorView)
        indicatorView.backgroundColor = Common.commonYellow
        let indicatorWidth:CGFloat = 20
        
        indicatorView.snp.makeConstraints { (make) in
            
            make.width.equalTo(indicatorWidth)
            make.left.equalToSuperview().offset(Common.screenWidth / 4 - indicatorWidth / 2)
            
            make.bottom.equalToSuperview().offset(-2)
            make.height.equalTo(2)
            
        }
        
        lineView = UIView()
        btnBackView.addSubview(lineView)
        lineView.alpha = 0.2
        lineView.backgroundColor = UIColor.lightGray
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.left.equalToSuperview()
            make.width.equalTo(Common.screenWidth)
        }
        
        //        @IBOutlet weak var headBackImgView: UIImageView!
        //        @IBOutlet weak var avatarImgView: UIImageView!
        //
        //        @IBOutlet weak var btnBackView: UIView!
        //
        //        @IBOutlet weak var dynamicStateBtn: UIButton!
        //        @IBOutlet weak var likeBtn: UIButton!
        //
        //        @IBOutlet weak var indicatorView: UIView!
        
        // MARK: - setup CollectionView
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 200 + 50 - 13, width: Common.screenWidth, height: 6 * singleCellHeight + 5 * 3), collectionViewLayout: flowLayout)
        scrollView.addSubview(collectionView)
//        collectionView.snp.makeConstraints { (make) in
//            make.top.equalTo(btnBackView.snp.bottom)
//            make.left.equalToSuperview()
//            make.width.equalTo(Common.screenWidth)
//            make.height.equalTo(6 * singleCellHeight + 5 * 3 )
//        }

        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(ColumnCollectionCell.self, forCellWithReuseIdentifier: "cell")
   
        footer.setRefreshingTarget(self, refreshingAction: #selector(footRefresh))
        likeViewFooter.setRefreshingTarget(self, refreshingAction: #selector(likeViewRefresh))
        scrollView.mj_footer = footer
        
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: collectionView.maxY + 10)
        
        let cgrect =  scrollView.convert(collectionView.frame, from: self.view)
        print(cgrect)
        
        print(collectionView.maxY)
        print(collectionView.bottom)
        print(collectionView.y)
        
        print(introduceLabel.maxY)
        print(introduceLabel.bottom)
        print(introduceLabel.y)

    }
    
    @objc private func titleBtnClick(sender:UIButton){
        
        if sender.tag == 1 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.indicatorView.centerX = self.dynamicStateBtn.centerX
                self.collectionView.alpha = 1
                self.scrollView.mj_footer = self.footer
                self.scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: self.collectionView.maxY + 10)
                
                if self.likeCollectionView != nil {
                    
                    self.likeCollectionView.alpha = 0
                    
                }
                
                //                self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                
            })
            
        } else {
            
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.indicatorView.centerX = self.likeBtn.centerX
                self.collectionView.alpha = 0
                self.footer.alpha = 0
           
                if self.likeCollectionView == nil {
                    let vc = SomeoneLikeViewController()
                    self.addChildViewController(vc)
                    self.likeCollectionView = vc.view
                    self.likeCollectionView?.frame = CGRect(x: 0, y: 200 + 50 - 13, width: Common.screenWidth, height: 5 * 230)
                    self.scrollView.addSubview(self.likeCollectionView!)
                    self.scrollView.mj_footer = self.likeViewFooter
                    
                } else {
                    self.likeCollectionView.alpha = 1
                    self.scrollView.mj_footer = self.likeViewFooter
                }
                
                print(self.likeCollectionView.maxY)
                
                 self.scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: self.likeCollectionView.maxY + 10)
                
             
//                self.contentScrollView.setContentOffset(CGPoint.init(x: Common.screenWidth, y: 0), animated: true)
            })
        }
    }
    
    @objc private func footRefresh(){
        
        for i in 0 ..< 18 {
            testArr.append(i)
        }
        
        print(collectionView.height)
        
        collectionView.height +=  6 * singleCellHeight + 5 * 3
        
        let nextContentHeight = scrollView.contentSize.height + 6 * singleCellHeight + 5 * 3
        
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: nextContentHeight)
        //        let height = collectionView.height + singleCellHeight + 3
        //        collectionView.snp.updateConstraints { (make) in
        //            make.height.equalTo(height)
        //        }
        collectionView.reloadData()
        
        print(collectionView.height)
        
        //        collectionView.reloadData()
        footer.endRefreshing()
        
        
    }
    
    @objc private func likeViewRefresh(){
        
        print("1")
        
        likeViewFooter.endRefreshing()
        
        
        
    }
    
    @objc private func backBtnClick(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SomeoneViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArr.count
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
        return CGSize(width: singleCellHeight, height: singleCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 5, bottom:10 , right: 5)
        }
}
