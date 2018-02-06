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
    
    var delegate:tapAvatarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        addGestureRecognizer(tap)

    }

    private func setupUI(){
        
        selectionStyle = .none
        
        avatarImgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        
        avatarImgView.addGestureRecognizer(tap)
        avatarImgView.layer.cornerRadius = 16.5
        avatarImgView.layer.masksToBounds = true
    }
    
    @objc private func tapCell(){
    
        delegate?.tapCell()
     
    }
    
    @objc private func tapAvatar(){
        
        delegate?.tapImg()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
