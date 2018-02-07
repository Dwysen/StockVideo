//
//  MeViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/26.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var myWatchView: UIView!
    
    private var titleText = ["我的消息","我的积分","观看记录"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()

        setupTableView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        avatarImgView.isUserInteractionEnabled = true
        avatarImgView.addGestureRecognizer(tap)
        
        let tapWatchView = UITapGestureRecognizer(target: self, action: #selector(tapWatch))
        myWatchView.isUserInteractionEnabled = true
        myWatchView.addGestureRecognizer(tapWatchView)
    }
    
    private func setupNav(){
    
        title = "我的"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "setting"), style: .plain, target: self, action: #selector(rightBarButtonClick))
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
    
    @objc private func tapAvatar(){
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func tapWatch(){
        
        let vc = MyWatchController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func rightBarButtonClick(){
        
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MeViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
//        cell.textLabel?.x = 100
        cell.textLabel?.text = titleText[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MessageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
