//
//  MessageCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/6.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImgView.layer.cornerRadius = 25
        avatarImgView.layer.masksToBounds = true
        
        countLabel.backgroundColor = Common.commonYellow
        countLabel.layer.cornerRadius = 12.5
        countLabel.layer.masksToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
