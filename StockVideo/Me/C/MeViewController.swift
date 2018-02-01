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
    
    private var titleText = ["我的消息","我的积分","观看记录","意见反馈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.title = "我的"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonClick))
 
//        self.navigationController!.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonClick))
        setupTableView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        avatarImgView.isUserInteractionEnabled = true
        avatarImgView.addGestureRecognizer(tap)
    }
    
    @objc private func tapAvatar(){
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func rightBarButtonClick(){
        
        print("1")
        
    }
    
}

extension MeViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.x = 100
        cell.textLabel?.text = titleText[indexPath.row]
        return cell
    }
}
