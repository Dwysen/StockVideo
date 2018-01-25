//
//  HotView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/23.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class HotView: UIView {
    
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var columnLabel: UILabel!
    @IBOutlet weak var videoLengthLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static func newInstance() -> HotView?{
        let nibView = Bundle.main.loadNibNamed("HotView", owner: nil, options: nil)
        if let view = nibView?.first as? HotView{
            view.blackView.alpha = Common.backViewAlaph
            return view
        }
        return nil
    }

   

}
