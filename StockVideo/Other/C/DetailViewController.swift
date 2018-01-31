//
//  DetailViewController.swift
//  StockVideo
//
//  Created by 王彦森 on 2018/1/31.
//  Copyright © 2018年 BoXin. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    private var tableView : UITableView!
    
    private let headViewTopViewH:CGFloat = 145
    
    private var headView : UIView!
    
    private var imgBgView  : UIView!
    
    private let imgHeight : CGFloat = 234
    
    private let imgMargin : CGFloat = 6
    
    
    
    private var imgArr = ["http://e.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059099ccd5a2334349b023bbae5.jpg","http://e.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059099ccd5a2334349b023bbae5.jpg","http://a.hiphotos.baidu.com/image/pic/item/9213b07eca8065388cef4c5d9cdda144ad348273.jpg","http://g.hiphotos.baidu.com/image/pic/item/a6efce1b9d16fdfa09022da0bf8f8c5494ee7b16.jpg","http://b.hiphotos.baidu.com/image/pic/item/71cf3bc79f3df8dc086b64dfc611728b4710282e.jpg","http://b.hiphotos.baidu.com/image/pic/item/71cf3bc79f3df8dc086b64dfc611728b4710282e.jpg","http://b.hiphotos.baidu.com/image/pic/item/42166d224f4a20a417ead7899b529822730ed08c.jpg","http://h.hiphotos.baidu.com/image/pic/item/caef76094b36acaff9bf372b77d98d1000e99c8e.jpg","http://h.hiphotos.baidu.com/image/pic/item/caef76094b36acaff9bf372b77d98d1000e99c8e.jpg","http://h.hiphotos.baidu.com/image/pic/item/caef76094b36acaff9bf372b77d98d1000e99c8e.jpg","http://h.hiphotos.baidu.com/image/pic/item/caef76094b36acaff9bf372b77d98d1000e99c8e.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupHeadView()
        
        setupImgView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupHeadView(){
        
        headView = UIView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: 666))
        
        setupTitleView()
    

        
    }
    
    private func setupTitleView(){
        
        let headViewTopView = Bundle.main.loadNibNamed("DetailTopView", owner: nil, options: nil)?.first as! DetailTopView
        headViewTopView.width = Common.screenWidth
        headView.addSubview(headViewTopView)
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 8
        let attr = [NSAttributedStringKey.paragraphStyle:paraStyle,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)]
        let height = Common.autoLabelHeight(with: Common.testStr[0], labelWidth: Common.screenWidth - 30, attributes: attr)
        
        print(height)
        
        let contentTextLabel = UILabel(frame: CGRect(x: 15, y: headViewTopView.maxY, width: Common.screenWidth - 30, height: height))
        contentTextLabel.numberOfLines = 0
        contentTextLabel.font = UIFont.systemFont(ofSize: 16)
        contentTextLabel.attributedText = Common.getAttributeStringWithString(Common.testStr[0], lineSpace: 8)
        headView.addSubview(contentTextLabel)
        
        headView.height = headViewTopViewH + height + 10
        
    }
    
    private func setupImgView(){
        
        imgBgView = UIView(frame: CGRect(x: 0, y: headView.maxY + 10, width: Common.screenWidth, height: ( imgHeight + imgMargin ) * CGFloat (imgArr.count)))
        
        for i in 0 ..< imgArr.count {
            
            let imgView = UIImageView.init(frame: CGRect(x: 15, y: CGFloat(i) * ( imgHeight + imgMargin ), width: Common.screenWidth - 30, height: imgHeight))
            imgView.kf.setImage(with: URL.init(string: imgArr[i]))
            
            imgBgView.addSubview(imgView)
            
            headView.addSubview(imgBgView)
            
            headView.height = imgBgView.maxY
            
            tableView.tableHeaderView = headView
            
        }

    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Common.screenWidth, height: Common.screenHeight - 64 ))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Common.testStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
        return cell
    }
    
    
    
    
    
    
}
