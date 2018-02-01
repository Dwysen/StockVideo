//
//  VideoPlayTopView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/30.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class VideoPlayTopView: UIView {
    
    @IBOutlet weak var tagView: UIView!
    
    var testTagArr  = ["运动","科学"]
    
    @IBOutlet weak var introduceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        introduceLabel.attributedText = Common.getAttributeStringWithString("视频简介视频简介视频简介视频简介视频简介视频简介视频简介视频简介视频简介视频简介", lineSpace: 8)
        
        for i in 0 ..< testTagArr.count{
            
            let label = UILabel(frame: CGRect(x: 10 + i * ( 50 + 10 ), y: 5, width: 50, height: 20))
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = testTagArr[i]
            label.textColor = UIColor.orange
            label.textAlignment = .center
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.orange.cgColor
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            tagView.addSubview(label)
            
        }
    }
}
