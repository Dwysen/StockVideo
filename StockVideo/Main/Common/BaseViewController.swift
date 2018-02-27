//
//  BaseViewController.swift
//


import UIKit

class BaseViewController: UIViewController{
    
//    var mainTableView = UITableView()
//    //    数据源
//    var mainTableArr = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViews()
//        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
//        configNavigationBarMainColor() 
    }
    
    //    每个导航控制器的第一个子控制器的导航栏都是 红色的
    func configNavigationBarMainColor() {
        self.navigationController?.navigationBar.setBackgroundImage(getNavigationIMG(64, fromColor: kSetRGBColor(r: 253, g: 100, b: 104), toColor: kSetRGBColor(r: 235, g: 133, b: 142)), for: .default)
        self.navigationItem.leftBarButtonItem?.tintColor = kSetRGBColor(r: 255, g: 255, b: 255)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    func configSubViews(){
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

