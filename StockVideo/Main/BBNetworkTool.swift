//
//  BBNetworkTool.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/17.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import Alamofire

class BBNetwork: NSObject  {
    
    static let shareNetworkTool = BBNetwork()
    
    //  获得涨幅榜
    
    func getUpTable(desc:Int,finished:@escaping (_ upArr:[BBShare]) -> () ) {
        
        let url = "http://db2015.wstock.cn/wsDB_API/stock.php?market=SH6,SZ00,SZ300&q_type=0&r_type=2&desc=\(desc)&u=test&p=8e6a&stime=2018-1-18&num=10"
        
        print(url)
        
        Alamofire.request(url).responseJSON{ (response) in
            
            if let value = response.result.value{
                
                let json = JSON(value)
                
                let dataArr = json.arrayValue
                
                var upArr = [BBShare]()
                
                for data in dataArr {
                    
                    let upShare = BBShare.init(fromDictionary: data.dictionaryObject! as NSDictionary)
                    upArr.append(upShare)
                    
                }
                
                finished(upArr)
            }
        }
        
    }
    
}
