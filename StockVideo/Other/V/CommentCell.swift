//
//  CommentCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/31.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    private func setupUI(){
        
        avatarImgView.layer.cornerRadius = 16.5
        avatarImgView.layer.masksToBounds = true

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
