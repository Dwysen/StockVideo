//
//  CommentFromOtherVC.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/2/6.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CommentFromOtherVC: UIViewController {

    private var tableView : UITableView!
    
    private let testArr = ["Copyright © 2018年 BoXin. All rights reserved","Created by 王彦森 on 2018/2/6.Created by 王彦森 on 2018/2/6.Created by 王彦森 on 2018/2/6.","tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 - 49 ))","extension CommentFromOtherVC : UITableViewDataSource,UITableViewDelegate {func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 5}","StockVideo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "评论"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 123
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "CommentFromOtherCell", bundle: nil), forCellReuseIdentifier: "cell")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CommentFromOtherVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentFromOtherCell
        cell.commentFromOtherLabel.attributedText = Common.getAttributeStringWithString("评论了我:" + testArr[indexPath.row], lineSpace: 2)
        return cell
    }
    
    
}
