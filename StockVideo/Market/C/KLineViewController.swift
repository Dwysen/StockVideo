//
//  ChartDemoViewController.swift
//  CHKLineChart
//

import UIKit

class KLineViewController: UIViewController {
    
    @IBOutlet var chartView: CHKLineChartView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var segPrice: UISegmentedControl!
    @IBOutlet var segAnalysis: UISegmentedControl!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    var klineDatas = [CHChartItem]()
    var symbol:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView = CHKLineChartView.init(frame: view.bounds)
        view.addSubview(chartView)

        loadingView = UIActivityIndicatorView.init(frame: CGRect.init(x: Common.screenWidth / 2 - 50, y: Common.screenHeight / 2 - 50, width: 100, height: 100))
        view.addSubview(loadingView)
        
        segPrice = UISegmentedControl.init(frame: CGRect(x: 10, y: 10, width: 100, height: 40))
        chartView.addSubview(segPrice)
        chartView.bringSubview(toFront: segPrice)
        
        self.chartView.delegate = self
        self.chartView.style = .base
        
        //        使用代码创建K线图表
        
        //        self.createChartView()
        
        //        self.getDataByFile()              //读取文件
        
        self.getRemoteServiceData(symbol:symbol! )       //读取网络
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     使用代码创建K线图表
     */
    func createChartView() {
        self.chartView = CHKLineChartView()
        self.chartView.translatesAutoresizingMaskIntoConstraints = false
        self.chartView.delegate = self
        self.chartView.style = CHKLineChartStyle.base
        self.contentView.addSubview(self.chartView)
        
        //水平布局
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[chartView]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["chartView": self.chartView]))
        
        //垂直布局
        self.contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[chartView]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:["chartView": self.chartView]))
    }
    
    func getRemoteServiceData(symbol:String) {
        self.loadingView.startAnimating()
        self.loadingView.isHidden = false
        // 快捷方式获得session对象
        let session = URLSession.shared
        
        // 数据源入口
        
        
        let str = "http://db2015.wstock.cn/wsDB_API/kline.php?stime=2015-03-31&num=3000&u=test&p=8e6a&symbol=\(symbol)&r_type=2"
        print(str)
        
        let url = URL(string: "http://db2015.wstock.cn/wsDB_API/kline.php?stime=2015-03-31&num=3000&u=test&p=8e6a&symbol=\(symbol)&r_type=2")
        // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
        let task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let data = data {
                
                let json = JSON(data)
                print(json)
                
                let array = json.arrayObject
                for data in array!.reversed() {
                    
                    let chartItem = CHChartItem(fromDictionary: data as! NSDictionary)
                    self.klineDatas.append(chartItem)
                    
                }
                
                DispatchQueue.main.async {
                    /*
                     对从服务器获取到的数据data进行相应的处理.
                     */
                    
                    self.chartView.reloadData()
                    self.loadingView.stopAnimating()
                    self.loadingView.isHidden = true
                }
                
            }
        })
        
        // 启动任务
        task.resume()
    }
    
    func getDataByFile() {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "data", ofType: "json")!))
        let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String: AnyObject]
        
        let isSuc = dict["isSuc"] as? Bool ?? false
        if isSuc {
            let datas = dict["datas"] as! [AnyObject]
            NSLog("chart.datas = \(datas.count)")
            self.klineDatas = datas as! [CHChartItem]
            self.chartView.reloadData()
        }
    }
    
    
    @IBAction func handleSegmentChange(sender: UISegmentedControl) {
        
        if sender === self.segPrice {
            switch sender.selectedSegmentIndex {
                
            case 0:
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.ma)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.ema)
            case 1:
                self.chartView.setSerie(hidden: false, by: CHSeriesKey.ma)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.ema)
            case 2:
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.ma)
                self.chartView.setSerie(hidden: false, by: CHSeriesKey.ema)
                
            default:
                break
            }
        } else {
            switch sender.selectedSegmentIndex {
            case 0:
                self.chartView.setSection(hidden: true, by: CHSectionValueType.analysis.key)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.kdj)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.macd)
            case 1:
                self.chartView.setSection(hidden: false, by: CHSectionValueType.analysis.key)
                self.chartView.setSerie(hidden: false, by: CHSeriesKey.kdj)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.macd)
            case 2:
                self.chartView.setSection(hidden: false, by: CHSectionValueType.analysis.key)
                self.chartView.setSerie(hidden: true, by: CHSeriesKey.kdj)
                self.chartView.setSerie(hidden: false, by: CHSeriesKey.macd)
                
            case 3:
                // TEST
                let testView = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 200))
                testView.backgroundColor = UIColor.black
                
                let testLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 50))
                testLabel.text = "买入"
                testLabel.textColor = UIColor.white
                
                testView.addSubview(testLabel)
                
                self.chartView.addSubview(testView)
                //                self.chartView.bringSubview(toFront: testView)
                
            default:
                break
            }
        }
    }
    
}

extension KLineViewController: CHKLineChartDelegate {
    
    func numberOfPointsInKLineChart(_ chart: CHKLineChartView) -> Int {
        return self.klineDatas.count
    }
    
    func kLineChart(_ chart: CHKLineChartView, valueForPointAtIndex index: Int) -> CHChartItem {
        let data = self.klineDatas[index]
        
        return data
    }
    
    func kLineChart(_ chart: CHKLineChartView, labelOnYAxisForValue value: CGFloat, section: CHSection) -> String {
        var strValue = ""
        if value / 10000 > 1 {
            strValue = (value / 10000).ch_toString(maxF: 2) + "万"
        } else {
            strValue = value.ch_toString(maxF: 2)
        }
        return strValue
    }
    
    func kLineChart(_ chart: CHKLineChartView, labelOnXAxisForIndex index: Int) -> String {
        return  self.klineDatas[index].time
        //        let timestamp = Int(data[0])
        //        return Date.ch_getTimeByStamp(timestamp, format: "HH:mm")
    }
    
    
}


// MARK: - 竖屏切换重载方法实现
extension KLineViewController {
    
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        print(toInterfaceOrientation.isLandscape)
        
        if toInterfaceOrientation.isLandscape {
            
            navigationController?.isNavigationBarHidden = true
            
            
        } else {
            
            navigationController?.isNavigationBarHidden = false
            
        }
        
        chartView.frame = view.bounds
        
        self.chartView.reloadData()
    }
    
}

