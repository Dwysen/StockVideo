//
//  CommentFromOtherCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/7.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CommentFromOtherCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var commentFromOtherLabel: UILabel!
    @IBOutlet weak var myCommentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myCommentLabel.text = "我的评论:Configure the view for the selected state"
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
