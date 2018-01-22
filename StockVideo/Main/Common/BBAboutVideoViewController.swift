//
//  BBAboutVideoViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/22.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class BBAboutVideoViewController: BaseViewController {

    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 - 49 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 360
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BBAboutVideoViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        return cell
        
    }
    
}
