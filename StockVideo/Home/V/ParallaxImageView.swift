//
//  ParallaxImageView.swift
//  Banner
//
//  Created by 王彦森 on 2017/12/12.
//  Copyright © 2017年 Dwyson. All rights reserved.
//


import UIKit

class ParallaxImageView: UIView {
    
    var imageView: UIImageView!

    private var titleLabel : UILabel!

    private var columnLabel : UILabel!
    
    private var videoLengthLabel : UILabel!
    
//    private var blackView:UIView!
    
    override init(frame: CGRect) {
        
        super.init(frame : frame)
        
        layer.masksToBounds = true
    
        /*
         *     --------------     *
         *-50->|-view-width-|<-50-*
         *     --------------     *
                                  */
        
        let rect              = frame
        imageView             = UIImageView(frame: CGRect(x: -50, y: -50, width: rect.size.width + 50 * 2, height: rect.size.height + 50 * 2))
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        
        let blackView = UIView.init(frame: bounds)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = Common.backViewAlaph
        addSubview(blackView)
        
        titleLabel = UILabel.init(frame: CGRect(x: 20, y: height - 40, width: width - 40, height: 20))
        titleLabel.text = "测试测试测试测试测试测试测试测试测试测试"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)
        
        columnLabel = UILabel.init(frame: CGRect(x: 20, y: height - 75, width: 60, height: 20))
        columnLabel.text = "测试测试 /"
        columnLabel.font = UIFont.systemFont(ofSize: 12)
        columnLabel.textColor = UIColor.white
        addSubview(columnLabel)
        
        videoLengthLabel = UILabel.init(frame: CGRect(x: 80, y: height - 75, width: 40, height: 20))
        videoLengthLabel.text = "3:42"
        videoLengthLabel.font = UIFont.systemFont(ofSize: 12)
        videoLengthLabel.textColor = UIColor.white
        addSubview(videoLengthLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
