//
//  TestFadeView.swift
//  Banner
//
//  Created by 王彦森 on 2017/12/21.
//  Copyright © 2017年 Dwyson. All rights reserved.
//

import UIKit

class FadeView: UIView {
    
    fileprivate var verticalCount:Int = 0
    fileprivate var horizonCount:Int = 0
    
    fileprivate var maskViewCount:Int = 0
    fileprivate var maskViewTag:Int = 1000
    fileprivate var allMaskView:UIView!
    
    fileprivate var imageView:UIImageView!
    
    var image:UIImage? {
        get{return imageView.image}
        set(newval){imageView.image = newval}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
    }
    
    convenience init(frame:CGRect,verticalCount:Int,horizonCount:Int) {
        self.init(frame: frame)
        
        self.verticalCount = verticalCount
        self.horizonCount = horizonCount
        
        // 小格子宽高
        let maskViewWidth = Common.screenWidth / CGFloat(horizonCount)
        let maskViewHeight = Common.screenHeight / CGFloat(verticalCount)
        
        allMaskView = UIView(frame: bounds)
        mask = allMaskView
        
        var count:Int = 0
        
        for vertical in 0 ..< verticalCount {
            
            for horizontal in 0 ..< horizonCount {
                
                // 创造很多小格子的maskView
                let maskView = UIView(frame: CGRect(x: CGFloat(horizontal) * maskViewWidth, y: CGFloat(vertical) * maskViewHeight, width: maskViewWidth, height: maskViewHeight))
                maskView.tag = count + maskViewTag
                // 如果不给maskView设置背景色，会导致图片不可见
                maskView.backgroundColor = UIColor.black  
                
                allMaskView.addSubview(maskView)
                
                count += 1
                
            }
        }
        
        // 记录一共有多少个小格子
        maskViewCount = count
    }
    
    func start(fade:Bool,animte:Bool){
        
        if fade{
            
            for i in 0 ..< self.maskViewCount {
                
                let delayTime = Double(i) * 0.05
                let tmpView = self.allMaskView.viewWithTag(i + maskViewTag)
                if animte {
                    UIView.animate(withDuration: 2, delay: delayTime, options: .curveLinear, animations: {
                        tmpView?.alpha = 0
                    })
                } else {
                    tmpView?.alpha = 0
                }
            }
            
        }else{
            
            for i in 0 ..< self.maskViewCount {
                
                let delayTime = Double(i) * 0.05
                let tmpView = self.allMaskView.viewWithTag(i + maskViewTag)
                
                if animte {
                    UIView.animate(withDuration: 2, delay: delayTime, options: .curveLinear, animations: {
                        
                        tmpView?.alpha = 1
                        
                    })
                    
                } else {
                    tmpView?.alpha = 1
                }
            }
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
