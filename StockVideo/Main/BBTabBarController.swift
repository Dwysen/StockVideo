//
//  BBTabBarController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import JPNavigationController

class BBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addChildViewControllers()
        
        // Do any additional setup after loading the view.
    }
    
    private func addChildViewControllers() {
        
        addChildViewController(childController: HomeViewController(), title: "视频", imageName: "home")
        
        addChildViewController(childController: MeViewController(), title: "我的", imageName: "home")
        
        addChildViewController(childController: MarketViewController(), title: "行情", imageName: "openClass")

        addChildViewController(childController: CircleTableViewController(), title: "圈子", imageName: "highClass")
        
        
    }
    
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        //        childController.tabBarItem.image = UIImage(named: imageName)
        //        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        
        let navC = BBNavigationController(rootViewController: childController)
        
                navC.title = title
//        childController.title = title
        
        addChildViewController(navC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}
