//
//  inTF.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/7.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class inTF: UIView {
    
    @IBOutlet weak var textF: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    weak var delegate:sendBtnClickDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sendBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
    @objc private func btnClick(){
        delegate.btnClick(text: textF.text!)
    }
}
