//
//  VideoPlayVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/24.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class VideoPlayVC: BBViewController {

    var image : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView.init(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = image
        view.addSubview(imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
}
