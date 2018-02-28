//
//  SettingViewController.swift
//  HongXue
//
//  Created by 王彦森 on 2017/10/18.
//  Copyright © 2017年 boxin. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UIViewController {
    
    var tableView : UITableView!
    
    let titleArr = [["自动播放设置","使用移动流量和WIFI","仅WIFI","关闭"],["检查更新"],["清除缓存","关于我们"]]
    var versionName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
        
        view.backgroundColor = Common.bgGray
        
        self.setupTableView()
        
        let isLogin = UserDefaults.standard.object(forKey: "isLogin") as? Bool
        
        if isLogin != nil{
            self.setupQuitBtn()
        }
    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 353))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
    }
    
    private func setupQuitBtn(){
        
        let quitBtn = UIButton(frame: CGRect(x: Common.screenWidth / 2 - 140 , y: 353 + 15, width: 280, height: 40))
        quitBtn.setTitle("退出登录", for: .normal)
        quitBtn.backgroundColor = Common.commonYellow
        quitBtn.setTitleColor(UIColor.white, for: .normal)
        quitBtn.addTarget(self, action: #selector(quit), for: .touchUpInside)
        view.addSubview(quitBtn)
        
    }
    
    @objc private func quit(){
        
        UserDefaults.standard.set(nil, forKey: "isLogin")
        UserDefaults.standard.set(nil, forKey: "phone")
        UserDefaults.standard.set(nil, forKey: "userLevel")
        UserDefaults.standard.set(false, forKey: "loginStatusChange")
        navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fileSizeOfCache()-> Int {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = (cachePath! as NSString).appending("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = size / 1024 / 1024
        return mm
    }
    
    func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
    }
}

extension SettingViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 15))
        view.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArr[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        
        switch indexPath.section {
            
        case 0:
            
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.textColor = Common.subTitleGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            
            let internetPlayOption = UserDefaults.standard.object(forKey: "internetPlayOption")
                as? String
            if internetPlayOption == nil {
                UserDefaults.standard.set("wifi", forKey: "internetPlayOption")
                
            }
            switch indexPath.row{
            case 1:
                
                if internetPlayOption == "any"{
                    cell.accessoryType = .checkmark
                }
            case 2:
                if internetPlayOption == "wifi"{
                    cell.accessoryType = .checkmark
                }
            case 3:
                if internetPlayOption == "none"{
                    cell.accessoryType = .checkmark
                }
                
            default:
                cell.textLabel?.textColor = UIColor.black
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            }
            
            
        case 2:
            
            if indexPath.row == 0 {
                // 清除缓存
                
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                let cache = fileSizeOfCache()
                cell.detailTextLabel?.text = "\(cache)M"
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
                
            } else {
                
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                
            }
            
        default:
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.detailTextLabel?.text = "版本：1.0"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            
        }
        
        cell.textLabel?.text = titleArr[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            
            if indexPath.row == 1 {
                // 使用移动流量和WIFI
                for cell in tableView.visibleCells{
                    cell.accessoryType = .none
                }
                let selectedCell = tableView.cellForRow(at: indexPath)
                selectedCell?.accessoryType = .checkmark
                UserDefaults.standard.set("any", forKey: "internetPlayOption")
                
                
            } else if indexPath.row == 2 {
                //仅WIFI
                for cell in tableView.visibleCells{
                    cell.accessoryType = .none
                }
                let selectedCell = tableView.cellForRow(at: indexPath)
                selectedCell?.accessoryType = .checkmark
                UserDefaults.standard.set("wifi", forKey: "internetPlayOption")
                
            } else if indexPath.row == 3{
                for cell in tableView.visibleCells{
                    cell.accessoryType = .none
                }
                let selectedCell = tableView.cellForRow(at: indexPath)
                selectedCell?.accessoryType = .checkmark
                UserDefaults.standard.set("none", forKey: "internetPlayOption")
            }
            
        case 1:break
            
//            HXNetwork.shareNetworkTool.getVersion { (softUrl, versionCode) in
//
//                print(versionCode)
//
//                if versionCode != Common.version {
//
//
//
//                    let url = URL.init(string: softUrl)
//
//                    UIApplication.shared.openURL(url!)
//
//                } else {
//
//                    self.showRightWithTitle(title: "已经是最新版", autoCloseTime: 1)
//
//                }
//
//
//            }
            
        default:
            if indexPath.row == 0 {
                // 清除缓存
                
                clearCache()
                
                let kfcache = KingfisherManager.shared.cache
                
                kfcache.clearDiskCache()//清除硬盘缓存
                kfcache.clearMemoryCache()//清理网络缓存
                kfcache.cleanExpiredDiskCache()//清理过期的，或者超过硬盘限制大小的
                
                tableView.reloadData()
                
            } else {
                
//                let vc = InformationHDetailViewController()
//
//                vc.bannerLink = Common.AboutUsUrl
//                vc.title = "关于我们"
//                navigationController?.pushViewController(vc, animated: true)
            
            }
        }
    }
}

