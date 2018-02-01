//
//  HXNavigationController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import JPNavigationController

class BBNavigationController: JPNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationBar.setBackgroundImage(UIImage.init(named: "e51c24"), for: .default)
        
//        setTitleView() 
        
        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
//        navBar.barTintColor = Common.commonYellow 
//        navBar.tintColor = UIColor.white
        
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    
//    private func setTitleView(){
//
//        let titleView = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//
//        titleView.backgroundColor = UIColor.black
//
//        navigationItem.titleView?.addSubview(titleView)
//                navigationItem.titleView = titleView
//
//    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
            //            viewController.tabBarController?.tabBar.isHidden = true
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(navigationBackClick))
//            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
        
    }
    /// 返回按钮
    @objc func navigationBackClick() {
        
        print("1")
        
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    
    
}
