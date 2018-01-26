//
//  Common.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/17.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
struct Common {
    
    static let commonYellow = UIColor.init(red: 255/255, green: 214/255, blue: 0, alpha: 1)
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let scrollViewHeight = Common.screenHeight - 64 - 49
    
    static let headViewHeight:CGFloat = 60
    
    static let singleBlockHeight:CGFloat = 230
    
    static let bannerHeight : CGFloat = 200
    
    static let backViewAlaph : CGFloat = 0.3
    
    static let likeViewY : CGFloat = Common.bannerHeight + Common.newSectionHeight + Common.hotSectionHeight
    
    static let newSectionHeight : CGFloat = Common.headViewHeight + 5 * Common.singleBlockHeight
    
    static let hotSectionHeight : CGFloat = Common.headViewHeight + 2 * Common.singleBlockHeight
    
    static func getBlackView(frame:CGRect) -> UIView {
        
        let blackView = UIView.init(frame: frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = Common.backViewAlaph
        return blackView

    }
    
    static func getBBlackView(frame:CGRect) -> UIView {
        
        let blackView = UIView.init(frame: frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0.8
        return blackView
        
    }

 
}
