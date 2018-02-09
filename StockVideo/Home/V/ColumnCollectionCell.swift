//
//  ColumnCollectionCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/24.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class ColumnCollectionCell: UICollectionViewCell {
    
    private var backImgView : UIImageView!
    
    private var titleLabel  : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backImgView = UIImageView.init(frame: bounds)
        backImgView.contentMode = .scaleAspectFill
        backImgView.layer.masksToBounds = true
        backImgView.image = UIImage.init(named: "stock-photo-4")
        addSubview(backImgView)
        
        backImgView.addSubview(Common.getBlackView(frame: bounds))
        
        titleLabel = UILabel.init(frame: CGRect.init(x: Common.screenWidth / 4 - 40, y: 80, width: 80, height: 20))
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "社区"
        backImgView.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
