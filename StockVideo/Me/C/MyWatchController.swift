//
//  MyWatchController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/2.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class MyWatchController: UIViewController {

    private var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的关注"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64  ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 56
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "WatchCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MyWatchController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchCell
        return cell
    }
    
    
    
}
