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
        
        phoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: phoneTextField.height))
        phoneTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.height))
        passwordTextField.leftViewMode = .always
        
        Common.clipCorner(view: phoneTextField, cornerRadius: 5)
        Common.clipCorner(view: passwordTextField, cornerRadius: 5)
        Common.clipCorner(view: loginBtn, cornerRadius: 5)
        
        

        // Do any additional setup after loading the view.
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
