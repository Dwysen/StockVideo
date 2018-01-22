//
//  HomeViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/22.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

private enum EType : Int {
    
    case typeOne, typeTwo
}

class HomeViewController: BaseViewController {

    fileprivate var tranformFadeViewOne : TranformFadeView!
    fileprivate var tranformFadeViewTwo : TranformFadeView!
    fileprivate var gcdTimer            : GCDTimer!
    fileprivate var type                : EType = .typeOne
    
    private var tableView : UITableView!
    
    let imgArr = ["stock-photo-1","stock-photo-2","stock-photo-3","stock-photo-4","stock-photo-5"]
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.scrollViewHeight)
        return scrollView
    }()
    
    private var imgIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
    
        setupBanner()
        
        setupTableView()
        
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: 200 + 1210)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupBanner(){
        
          let FadeViewRect = CGRect(x: 0, y: 0, width:Common.screenWidth, height: 200)
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        tranformFadeViewOne                      = TranformFadeView(frame: FadeViewRect, verticalCount: 1, horizontalCount: 12,fadeDuradtion: 1, animationGapDuration: 0.075)
        tranformFadeViewOne.imageContentMode     = .scaleAspectFill
        tranformFadeViewOne.image                = currentImage()
        tranformFadeViewOne.start(animated: false, transformTo: .show)
        tranformFadeViewOne.addGestureRecognizer(tapOne)
        scrollView.addSubview(tranformFadeViewOne)
        
        
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        tranformFadeViewTwo                      = TranformFadeView(frame: FadeViewRect,verticalCount: 6, horizontalCount: 1,fadeDuradtion: 1, animationGapDuration: 0.075)
        tranformFadeViewTwo.imageContentMode     = .scaleToFill
        tranformFadeViewTwo.image                = currentImage()
        tranformFadeViewTwo.start(animated: false, transformTo: .fade)
        tranformFadeViewTwo.addGestureRecognizer(tapTwo)
        scrollView.addSubview(tranformFadeViewTwo)
        
        
        setTimer(delay: 0)
        
    }
    
    fileprivate func setTimer(delay:Float){
        
        gcdTimer          = GCDTimer(in: GCDQueue.Main, delay:delay, interval: 6.0)
        weak var weakSelf = self
        gcdTimer.setTimerEventHandler { _ in
            weakSelf?.change()
        }
        
        gcdTimer.start()
        
        
    }
    fileprivate func change(){
        
        weak var weakSelf = self
        
        if weakSelf?.type == .typeOne {
            
            print("执行了一次次")
            weakSelf?.type = .typeTwo
            weakSelf?.scrollView.sendSubview(toBack: (weakSelf?.tranformFadeViewTwo)!)
            weakSelf?.tranformFadeViewTwo.image = weakSelf?.currentImage()
            weakSelf?.tranformFadeViewTwo.start(animated: false, transformTo: .show)
            weakSelf?.tranformFadeViewOne.start(animated: true,  transformTo: .fade)
            
        } else {
            
            weakSelf?.type = .typeOne
            weakSelf?.scrollView.sendSubview(toBack: (weakSelf?.tranformFadeViewOne)!)
            weakSelf?.tranformFadeViewOne.image = weakSelf?.currentImage()
            weakSelf?.tranformFadeViewOne.start(animated: false, transformTo: .show)
            weakSelf?.tranformFadeViewTwo.start(animated: true,  transformTo: .fade)
        }
        
        
    }
    
    @objc fileprivate func tapImage(){
        
        change()
        
        gcdTimer.destroy()
        setTimer(delay: 6)
        
    }
    
    private func currentImage() -> UIImage{
        
        imgIndex  = (imgIndex + 1) % imgArr.count
        
        return UIImage.init(named:imgArr[imgIndex])!
        
        
    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 200, width: Common.screenWidth, height: 5 * 230 + 60 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 230
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: 60))
        
        tableView.tableHeaderView =  headView
        
        tableView.register(UINib.init(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        scrollView.addSubview(tableView)
        
    }
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonCell
        cell.bgImgView.image = UIImage.init(named: imgArr[indexPath.row])
        return cell
    }
    
    
    
}
