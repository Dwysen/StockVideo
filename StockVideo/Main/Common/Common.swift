//
//  Common.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/17.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        
        let utf16view = self.utf16
        
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
            
        }
        
        return nil
        
    }
    
}

@objc protocol tapAvatarDelegate {
    func tapImg()
    func tapCell(name:String)
    
}

@objc protocol sendBtnClickDelegate {
    func btnClick(text:String)
}

struct Common {
    
     static let testStr = ["第一层，一般情况下是杀死就好了，不会“给猴看”；第二层就很严重了，一般情况下会是规模性封杀（参考17年6月份的娱乐账号），但是也不会告诉你为什么，让大家去猜、去找红线，这样才能起到足够的震慑力。"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？", " 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"," 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？ 所以头脑王者是触碰了哪个红线或者在引导什么样的趋势呢？"]
    
    static let commonYellow = UIColor.init(red: 255/255, green: 214/255, blue: 0, alpha: 1)
    static let bgGray = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    static let subTitleGray = UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    static let textFieldBGColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let scrollViewHeight = Common.screenHeight - 64 - 49
    
    static let headViewHeight:CGFloat = 60
    
    static let singleBlockHeight:CGFloat = 230
    
    static let bannerHeight : CGFloat = 200
    
    static let backViewAlaph : CGFloat = 0.22
    
    static let likeViewY : CGFloat = Common.bannerHeight + Common.newSectionHeight + Common.hotSectionHeight
    
    static let newSectionHeight : CGFloat = Common.headViewHeight + 5 * Common.singleBlockHeight
    
    static let hotSectionHeight : CGFloat = Common.headViewHeight + 2 * Common.singleBlockHeight
    
    static func clipCorner(view:UIView,cornerRadius:CGFloat) {
        
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true  
     
    }
    
    static func getBlackView(frame:CGRect) -> UIView {
        
        let blackView = UIView.init(frame: frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = Common.backViewAlaph
        return blackView

    }
    
    static func isPhone(phone:String) -> Bool {
        let phonee = phone.trimmingCharacters(in: .whitespaces)
        let scan: Scanner = Scanner(string: phonee)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd  && phonee.count == 11
    }
    
    static func getBBlackView(frame:CGRect) -> UIView {
        
        let blackView = UIView.init(frame: frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0.8
        return blackView
        
    }
    
    static func autoLabelHeight(with text:String , labelWidth: CGFloat ,attributes : [NSAttributedStringKey : Any]) -> CGFloat{
        var size = CGRect()
        let size2 = CGSize(width: labelWidth, height: 0)//设置label的最大宽度
        size = text.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil);
        return size.size.height
    }
    
    static func getAttributeStringWithString(_ string: String,lineSpace:CGFloat
        ) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(string as CFString!))
        
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStye, range: rang)
        return attributedString
        
    }
}
