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
    
    private var titleText = ["我的消息","我的积分","观看记录","意见反馈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
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
}

extension MeViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.frame = CGRect.init(x: 50, y: 30, width: 200, height: 20)
        cell.textLabel?.text = titleText[indexPath.row]
        return cell
    }
}
