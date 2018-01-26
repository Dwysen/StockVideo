//
//  SomeoneViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/26.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setAlpha(){
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}

class SomeoneViewController: UIViewController {
    
     var scrollView: UIScrollView!
    
    
    @IBOutlet weak var headBackImgView: UIImageView!
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var btnBackView: UIView!
    
    @IBOutlet weak var dynamicStateBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!

    @IBOutlet weak var indicatorView: UIView!

//    private lazy var myLayer:CAShapeLayer = {
//
//        let path = UIBezierPath.init(roundedRect: self.btnBackView.bounds, byRoundingCorners: [.topRight , .topLeft] , cornerRadii: self.btnBackView.bounds.size);
//        let layer = CAShapeLayer.init();
//        layer.path = path.cgPath;
////        layer.masksToBounds = true
//
////        layer.lineWidth = 5;
////        layer.lineCap = kCALineCapSquare;
////        layer.strokeColor = UIColor.red.cgColor;
////        //  注意直接填充layer的颜色，不需要设置控件view的backgroundColor
//        layer.fillColor = UIColor.clear.cgColor;
//        return layer;
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
   
        // Do any additional setup after loading the view.
    }

    private func setupUI(){

    headBackImgView.addSubview(Common.getBlackView(frame: headBackImgView.bounds))
        navigationController?.setAlpha()
        
        avatarImgView.layer.cornerRadius = 30
        avatarImgView.layer.masksToBounds = true
        avatarImgView.layer.borderColor = UIColor.white.cgColor
        avatarImgView.layer.borderWidth = 2
        // 设置特定圆角
        
        btnBackView.layer.cornerRadius = 15
        btnBackView.layer.masksToBounds = true
//        btnBackView.layer.addSublayer(myLayer)
//        btnBackView.backgroundColor = UIColor.clear
        
        //        findBtn.setTitleColor(UIColor.black, for: .normal)
        dynamicStateBtn.tag = 1
        dynamicStateBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        
        indicatorView.backgroundColor = Common.commonYellow

        likeBtn.tag = 2
        likeBtn.addTarget(self, action: #selector(titleBtnClick(sender:)), for: .touchUpInside)
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight))
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: 1000)
        view.insertSubview(scrollView, at: 0)
        headBackImgView.removeFromSuperview()
        scrollView.addSubview(headBackImgView)
        
//        @IBOutlet weak var headBackImgView: UIImageView!
//        @IBOutlet weak var avatarImgView: UIImageView!
//
//        @IBOutlet weak var btnBackView: UIView!
//
//        @IBOutlet weak var dynamicStateBtn: UIButton!
//        @IBOutlet weak var likeBtn: UIButton!
//
//        @IBOutlet weak var indicatorView: UIView!
        

        

        
        
        
        

    }
    
    @objc private func titleBtnClick(sender:UIButton){
        
        if sender.tag == 1 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.indicatorView.centerX = self.dynamicStateBtn.centerX
//                self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                
            })
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorView.centerX = self.likeBtn.centerX
//                self.contentScrollView.setContentOffset(CGPoint.init(x: Common.screenWidth, y: 0), animated: true)
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
