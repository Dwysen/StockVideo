//
//  EditMeView.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/1.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class EditMeView: UIView {
    
    @IBOutlet weak var topBgImgView: UIImageView!
    @IBOutlet weak var sexButton: UIButton!
    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    private var chooseView : UIView!
    private var blackView : UIView!
    private let sexArr = ["男","女"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHiden(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
        
        
        
        topBgImgView.contentMode = .scaleAspectFill
        topBgImgView.layer.masksToBounds = true
        
        avatarImg.layer.cornerRadius  = 50
        avatarImg.layer.masksToBounds = true
        bringSubview(toFront: avatarImg)
        
        sexButton.addTarget(self, action: #selector(tapSexBtn), for: .touchUpInside)
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.frame)
            
            //self.view.setNeedsLayout()
            //改变下约束
            self.topLayout.constant = 0 - (intersection.height / 2)
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHiden(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.frame)
            
            // 如果键盘的高度 == 0， 约束的值直接等于原来的值
            if intersection.height == 0 {
                
                topLayout.constant = 0
                
            } else {
                
            }
            
            // 刷新视图
            UIView.animate(withDuration: duration, delay: 0.0,options: UIViewAnimationOptions(rawValue: curve), animations: {
                
                self.layoutIfNeeded()
                
            }, completion: nil)
            
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         endEditing(true)
    }
    
    @objc private func tapSexBtn(){
        
        print("1")
        
        if blackView == nil {
            
            blackView = Common.getBlackView(frame: bounds)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(closeChooseView))
            blackView.addGestureRecognizer(tap)
            addSubview(blackView)
            
        }
        
        
        if chooseView == nil {
            
            chooseView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: width, height: 100))
            
            chooseView.backgroundColor = UIColor.orange
            
            let window = UIApplication.shared.keyWindow
            window?.addSubview(chooseView)
            
            
            for i in 0 ..< 2 {
                
                let btn = UIButton(frame: CGRect(x: 0, y: 0 + CGFloat(i) * 50, width: Common.screenWidth, height: 50))
                btn.setTitle(sexArr[i], for: .normal)
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.backgroundColor = UIColor.white
                chooseView.addSubview(btn)
                btn.tag = i
                btn.addTarget(self, action: #selector(chooseSex(sender:)), for: .touchUpInside)
                
            }
            
            let seperLine = UIView(frame: CGRect(x: 0, y: 49.5, width: Common.screenWidth, height: 1))
            seperLine.backgroundColor = UIColor.lightGray
            seperLine.alpha = 0.2
            chooseView.addSubview(seperLine)
            
        }
        
        
        UIView.animate(withDuration: 0.25) {
            
            self.chooseView.y -= 100
            self.blackView.alpha = 0.3
            
        }
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
        print("edit release ")
        
        
    }
 
    
    @objc private func chooseSex(sender:UIButton){
        
        if sender.tag != 2 {
            sexButton.setTitle(sender.titleLabel?.text, for: .normal)
        }
        closeChooseView()
    }
    
    @objc private func closeChooseView(){
        UIView.animate(withDuration: 0.25) {
            self.chooseView.y += 100
            self.blackView.alpha = 0
        }
    }
    
}
