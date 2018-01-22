//
//  BBTabBarController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class BBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addChildViewControllers()

        // Do any additional setup after loading the view.
    }
    
    private func addChildViewControllers() {
        
        addChildViewController(childController: HomeViewController(), title: "相关", imageName: "home")
        
        addChildViewController(childController: HomeViewController(), title: "视频", imageName: "home")
        addChildViewController(childController: MarketViewController(), title: "行情", imageName: "openClass")
        
        addChildViewController(childController: CircleTableViewController(), title: "圈子", imageName: "highClass")
//        addChildViewController(childController: InformationViewController(), title: "资讯", imageName: "information")
    }

    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
//        childController.tabBarItem.image = UIImage(named: imageName)
//        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        childController.title = title
        let navC = BBNavigationController(rootViewController: childController)
        
        addChildViewController(navC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
