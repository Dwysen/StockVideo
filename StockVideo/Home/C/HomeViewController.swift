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
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.scrollViewHeight)
        scrollView.contentSize = CGSize(width: Common.screenWidth * 2, height: Common.scrollViewHeight)
        return scrollView
    }()
    
    /* ------------------------------------------------ */
    
    /* tranformFadeView */
    
    fileprivate var tranformFadeViewOne : TranformFadeView!
    fileprivate var tranformFadeViewTwo : TranformFadeView!
    fileprivate var gcdTimer            : GCDTimer!
    fileprivate var type                : EType = .typeOne
    
    /* tranformFadeView */
    
    /* ------------------------------------------------ */
    
    private var tableView : UITableView!
    
    let imgArr = ["stock-photo-1","stock-photo-2","stock-photo-3","stock-photo-4","stock-photo-5"]
    
    private var imgIndex : Int = 0
    
    private var currentImg : UIImage!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.scrollViewHeight)
        return scrollView
    }()
    

    
    /* ------------------------------------------------ */
    
    /* likeParallaxView */
    
    fileprivate let viewTag            : Int       = 1000
    fileprivate var likeScrollView         : UIScrollView!
    fileprivate var onceLinearEquation : Math!
    fileprivate var pageControl : UIPageControl!
    
    /* likeParallaxView */
    
    /* ------------------------------------------------ */
    
    
    
    /* ------------------------------------------------ */
    
    /* titleView */
    
    private var indicatorView : UIView!
    private var findBtn       : UIButton!
    private var columnBtn     : UIButton!
    
    /* titleView */
    
    /* ------------------------------------------------ */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
        
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(scrollView)
        
        setupBanner()
        
        setupTableView()
        
        setupHotSection()
        
        setupLikeSection()
        
        setupColumnController()
        
        //        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: Common.bannerHeight + Common.newSectionHeight)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - setupUI
    
    
    private func setupTitleView(){
        
        let titleView = UIView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        navigationItem.titleView = titleView
        
        findBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        findBtn.setTitle("发现", for: .normal)
        findBtn.setTitleColor(UIColor.black, for: .normal)
        findBtn.tag = 1
        findBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        titleView.addSubview(findBtn)
        
        
        indicatorView = UIView()
        indicatorView.backgroundColor = Common.commonYellow
        indicatorView.height = 2.0
        indicatorView.width = 20
        indicatorView.y = 38
        indicatorView.centerX = findBtn.centerX
        titleView.addSubview(indicatorView)
        
        columnBtn = UIButton.init(frame: CGRect(x: 100, y: 0, width: 50, height: 35))
        columnBtn.setTitle("栏目", for: .normal)
        columnBtn.setTitleColor(UIColor.black, for: .normal)
        columnBtn.tag = 2
        columnBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        titleView.addSubview(columnBtn)
        
    }
    
    // 轮播
    private func setupBanner(){
        
        let FadeViewRect = CGRect(x: 0, y: 0, width:Common.screenWidth, height: 200)
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapImage))
    
        tranformFadeViewOne                      = TranformFadeView(frame: FadeViewRect, verticalCount: 1, horizontalCount: 12,fadeDuradtion: 1, animationGapDuration: 0.075)
        
        scrollView.addSubview(tranformFadeViewOne)
        
        tranformFadeViewOne.addGestureRecognizer(tapOne)
        tranformFadeViewOne.imageContentMode     = .scaleAspectFill
        tranformFadeViewOne.image                = currentImage()
        tranformFadeViewOne.titleLabel.text      = "标题1"
        tranformFadeViewOne.start(animated: false, transformTo: .show)
     
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(tapImage))

        //        tapOne.direction = .right
        tranformFadeViewTwo                      = TranformFadeView(frame: FadeViewRect,verticalCount: 6, horizontalCount: 1,fadeDuradtion: 1, animationGapDuration: 0.075)
        
        scrollView.addSubview(tranformFadeViewTwo)
        
        tranformFadeViewTwo.addGestureRecognizer(tapTwo)
        tranformFadeViewTwo.imageContentMode     = .scaleToFill
        tranformFadeViewTwo.image                = currentImage()
        tranformFadeViewTwo.titleLabel.text      = "标题2"
        tranformFadeViewTwo.start(animated: false, transformTo: .fade)

    
        
        
        setTimer(delay: 0)
        
    }
    
    // 最新
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 200, width: Common.screenWidth, height: 5 * 230 + 60 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 230
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    
        
        let headView = HeadView.init(frame: CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: 60))
        tableView.tableHeaderView =  headView
        
        tableView.register(UINib.init(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        scrollView.addSubview(tableView)
        
    }
    
    // 热门
    private func setupHotSection(){
    
        let backView = UIView.init(frame: CGRect(x: 0, y: Common.newSectionHeight + Common.bannerHeight , width: Common.screenWidth, height: Common.headViewHeight + Common.singleBlockHeight * 2))
        scrollView.addSubview(backView)
        
        let headView = HeadView.init(frame: CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: Common.headViewHeight))
        backView.addSubview(headView)
        
        let hotView = HotView.newInstance()
        hotView?.frame = CGRect.init(x: 0, y: Common.headViewHeight, width: Common.screenWidth, height: Common.singleBlockHeight )
        hotView?.tag = 0
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapHot))
        hotView?.addGestureRecognizer(tap)
        hotView?.bgImgView.image = UIImage.init(named: imgArr[0])
        backView.addSubview(hotView!)
        
        for i in 0 ..< 4 {
            
            let hotView = HotView.newInstance()
            hotView?.tag = i + 1
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapHot))
            hotView?.addGestureRecognizer(tap)
            
            // 四小块儿距离backView顶部的高度
            let topHeight = Common.headViewHeight + Common.singleBlockHeight
            
            let finalY:CGFloat = i>1 ? Common.singleBlockHeight / 2  + topHeight : topHeight
            hotView?.frame = CGRect.init(x: CGFloat ( i % 2 ) * Common.screenWidth / 2 , y: finalY, width: Common.screenWidth / 2, height: Common.singleBlockHeight / 2)
            
            hotView?.bgImgView.image = UIImage.init(named: imgArr[i + 1] )
            
            backView.addSubview(hotView!)
            
        }
    }
    
    // 喜欢
    
    private func setupLikeSection(){
        
        onceLinearEquation = Math((x : 0,                  imageViewX : -50),
                                  (x : view!.width, imageViewX : 270 - 80))
        
        let headView = HeadView.init(frame: CGRect.init(x: 0, y: Common.likeViewY, width: Common.screenWidth, height: Common.headViewHeight))
        scrollView.addSubview(headView)
        
        likeScrollView                                = UIScrollView(frame: CGRect.init(x: 0, y: Common.likeViewY + Common.headViewHeight, width: Common.screenWidth, height: Common.singleBlockHeight))
        likeScrollView.delegate                       = self
        likeScrollView.isPagingEnabled                = true
        likeScrollView.backgroundColor                = UIColor.black
        likeScrollView.showsHorizontalScrollIndicator = false
        likeScrollView.bounces                        = false
        likeScrollView.contentSize                    = CGSize(width:  CGFloat(imgArr.count) * Common.screenWidth, height:Common.singleBlockHeight )
        scrollView.addSubview(likeScrollView)
        
        
        
        for (i, str) in imgArr.enumerated() {
            
            let showView              = ParallaxImageView(frame: CGRect(x:CGFloat(i) * Common.screenWidth, y: 0, width: Common.screenWidth, height: Common.singleBlockHeight))
            showView.imageView.image = UIImage.init(named: str)
            showView.tag             = viewTag + i
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLike))
            showView.addGestureRecognizer(tap)
            likeScrollView.addSubview(showView)
        }
        
        // MARK set pageControl
        
        pageControl = UIPageControl.init(frame: CGRect(x:0,y: 0,width:50,height:10))
        pageControl.center = CGPoint(x: Common.screenWidth / 2, y:Common.likeViewY + Common.headViewHeight + Common.singleBlockHeight - 10);
        //        pageControl.
        pageControl.setValue(UIImage.init(named: "pageB"), forKeyPath: "_currentPageImage")
        pageControl.setValue(UIImage.init(named: "pageH"), forKeyPath: "_pageImage")
        pageControl.numberOfPages = imgArr.count
        pageControl.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        scrollView.addSubview(pageControl);
        
        //        Banner版本一
        
        //        let likeView = LikeView.init(frame: CGRect.init(x: 0, y: Common.likeViewY + Common.headViewHeight, width: Common.screenWidth, height: Common.singleBlockHeight), imgArr: imgArr)
        //
        //        scrollView.addSubview(likeView)
        
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: Common.likeViewY + Common.headViewHeight + Common.singleBlockHeight)
        
    }
    
    private func setupColumnController(){
        
        let vc = ColumnViewController()
        addChildViewController(vc)
        
        let columnView = vc.view
        columnView?.x = Common.screenWidth
        columnView?.y = 0
        contentScrollView.addSubview(columnView!)
        
    }
    
    
    @objc private func titleBtnClick(sender:UIButton){
        
        if sender.tag == 1 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.indicatorView.centerX = 25
                self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                
            })
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorView.centerX = 125
                self.contentScrollView.setContentOffset(CGPoint.init(x: Common.screenWidth, y: 0), animated: true)
            })
        }
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
        
        print("change")
        
        weak var weakSelf = self
        
        if weakSelf?.type == .typeOne {
            
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
    
    @objc fileprivate func tapImage(sender:UITapGestureRecognizer){
        
        let vc = VideoPlayVC()
        vc.image = currentImg
        navigationController?.pushViewController(vc, animated: true)
        
        // gcdTimer.destroy()
        // setTimer(delay: 6)
        
    }
    
    @objc fileprivate func tapHot(sender:UITapGestureRecognizer){
        
        let vc = VideoPlayVC()
        vc.title = "\(sender.view?.tag)"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc fileprivate func tapLike(sender:UITapGestureRecognizer){
        
        let vc = VideoPlayVC()
        vc.title = "\(sender.view?.tag)"
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    private func currentImage() -> UIImage{
        
        imgIndex  = (imgIndex + 1) % imgArr.count
        
        currentImg = UIImage.init(named: imgArr[imgIndex])
        
        return currentImg
        
    }
    
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    // MARK: - scrollView
    
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //
    //        guard scrollView == contentScrollView else {
    //            return
    //        }
    //
    //
    //        if scrollView.contentOffset.x == Common.screenWidth {
    //
    //            let vc = self.childViewControllers.first as! ColumnViewController
    //            let view = vc.view
    //
    //            view!.x = Common.screenWidth
    //            view!.y = 0
    //            contentScrollView.addSubview(view!)
    //
    //        }
    //    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == likeScrollView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = page
        }
        
        if scrollView == contentScrollView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            switch page {
            case 0 :
                titleBtnClick(sender: findBtn)
            default:
                titleBtnClick(sender: columnBtn)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == likeScrollView else {
            return
        }
        let X = scrollView.contentOffset.x
        for i in 0 ..< imgArr.count {
            let showView = scrollView.viewWithTag(viewTag + i) as! ParallaxImageView
            showView.imageView.x = onceLinearEquation.k * (X - CGFloat(i) * Common.screenWidth) + onceLinearEquation.b
        }
    }
    
    // MARK: - tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonCell
        cell.selectionStyle = .none
        cell.bgImgView.image = UIImage.init(named: imgArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JPVideoPlayerDemoVC_home()
        navigationController?.pushViewController(vc, animated: true)
    }
}
