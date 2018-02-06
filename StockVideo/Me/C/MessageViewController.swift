//
//  MessageViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/2.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    private var tableView : UITableView!
    
    private var titleArr = ["官方消息","赞","评论"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        title = "消息"
        
        setupTableView()
        

        // Do any additional setup after loading the view.
    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MessageViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        cell.titleLabel.text = titleArr[indexPath.row]
        cell.subTitleLabel.text = "习近平回复了你"
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("官方消息")
//            let vc = HomeViewController()
//            navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = StarFromOtherVC()
            navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = CommentFromOtherVC()
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
