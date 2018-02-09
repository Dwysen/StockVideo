//
//  VideoPlayVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/24.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import SnapKit
import JPVideoPlayer

class VideoPlayVC: BBViewController {
    
    var playUrl : String!
    
    var testStr = ["第一层，一般情况下是杀死就好了，不会“给猴看”；第二层就很严重了，一般情况下会是规模性封杀（参考17年6月份的娱乐账号），但是也不会告诉你为什么，让大家去猜、去找红线，这样才能起到足够的震慑力。"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？", " 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"]
    
    var image : UIImage!
    
    var videoPlayView : UIView!
    
    var addWatchView : UIView!
    var columnLabel  : UILabel!
    var addWatchBtn : UIButton!
    
    var commentTableView : UITableView!
    
    var inTF : inTF!
    var finalOffsetY:CGFloat!
    // 键盘遮罩层
    var blackView : UIView!
    // 回复的谁
    var currentName : String!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 200 + 40, width: Common.screenWidth, height: Common.screenHeight - 200 - 40)
        return scrollView
    }()
    
        override var shouldAutorotate : Bool {
           return true
        }

        override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return .landscape
            }else {
                return .portrait
            }
        }

        override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
            if UIDevice.current.userInterfaceIdiom == .pad {
                return .landscapeRight
            }else {
                return .portrait
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.jp_useCustomPopAnimationForCurrentViewController = true
        
        setupTopView()
        
        setupTableView()
        
        setupPlayView()
        
        setupTouchEvents()
        
        setupKeyboardNotifi()
        
    }
    
    private func setupKeyboardNotifi (){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHiden(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        videoPlayView.jp_stopPlay()
    }
    
    private func setupPlayView(){
        
        guard playUrl != nil else {
            print("playUrl is nil")
            return
        }
        
        MediaManager.sharedInstance.playEmbeddedVideo(url: URL.init(string: playUrl)!, embeddedContentView: self.videoPlayView)
        
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
    

    func setupTouchEvents() {
        let tapGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(self.didTapVideoView(gestureRecognizer:)))
        tapGestureRecognize.numberOfTapsRequired = 2
        videoPlayView.isUserInteractionEnabled = true
        videoPlayView.addGestureRecognizer(tapGestureRecognize)
    }
    
    @objc func didTapVideoView(gestureRecognizer : UITapGestureRecognizer) {
        
        print("1111")
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            if videoPlayView.viewStatus == JPVideoPlayerVideoViewStatus.portrait {
                videoPlayView.jp_gotoLandscape(animated: true, completion: nil)
            }
            else if (videoPlayView.viewStatus == JPVideoPlayerVideoViewStatus.landscape){
                videoPlayView.jp_gotoPortrait(animated: true, completion: nil)
            }
        }
    }
    
    private func setupTableView(){
        
        commentTableView = UITableView(frame: CGRect(x: 0, y: 240, width: Common.screenWidth, height: Common.screenHeight - 240 ))
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.showsVerticalScrollIndicator = false
        commentTableView.register(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        commentTableView.separatorStyle = .none
        commentTableView.estimatedRowHeight = 200
        
        let tableTopView = Bundle.main.loadNibNamed("VideoPlayTopView", owner: nil, options: nil)?.first as! VideoPlayTopView
        commentTableView.tableHeaderView = tableTopView
        
        view.addSubview(commentTableView)
        view.bringSubview(toFront: addWatchView)
    }
    
    
    deinit {
        print("VideoPlayVC release")
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

extension VideoPlayVC : tapAvatarDelegate,ActionSheetViewDelegate {
    
    func actionSheetAndClickButtonAtIndex(actionSheet: ActionSheetView, buttonIndex: NSInteger) {
        print(buttonIndex)
        
        if inTF == nil {
            inTF = Bundle.main.loadNibNamed("inTF", owner: nil, options: nil)?.first as! inTF
            inTF.delegate = self
            inTF.frame = CGRect.init(x: 0, y: Common.screenHeight, width: Common.screenWidth, height: 50)
            inTF.textF.placeholder = "回复" + currentName
            let window = UIApplication.shared.keyWindow
            window?.addSubview(inTF)
        }
        
        inTF.textF.becomeFirstResponder()
        
    }
    
    func tapImg() {
        let vc = SomeoneViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapCell(name: String){
        
        currentName = name
        
        let array = ["举报","回复"]
        let ActionSheet = ActionSheetView()
        ActionSheet.initWithTitleArrayAndShowCancel(titleArr: array, show: false)
        ActionSheet.frame = UIScreen.main.bounds
        ActionSheet.delegate = self
        view.addSubview(ActionSheet)
        
    }
}

extension VideoPlayVC : sendBtnClickDelegate {
    
    // 回复评论
    func btnClick(text: String) {
        let string = "我 回复 " + currentName + ":" + text
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:string)
        let range = attrstring.string.range(of: "回复")
        let nsrange = attrstring.string.nsRange(from: range!)
        attrstring.addAttribute(.foregroundColor, value: UIColor.red, range: nsrange!)
        testStr.append("我 回复 " + currentName + ":" + text)
        commentTableView.reloadData()
        showRightWithTitle(title: "发送成功", autoCloseTime: 0.5)
        inTF.textF.resignFirstResponder()
    }
    
}
extension VideoPlayVC  {
        @objc func keyboardWillHiden(_ notification: Notification) {
        
        let info = notification.userInfo
        let kbRect = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let offsetY = kbRect.origin.y - UIScreen.main.bounds.height
        let duration = info![UIKeyboardAnimationDurationUserInfoKey] as? Double
        
        print(offsetY)
        
        UIView.animate(withDuration: duration!) {
            self.inTF.transform = CGAffineTransform(translationX: 0, y: 0 - self.finalOffsetY)
            self.blackView.alpha = 0
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let info = notification.userInfo
        let kbRect = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = info![UIKeyboardAnimationDurationUserInfoKey] as? Double
        
        let offsetY = kbRect.origin.y - UIScreen.main.bounds.height
        finalOffsetY = offsetY - 50
        
        if blackView == nil {
            blackView = UIView(frame: view.bounds)
            blackView.alpha = 0.3
            blackView.backgroundColor = UIColor.black
            blackView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapBlackView))
            blackView.addGestureRecognizer(tap)
        } else {
            blackView.alpha = 0.3
        }
        
        let window = UIApplication.shared.keyWindow
        window!.addSubview(blackView)
        window!.bringSubview(toFront: inTF)
        
        
        UIView.animate(withDuration: duration!) {
            self.inTF.transform = CGAffineTransform(translationX: 0, y: self.finalOffsetY)
        }
        
    }
    
    @objc private func tapBlackView(){
        inTF.textF.resignFirstResponder()
    }
}
