//
//  EditSelfViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/1.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class EditSelfViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight)
        scrollView.bounces = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setAlpha()
            
                let editMeView = Bundle.main.loadNibNamed("EditMeView", owner: nil, options: nil)?.first as! EditMeView
    
        
        

        
                editMeView.width = Common.screenWidth
                editMeView.y -= 64
                scrollView.addSubview(editMeView)
                scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: editMeView.maxY)
                view.addSubview(scrollView)

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
