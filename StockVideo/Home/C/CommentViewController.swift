//
//  HomeViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CommentViewController: BBViewController {

    var tableView: UITableView!
    
    var testComment = [["Test","Test2"],["Test3","Test4"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 - 49 ))
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 - 49), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 270
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.brown
        
        tableView.contentInsetAdjustmentBehavior = .always
//        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CommentViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: Common.screenWidth - 20, height: 50))
        
        titleLabel.backgroundColor = UIColor.cyan
        titleLabel.text = "评论正文"
        
        return titleLabel
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testComment[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = testComment[indexPath.section][indexPath.row]
        
        return cell

    }
    
}
