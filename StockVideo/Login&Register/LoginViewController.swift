//
//  LoginViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/1.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.cleanLine()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        title = "登录"
        
        phoneTextField.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        passwordTextField.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        loginBtn.backgroundColor = Common.commonYellow
        
        phoneTextField.addLeftView()
        passwordTextField.addLeftView()
        
        Common.clipCorner(view: phoneTextField, cornerRadius: 5)
        Common.clipCorner(view: passwordTextField, cornerRadius: 5)
        Common.clipCorner(view: loginBtn, cornerRadius: 5)
        
        forgetPasswordBtn.addTarget(self, action: #selector(forgetPasswordBtnClick), for: .touchUpInside)
        
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc private func forgetPasswordBtnClick(){
        
        let vc = LoginGetPhoneVC()
        vc.isForget = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func registerBtnClick(){
        
        let vc = LoginGetPhoneVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
