//
//  HXNavigationController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class BBNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage.init(named: "e51c24"), for: .default)
        
        let navBar = UINavigationBar.appearance()
        //        navBar.barTintColor = Common.e51c24
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]

        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    @objc func navigationBackClick() {
        
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    

}
