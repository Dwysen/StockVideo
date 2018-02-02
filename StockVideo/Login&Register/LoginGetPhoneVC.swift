//
//  LoginGetPhoneVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/2.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class LoginGetPhoneVC: UIViewController {

    @IBOutlet weak var nextStepBtn: UIButton!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    var isForget = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTextField.backgroundColor = Common.textFieldBGColor
        Common.clipCorner(view: phoneTextField, cornerRadius: 5)
        
        nextStepBtn.backgroundColor = Common.commonYellow
        Common.clipCorner(view: nextStepBtn, cornerRadius: 5)
        nextStepBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func btnClick(){
        
//        手机号验证

//        guard Common.isPhone(phone: phoneTextField.text!) else {
//            showErrorWithTitle(title: "手机格式错误", autoCloseTime: 1)
//            return
//        }
        
        if isForget {
            let vc = ResetPasswordVC()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = RegisterViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
