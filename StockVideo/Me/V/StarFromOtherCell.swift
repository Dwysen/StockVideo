//
//  StarFromOtherCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/6.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class StarFromOtherCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
