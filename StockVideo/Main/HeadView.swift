//
//  headView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/23.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class HeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        
    }
    
    convenience init(frame:CGRect,imgName:String) {
        self.init(frame: frame)
        
        let imgView = UIImageView()
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalToSuperview()

        }
        imgView.image = UIImage(named: imgName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
