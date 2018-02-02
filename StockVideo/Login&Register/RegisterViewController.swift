//
//  RegisterViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/2.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // 二维码TF
        Common.clipCorner(view: codeTextField, cornerRadius: 5)
        codeTextField.backgroundColor = Common.textFieldBGColor
        codeTextField.addLeftView()
        
    
        // 忘记密码TF
        Common.clipCorner(view: passwordTextField, cornerRadius: 5)
        passwordTextField.backgroundColor = Common.textFieldBGColor
        passwordTextField.addLeftView()
        
        // 昵称TF
        Common.clipCorner(view: nickNameTextField, cornerRadius: 5)
        nickNameTextField.backgroundColor = Common.textFieldBGColor
        nickNameTextField.addLeftView()
        
        // 验证码按钮
        sendCodeBtn.backgroundColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        
        Common.clipCorner(view: sendCodeBtn, cornerRadius: 5)
        
        // 注册按钮
        registerBtn.backgroundColor = Common.commonYellow
        Common.clipCorner(view: registerBtn, cornerRadius: 5)
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func registerBtnClick(){
        
        navigationController?.popToRootViewController(animated: true)

    }
}
