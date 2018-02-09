//
//  DetailTopView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/31.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class DetailTopView: UIView {

    @IBOutlet weak var addWatchBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        addWatchBtn.layer.cornerRadius = 5
        addWatchBtn.layer.masksToBounds = true
        addWatchBtn.layer.borderColor = UIColor.orange.cgColor
        addWatchBtn.layer.borderWidth = 1
    }
}
