//
//  StarFromOtherVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/6.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class StarFromOtherVC: UIViewController {

    private var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "赞"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "StarFromOtherCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension StarFromOtherVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StarFromOtherCell
        return cell
    }
    
    
}
