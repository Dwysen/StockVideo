//
//  UpAndDownCell.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/17.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class UpAndDownCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var ratioLabel: UILabel!
    
    var upAndDown:BBShare? {
        
        didSet {
            
            nameLabel.text = upAndDown?.name
            priceLabel.text = upAndDown?.newPrice
            
            let finalStr = String.init(format: "%.2f", Float(upAndDown!.priceChangeRatio)!)
            ratioLabel.text = finalStr + "%"
            
         
            
        }
        
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//     
//        
//        
//        
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.textColor = UIColor.red
        ratioLabel.textColor = UIColor.red
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
