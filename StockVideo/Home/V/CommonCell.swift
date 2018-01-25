//
//  CommonCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/22.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CommonCell: UITableViewCell {

    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBOutlet weak var blackView: UIView!
    
    @IBOutlet weak var columnLabel: UILabel!
    
    @IBOutlet weak var videoLengthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blackView.alpha = Common.backViewAlaph

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
