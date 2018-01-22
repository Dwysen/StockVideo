//
//  MarketViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/16.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit

class MarketViewController: BBViewController {
    
    var tableView:UITableView!
    
    var upArr:[BBShare]!
    
    var downArr:[BBShare]!
    
    var scrollView:UIScrollView!
    
    var collpse = [true,true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        
        BBNetwork.shareNetworkTool.getUpTable(desc: 1) { (arr) in
            
            self.upArr = arr
            
            print(self.upArr.count)
            
            self.setupTableView()
            
        }
        
    }
    
    private func setupScrollView(){
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.scrollViewHeight))
        scrollView.contentSize = CGSize.init(width: Common.screenWidth, height: 2000)
        view.addSubview(scrollView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView(){
        
        if tableView == nil {
            
            tableView = UITableView(frame: CGRect(x: 0, y: 200, width: Common.screenWidth, height: 100 ))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isScrollEnabled = false
            tableView.register(UpAndDownCell.classForCoder(), forCellReuseIdentifier: "cell")
            
            tableView.register(UINib.init(nibName: "UpAndDownCell", bundle: nil), forCellReuseIdentifier: "cell")
            
            scrollView.addSubview(tableView)
            
        } else {
            
            tableView.reloadData()
            
        }
        
    }
    
    @objc private func gotoMarket(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "KLineViewController") as! KLineViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MarketViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if collpse[section] == false {
            
            return 10
            
        } else {
            
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 50))
        headView.backgroundColor = UIColor.cyan
        
        // 标题Label
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 60, height: 40))
        
        switch section {
        case 0:
            titleLabel.text = "涨幅榜"
        default:
            titleLabel.text = "跌幅榜"
        }
    
        titleLabel.textColor = UIColor.black
        headView.addSubview(titleLabel)
        
        // 箭头Label
        let arrowLabel = UILabel(frame: CGRect(x: 65, y: 20, width: 10, height: 10))
        arrowLabel.textColor = UIColor.black
        arrowLabel.text = ">"
        arrowLabel.tag = 1000
        headView.addSubview(arrowLabel)
        
        if collpse[section]{
            
            
        } else {
            arrowLabel.rotate(.pi / 2)
            
        }
        
        headView.isUserInteractionEnabled = true
        headView.tag = section
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(MarketViewController.tapHeadView(_:)))
        headView.addGestureRecognizer(tap)
        
        return headView
        
    }
    
    @objc func tapHeadView(_ sender:UITapGestureRecognizer){
        
        collpse[sender.view!.tag] = !collpse[sender.view!.tag]
        
        if collpse[sender.view!.tag] {
            
            UIView.animate(withDuration: 1, animations: {
                
                self.tableView.height -= 440
                
            })
            
        } else {
            
            if downArr == nil {
                
                BBNetwork.shareNetworkTool.getUpTable(desc: 0) { (arr) in
                    
                    self.downArr = arr
                    
                    print(self.downArr.count)
                    self.tableView.reloadData()
                }
                
            }
            
            
            self.tableView.height += 440
            
        }
        
//        let arrowLabel = sender.view?.viewWithTag(1000) as! UILabel
//        arrowLabel.rotate(.pi / 2)
        
        tableView.reloadSections(NSIndexSet.init(index: sender.view!.tag) as IndexSet, with: .automatic)
        
     
        
      
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpAndDownCell
        //        cell.textLabel?.text = upArr[indexPath.row].name
        
        if indexPath.section == 0 && upArr != nil{
            
            cell.upAndDown = upArr[indexPath.row]
            cell.priceLabel.textColor = UIColor.red
            cell.ratioLabel.textColor = UIColor.red
            
        }
        
        if indexPath.section == 1 && downArr != nil {
            
            cell.upAndDown = downArr[indexPath.row]
            cell.priceLabel.textColor = UIColor.green
            cell.ratioLabel.textColor = UIColor.green
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = KLineViewController()
        vc.symbol = upArr[indexPath.row].symbol
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
