//
//  ResetPasswordVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/2.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var sureBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Common.clipCorner(view: codeTF, cornerRadius: 5)
        codeTF.backgroundColor = Common.textFieldBGColor
        codeTF.addLeftView()
        
        Common.clipCorner(view: newPasswordTF, cornerRadius: 5)
        newPasswordTF.backgroundColor = Common.textFieldBGColor
        newPasswordTF.addLeftView()
        
        sendCodeBtn.backgroundColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        Common.clipCorner(view: sendCodeBtn, cornerRadius: 5)
        
        sureBtn.backgroundColor = Common.commonYellow
        Common.clipCorner(view: sureBtn, cornerRadius: 5)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        
    }
    
    @objc private func sureBtnClick(){
        
        navigationController?.popToRootViewController(animated: true)
        
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
