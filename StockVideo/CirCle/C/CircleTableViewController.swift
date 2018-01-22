//
//  CircleTableViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/19.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class CircleTableViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,HJImageBrowserDelegate {

    var numArr = [3,5,6,4,7,2,1,3,7,8,3,5,6,4,7,2,1,3,7,8]
    
    var mainTableView: UITableView!
    
    var theImage = UIImage()
    var theIndex = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        

        // Do any additional setup after loading the view.
    }
    
    override func configSubViews() {
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(mainTableView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if numArr[indexPath.row] > 6 {
            
            return 440
            
        } else if  numArr[indexPath.row] < 6 && numArr[indexPath.row] > 3{
            
            return 350
            
        } else {
            
            return 260
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .default
        
//        var num = Int(arc4random_uniform(6))+1
//        if num == 0 {
//            num = 7
//        }
        
       
        cell.assignToViews(num: numArr[indexPath.row])
        
        cell.showImageAction = {
            
            self.theImage = $2
            self.theIndex = $0
            
            let bview = HJImageBrowser()
            
            bview.delegate = self
            
            //            bottomView 这个一定要填写你点击的imageView的直接父视图
            //            cell.viewWithTag(10086) 这个就是cell类里面的那个images（UIView）我在Xib里面设置的
            bview.bottomView = cell.viewWithTag(10086)
            
            //            当前点击的图片在该数组中的位置。
            bview.indexImage = $0
            
            bview.defaultImage = $2
            
            bview.arrayImage = $1 as! [String]
            
            bview.show()
            
        }
        
        return cell
        
    }
    
    func getTheThumbnailImage(_ indexRow: Int) -> UIImage {
        
        //        点击图片之后，放大过程中显示的那张图片
        return theImage
    }
  

   

}


