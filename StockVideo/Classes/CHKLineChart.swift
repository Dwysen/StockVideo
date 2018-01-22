//
//  CHKLineChart.swift
//  CHKLineChart
//

import UIKit

/**
 Y轴显示的位置
 
 - Left:  左边
 - Right: 右边
 - None:  不显示
 */
public enum CHYAxisShowPosition {
    case left, right, none
}

/**
 *  K线数据源代理
 */
@objc public protocol CHKLineChartDelegate: class {
    
    /**
     数据源总数
     
     - parameter chart:
     
     - returns:
     */
    func numberOfPointsInKLineChart(_ chart: CHKLineChartView) -> Int
    
    /**
     数据源索引为对应的对象
     
     - parameter chart:
     - parameter index: 索引位
     
     - returns: K线数据对象
     */
    func kLineChart(_ chart: CHKLineChartView, valueForPointAtIndex index: Int) -> CHChartItem
    
    /**
     获取图表Y轴的显示的内容
     
     - parameter chart:
     - parameter value:     计算得出的y值
     
     - returns:
     */
    func kLineChart(_ chart: CHKLineChartView, labelOnYAxisForValue value: CGFloat, section: CHSection) -> String
    
    /**
     获取图表X轴的显示的内容
     
     - parameter chart:
     - parameter index:     索引位
     
     - returns:
     */
    @objc optional func kLineChart(_ chart: CHKLineChartView, labelOnXAxisForIndex index: Int) -> String
    
    /**
     完成绘画图表
     
     */
    @objc optional func didFinishKLineChartRefresh(_ chart: CHKLineChartView)
    
}

open class CHKLineChartView: UIView {
    
    /// MARK: - 常量
    var kMinRange = 13       //最小缩放范围
    var kMaxRange = 133     //最大缩放范围
    var kPerInterval = 4    //缩放的每段间隔
    
    /// MARK: - 成员变量
    @IBInspectable open var upColor: UIColor = UIColor.green     //升的颜色
    @IBInspectable open var downColor: UIColor = UIColor.red     //跌的颜色
    @IBInspectable open var labelFont = UIFont.systemFont(ofSize: 10)
    @IBInspectable open var lineColor: UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) //线条颜色
    @IBInspectable open var dashColor: UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) //线条颜色
    @IBInspectable open var textColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) //文字颜色
    @IBInspectable open var xAxisPerInterval: Int = 4                        //x轴的间断个数
    @IBInspectable open var yLabelWidth:CGFloat = 46                    //Y轴的宽度
    
    open var handlerOfAlgorithms: [CHChartAlgorithm] = [CHChartAlgorithm]()
    open var padding: UIEdgeInsets = UIEdgeInsets.zero    //内边距
    open var showYLabel = CHYAxisShowPosition.right      //显示y的位置，默认右边
    open var style: CHKLineChartStyle! {           //显示样式
        didSet {
            //重新配置样式
            self.sections = self.style.sections
            self.backgroundColor = self.style.backgroundColor
            self.padding = self.style.padding
            self.handlerOfAlgorithms = self.style.algorithms
            self.lineColor = self.style.lineColor
            self.textColor = self.style.textColor
            self.dashColor = self.style.dashColor
            self.labelFont = self.style.labelFont
        }
        
    }
    
    open var decimal: Int = 2 {                     //保留小数位
        didSet {
            for section in self.sections {
                section.decimal = self.decimal
            }
        }
    }
    
    @IBOutlet open weak var delegate: CHKLineChartDelegate?             //代理
    
    var sections = [CHSection]()
    var selectedIndex: Int = -1                      //选择索引位
    var selectedPoint: CGPoint = CGPoint.zero
    
    var enableSelection = true                      //是否可点选
    
    var borderWidth: CGFloat = 0.5
    var lineWidth: CGFloat = 0.5
    var plotCount: Int = 0
    var rangeFrom: Int = 0                          //可见区域的开始索引位
    var rangeTo: Int = 0                            //可见区域的结束索引位
    var range: Int = 77                             //显示在可见区域的个数
    var borderColor: UIColor = UIColor.gray
    var labelSize = CGSize(width: 40, height: 16)
    
    var datas: [CHChartItem] = [CHChartItem]()      //数据源
    
    var selectedBGColor: UIColor = UIColor(white: 0.4, alpha: 1)
    var verticalLineView: UIView!
    var horizontalLineView: UIView!
    var selectedXAxisLabel: UILabel!
    var selectedYAxisLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initUI()
    }
    
//    convenience init(style: CHKLineChartStyle) {
//        self.init()
//        self.initUI()
//        self.style = style
//    }
    
    /**
     初始化UI
     
     - returns:
     */
    fileprivate func initUI() {
        
        self.isMultipleTouchEnabled = true
        
        //初始化点击选择的辅助线显示
        self.verticalLineView = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth, height: 0))
        self.verticalLineView.backgroundColor = self.selectedBGColor
        self.verticalLineView.isHidden = true
        self.addSubview(self.verticalLineView)
        
        self.horizontalLineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: lineWidth))
        self.horizontalLineView.backgroundColor = self.selectedBGColor
        self.horizontalLineView.isHidden = true
        self.addSubview(self.horizontalLineView)
        
        //用户点击图表显示当前y轴的实际值
        self.selectedYAxisLabel = UILabel(frame: CGRect.zero)
        self.selectedYAxisLabel.backgroundColor = self.selectedBGColor
        self.selectedYAxisLabel.isHidden = true
        self.selectedYAxisLabel.font = self.labelFont
        self.selectedYAxisLabel.textColor = self.textColor
        self.selectedYAxisLabel.textAlignment = NSTextAlignment.center
        self.addSubview(self.selectedYAxisLabel)
        
        //用户点击图表显示当前x轴的实际值
        self.selectedXAxisLabel = UILabel(frame: CGRect.zero)
        self.selectedXAxisLabel.backgroundColor = self.selectedBGColor
        self.selectedXAxisLabel.isHidden = true
        self.selectedXAxisLabel.font = self.labelFont
        self.selectedXAxisLabel.textColor = self.textColor
        self.selectedXAxisLabel.textAlignment = NSTextAlignment.center
        self.addSubview(self.selectedXAxisLabel)
        
        //添加手势操作
        self.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(doPanAciton(_:))))
        
        //点击手势操作
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
            action: #selector(doTapAction(_:))))
        
        
        //双指缩放操作
        self.addGestureRecognizer(UIPinchGestureRecognizer(
            target: self,
            action: #selector(doPinchAction(_:))))
        
        //初始数据
        self.resetData()
        
    }
    
    /**
     初始化数据
     */
    fileprivate func resetData() {
        self.datas.removeAll()
        self.plotCount = self.delegate?.numberOfPointsInKLineChart(self) ?? 0
        
        if plotCount > 0 {
            
            //获取代理上的数据源
            for i in 0...self.plotCount - 1 {
                let item = self.delegate?.kLineChart(self, valueForPointAtIndex: i)
                self.datas.append(item!)
            }
            
            //执行算法方程式计算值，添加到对象中
            for algorithm in self.handlerOfAlgorithms {
                //执行该算法，计算指标数据
                self.datas = algorithm.handleAlgorithm(self.datas)
            }
        }
    }
    
    
    /**
     获取点击区域所在分区位
     
     - parameter point: 点击坐标
     
     - returns: 返回section和索引位
     */
    func getSectionByTouchPoint(_ point: CGPoint) -> (Int, CHSection?) {
        for (i, section) in self.sections.enumerated() {
            if section.frame.contains(point) {
                return (i, section)
            }
        }
        return (-1, nil)
    }
    
    /**
     设置选中的数据点
     
     - parameter point:
     */
    func setSelectedIndexByPoint(_ point: CGPoint) {
        
        if point.equalTo(CGPoint.zero) {
            return
        }
        
        let (_, section) = self.getSectionByTouchPoint(point)
        if section == nil {
            return
        }
        
        let yaxis = section!.yAxis
        let format = "%.".appendingFormat("%df", yaxis.decimal)
        
        self.selectedPoint = point
        
        //每个点的间隔宽度
        let plotWidth = (section!.frame.size.width - section!.padding.left - section!.padding.right) / CGFloat(self.rangeTo - self.rangeFrom)
        
        let yVal = section!.getRawValue(point.y)        //获取y轴坐标的实际值
        
        for i in self.rangeFrom...self.rangeTo - 1 {
            let ixs = plotWidth * CGFloat(i - self.rangeFrom) + section!.padding.left + self.padding.left
            let ixe = plotWidth * CGFloat(i - self.rangeFrom + 1) + section!.padding.left + self.padding.left
            //            NSLog("ixs = \(ixs)")
            //            NSLog("ixe = \(ixe)")
            //            NSLog("point.x = \(point.x)")
            if ixs <= point.x && point.x < ixe {
                self.selectedIndex = i
                let item = self.datas[i]
                var hx = section!.frame.origin.x + section!.padding.left
                hx = hx + plotWidth * CGFloat(i - self.rangeFrom) + plotWidth / 2
                let hy = self.padding.top
                let hheight = self.frame.size.height - self.padding.bottom - self.padding.top
                //显示辅助线
                self.horizontalLineView.frame = CGRect(x: hx, y: hy, width: self.lineWidth, height: hheight)
                self.horizontalLineView.isHidden = false
                
                let vx = self.padding.left
                let vy = point.y
                let hwidth = section!.frame.size.width - section!.padding.left - section!.padding.right
                //显示辅助线
                self.verticalLineView.frame = CGRect(x: vx, y: vy, width: hwidth, height: self.lineWidth)
                self.verticalLineView.isHidden = false
                
                //显示y轴辅助内容
                //控制y轴的label在左还是右显示
                var yAxisStartX: CGFloat = 0
                self.selectedYAxisLabel.isHidden = false
                self.selectedXAxisLabel.isHidden = false
                switch self.showYLabel {
                case .left:
                    yAxisStartX = section!.frame.origin.x
                case .right:
                    yAxisStartX = section!.frame.origin.x + section!.frame.size.width - section!.padding.right
                case .none:
                    self.selectedYAxisLabel.isHidden = true
                }
                self.selectedYAxisLabel.text = String(format: format, yVal)     //显示实际值
                self.selectedYAxisLabel.frame = CGRect(x: yAxisStartX, y: point.y - self.labelSize.height / 2, width: self.yLabelWidth, height: self.labelSize.height)
                let time = item.time
//                let time = Date.ch_getTimeByStamp(item.time, format: "yyyy-MM-dd HH:mm") //显示实际值
                let size = time.ch_heightWithConstrainedWidth(self.labelFont)
                self.selectedXAxisLabel.text = time
                
                //判断x是否超过左右边界
                let labelWidth = size.width  + 6
                var x = hx - (labelWidth) / 2
                
                if x < section!.frame.origin.x {
                    x = section!.frame.origin.x
                } else if x + labelWidth > section!.frame.origin.x + section!.frame.size.width {
                    x = section!.frame.origin.x + section!.frame.size.width - labelWidth
                }
                
                self.selectedXAxisLabel.frame = CGRect(x: x, y: self.frame.size.height - self.padding.bottom, width: size.width  + 6, height: self.labelSize.height)
                
                break
            }
            
        }
    }
    
}

// MARK: - 绘图相关方法
extension CHKLineChartView {
    
    /**
     绘制图表
     
     - parameter rect:
     */
    override open func draw(_ rect: CGRect) {
        
        var lastSection: CHSection!
        //初始化数据
        if self.initChart() {
            
            //建立每个分区
            self.buildSections {
                (section, index) in
                //绘制每个区域
                self.drawSection(section)
                //初始Y轴的数据
                self.initYAxis(section)
                //绘制Y轴坐标
                self.drawYAxis(section)
                //绘制图表的点线
                self.drawChart(section)
                
                //显示范围最后一个点的内容
                section.drawTitle(self.selectedIndex)
                
                //记录最后一个分区
                lastSection = section
                
            }
            
            //最后一个分区下面绘制X轴坐标
            self.drawXAxis(lastSection)
            
            //重新显示点击选中的坐标
            self.setSelectedIndexByPoint(self.selectedPoint)
            
            self.delegate?.didFinishKLineChartRefresh?(self)
        }
    }
    
    /**
     初始化图表结构
     
     - returns: 是否初始化数据
     */
    fileprivate func initChart() -> Bool {
        
        self.plotCount = self.delegate?.numberOfPointsInKLineChart(self) ?? 0
        
        if plotCount > 0 {
            if self.rangeTo == 0 {      //如果图表尽头的索引为0，则进行初始化
                self.rangeTo = self.plotCount               //默认是数据最后一条为尽头
                if self.rangeTo - self.range > 0 {          //如果尽头 - 默认显示数大于0
                    self.rangeFrom = self.rangeTo - range   //计算开始的显示的位置
                } else {
                    self.rangeFrom = 0
                }
                
            }
        }
        
        //选择最后一个元素选中
        if selectedIndex == -1 {
            self.selectedIndex = self.rangeTo - 1
        }
        
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.backgroundColor!.cgColor)
        context?.fill (CGRect (x: 0, y: 0, width: self.bounds.size.width,height: self.bounds.size.height))
        return self.datas.count > 0 ? true : false
    }
    
    /**
     初始化各个分区
     
     - parameter complete: 初始化后，执行每个分区绘制
     */
    fileprivate func buildSections(
        _ complete:(_ section: CHSection, _ index: Int) -> Void) {
        //计算实际的显示高度和宽度
        let height = self.frame.size.height - (self.padding.top + self.padding.bottom)
        let width  = self.frame.size.width - (self.padding.left + self.padding.right)
        
        var total = 0
        for section in self.sections {
            if !section.hidden {
                total = total + section.ratios
            }
            
        }
        
        var offsetY: CGFloat = self.padding.top
        //计算每个区域的高度，并绘制
        for (index, section) in self.sections.enumerated() {
            var heightOfSection: CGFloat = 0
            let WidthOfSection = width
            if section.hidden {
                continue
            }
            //计算每个区域的高度
            heightOfSection = height * CGFloat(section.ratios) / CGFloat(total)
            
            //y轴的标签显示方位
            switch self.showYLabel {
            case .left:         //左边显示
                section.padding.left = self.yLabelWidth
                section.padding.right = 0
            case .right:        //右边显示
                section.padding.left = 0
                section.padding.right = self.yLabelWidth
            case .none:         //都不显示
                section.padding.left = 0
                section.padding.right = 0
            }
            
            //计算每个section的坐标
            section.frame = CGRect(x: 0 + self.padding.left,
                                       y: offsetY, width: WidthOfSection, height: heightOfSection)
            offsetY = offsetY + section.frame.height
            
            complete(section, index)
            
        }
        
        
        
    }
    
    
    /**
     绘制X轴上的标签
     
     - parameter padding: 内边距
     - parameter width:   总宽度
     */
    fileprivate func drawXAxis(_ lastSection: CHSection) {
        
        var startX: CGFloat = lastSection.frame.origin.x + lastSection.padding.left
        let endX: CGFloat = lastSection.frame.origin.x + lastSection.frame.size.width - lastSection.padding.right
        let secWidth: CGFloat = lastSection.frame.size.width
        let secPaddingLeft: CGFloat = lastSection.padding.left
        let secPaddingRight: CGFloat = lastSection.padding.right
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(false)
        context?.setLineWidth(self.lineWidth)
        context?.setStrokeColor(self.lineColor.cgColor)
        
        //x轴分平均分4个间断，显示5个x轴坐标，按照图表的值个数，计算每个间断的个数
        let dataRange = self.rangeTo - self.rangeFrom
        let xTickInterval: Int = dataRange / self.xAxisPerInterval
        
        //绘制x轴标签
        //每个点的间隔宽度
        let perPlotWidth: CGFloat = (secWidth - secPaddingLeft - secPaddingRight) / CGFloat(self.rangeTo - self.rangeFrom)
        let startY = self.frame.size.height - self.padding.bottom
        var k: Int = 0
        
        //X轴标签的字体样式
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = NSTextAlignment.center
        textStyle.lineBreakMode = NSLineBreakMode.byClipping
        
        let fontAttributes = [
            NSAttributedStringKey.font: self.labelFont,
            NSAttributedStringKey.paragraphStyle: textStyle,
            NSAttributedStringKey.foregroundColor: self.textColor
            ] as [NSAttributedStringKey : Any]
        
        //相当 for var i = self.rangeFrom; i < self.rangeTo; i = i + xTickInterval
        
        print("------test------------")
        
        print(rangeFrom)
        
        print(rangeTo)
        
        print(xTickInterval)
        
        print("------test------------")
        
   
        guard rangeTo - rangeFrom > 8 else {

            return

        }
        
     
        
        for i in stride(from: self.rangeFrom, to: self.rangeTo, by: xTickInterval) {
            context?.setFillColor(self.textColor.cgColor)
            context?.setShouldAntialias(true)  //抗锯齿开启，解决字体发虚
            let xLabel = self.delegate?.kLineChart?(self, labelOnXAxisForIndex: i) ?? ""
            var textSize = xLabel.ch_heightWithConstrainedWidth(self.labelFont)
            textSize.width = textSize.width + 4
            var xPox = startX - textSize.width / 2 + perPlotWidth / 2
            //计算最左最右的x轴标签不越过边界
            if (xPox < 0) {
                xPox = startX
            } else if (xPox + textSize.width > endX) {
                xPox = xPox - (xPox + textSize.width - endX)
            }
            //        NSLog(@"xPox = %f", xPox)
            //        NSLog(@"textSize.width = %f", textSize.width)
            let barLabelRect = CGRect(x: xPox, y: startY, width: textSize.width, height: textSize.height)
            NSString(string: xLabel).draw(in: barLabelRect,
                                                withAttributes: fontAttributes)
            
            
            k = k + xTickInterval
            startX = perPlotWidth * CGFloat(k)
        }
        
        context?.strokePath()
    }
    
    
    /**
     绘制分区
     
     - parameter section:
     */
    fileprivate func drawSection(_ section: CHSection) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(false)
        context?.setLineWidth(self.lineWidth)
        context?.setStrokeColor(self.lineColor.cgColor)
        
        //画低部边线
        context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: section.frame.size.height + section.frame.origin.y))
        context?.addLine(to: CGPoint(x: section.frame.origin.x + section.frame.size.width, y: section.frame.size.height + section.frame.origin.y))
        //画顶部边线
        context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: section.frame.origin.y))
        context?.addLine(to: CGPoint(x: section.frame.origin.x + section.frame.size.width, y: section.frame.origin.y))
        
        //画左边线
        context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: section.frame.origin.y))
        context?.addLine(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: section.frame.size.height + section.frame.origin.y))
        
        //画右边线
        context?.move(to: CGPoint(x: section.frame.origin.x + section.frame.size.width - section.padding.right, y: section.frame.origin.y))
        context?.addLine(to: CGPoint(x: section.frame.origin.x + section.frame.size.width - section.padding.right, y: section.frame.size.height + section.frame.origin.y))
        
        context?.strokePath()
        
    }
    
    /**
     初始化分区上各个线的Y轴
     */
    fileprivate func initYAxis(_ section: CHSection) {
        
        if section.series.count > 0 {
            //建立分区每条线的坐标系
            section.buildYAxis(startIndex: self.rangeFrom, endIndex: self.rangeTo, datas: self.datas)
        }
        
    }
    
    /**
     绘制Y轴左边
     
     - parameter section: 分区
     */
    fileprivate func drawYAxis(_ section: CHSection) {
        
        let context = UIGraphicsGetCurrentContext()
        
        //设置画笔颜色
        context?.setShouldAntialias(false)
        context?.setLineWidth(0.5)
        context?.setStrokeColor(self.lineColor.cgColor)
        
        var startX: CGFloat = 0
        var showYAxisLabel: Bool = true
        
        context?.setFillColor(self.textColor.cgColor)      //文字填充颜色
        let dash:[CGFloat] = [5]
        context?.setLineDash(phase: 0, lengths: dash)
        
        //分区中各个y轴虚线和y轴的label
        //控制y轴的label在左还是右显示
        switch self.showYLabel {
        case .left:
            startX = section.frame.origin.x - 1
        case .right:
            startX = section.frame.origin.x + section.frame.size.width - section.padding.right + 3
        case .none:
            showYAxisLabel = false
        }
        
        let fontAttributes = [
            NSAttributedStringKey.font: self.labelFont,
            NSAttributedStringKey.foregroundColor: self.textColor
            ] as [NSAttributedStringKey : Any]
        
        var yaxis = section.yAxis
//        let format = NSString(string: "%.".appendingFormat("%df", yaxis.decimal))
        
        //保持Y轴标签个数偶数显示
        if (yaxis.tickInterval % 2 == 1) {
            yaxis.tickInterval += 1
        }
        
        //计算y轴的标签及虚线分几段
        let step = (yaxis.max - yaxis.min) / CGFloat(yaxis.tickInterval)
        
        //从base值绘制Y轴标签到最大值
        var i = 0
        var yVal = yaxis.baseValue + CGFloat(i) * step
        while yVal <= yaxis.max && i <= yaxis.tickInterval {
            //画虚线和Y标签值
            let iy = section.getLocalY(yVal)
            if showYAxisLabel {
                //突出的线段
                context?.setShouldAntialias(false)
                context?.setStrokeColor(self.dashColor.cgColor)
                context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left + section.frame.size.width - section.padding.right, y: iy))
                context?.addLine(to: CGPoint(x: section.frame.origin.x + section.padding.left + section.frame.size.width - section.padding.right + 2, y: iy))
                context?.strokePath()
                
                //把Y轴标签文字画上去
                context?.setShouldAntialias(true)  //抗锯齿开启，解决字体发虚
                
                let strValue = self.delegate?.kLineChart(self, labelOnYAxisForValue: yVal, section: section) ?? ""
                
                NSString(string: strValue).draw(
                    at: CGPoint(x: startX, y: iy - 7), withAttributes: fontAttributes)
            }
            
            context?.setShouldAntialias(false)
            context?.setStrokeColor(self.dashColor.cgColor)
            context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: iy))
            context?.addLine(to: CGPoint(x: section.frame.origin.x + section.frame.size.width - section.padding.right, y: iy))
            
            context?.strokePath()
            
            //递增下一个
            i =  i + 1
            yVal = yaxis.baseValue + CGFloat(i) * step
        }
        
        i = 0
        yVal = yaxis.baseValue - CGFloat(i) * step
        while yVal >= yaxis.min && i <= yaxis.tickInterval {
            //画虚线和Y标签值
            let iy = section.getLocalY(yVal)
            if showYAxisLabel {
                //突出的线段
                context?.setShouldAntialias(false)
                context?.setStrokeColor(self.dashColor.cgColor)
                context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left + section.frame.size.width - section.padding.right, y: iy))
                context?.addLine(to: CGPoint(x: section.frame.origin.x + section.padding.left + section.frame.size.width - section.padding.right + 2, y: iy))
                context?.strokePath()
                
                //把Y轴标签文字画上去
                context?.setShouldAntialias(true)  //抗锯齿开启，解决字体发虚
                
                let strValue = self.delegate?.kLineChart(self, labelOnYAxisForValue: yVal, section: section) ?? ""
                
                NSString(string: strValue).draw(
                    at: CGPoint(x: startX, y: iy - 7), withAttributes: fontAttributes)
            }
            
            context?.setShouldAntialias(false)
            context?.setStrokeColor(self.dashColor.cgColor)
            context?.move(to: CGPoint(x: section.frame.origin.x + section.padding.left, y: iy))
            context?.addLine(to: CGPoint(x: section.frame.origin.x + section.frame.size.width - section.padding.right, y: iy))
            
            context?.strokePath()
            
            //递增下一个
            i =  i + 1
            yVal = yaxis.baseValue - CGFloat(i) * step
        }
        
        context?.setLineDash(phase: 0, lengths: [])
    }
    
    /**
     绘制图表上的点线
     
     - parameter section:
     */
    func drawChart(_ section: CHSection) {
        if section.paging {
            //如果section以分页显示，则读取当前显示的系列
            let serie = section.series[section.selectedIndex]
            self.drawSerie(serie)
            
        } else {
            //不分页显示，全部系列绘制到图表上
            for serie in section.series {
                self.drawSerie(serie)
            }
        }
        
    }
    
    /**
     绘制图表分区上的系列点先
     */
    func drawSerie(_ serie: CHSeries) {
        if !serie.hidden {
            //循环画出每个模型的线
            for model in serie.chartModels {
                model.drawSerie(self.rangeFrom, endIndex: self.rangeTo)
            }
        }
    }
}

// MARK: - 公开方法
extension CHKLineChartView {
    
    /**
     刷新视图
     */
    public func reloadData() {
        self.resetData()
        self.setNeedsDisplay()
    }
    
    /**
     通过key隐藏或显示线系列
     */
    public func setSerie(hidden: Bool, by key: String) {
        for section in self.sections {
            for (index, serie)  in section.series.enumerated() {
                if serie.key == key {
                    
                    if section.paging {
                        if hidden == false {
                            section.selectedIndex = index
                        }
                    } else {
                        serie.hidden = hidden
                    }
                    
                    break
                }
            }
        }
        self.setNeedsDisplay()
    }
    
    /**
     通过key隐藏或显示分区
     */
    public func setSection(hidden: Bool, by key: String) {
        for section in self.sections {
            if section.key == key {
                section.hidden = hidden
                break
            }
        }
        self.setNeedsDisplay()
    }
}


// MARK: - 手势操作
extension CHKLineChartView {
    
    /**
     *  拖动操作
     *
     *  @param sender
     */
    func doPanAciton(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let  velocity =  sender.velocity(in: self)
        
        var interval: Int = 0
        
        //处理滑动的幅度
        let panRange = fabs(velocity.x)    //滑动的力度
        interval = Int(panRange / 70)              //力度大于100才移动
        if (interval > 4) {                     //移动的间隔不超过5
            interval = 4
        }
        if (interval > 0) {                     //有移动间隔才移动
            if(translation.x > 0){
                //单指向右拖，往后查看数据
                if self.plotCount > (self.rangeTo-self.rangeFrom) {
                    if self.rangeFrom - interval >= 0 {
                        self.rangeFrom -= interval
                        self.rangeTo   -= interval
                        
                    } else {
                        self.rangeFrom = 0
                        self.rangeTo -= self.rangeFrom
                        
                    }
                    self.setNeedsDisplay()
                }
            } else if translation.x < 0 {
                //单指向左拖，往前查看数据
                if self.plotCount > (self.rangeTo-self.rangeFrom) {
                    if self.rangeTo + interval <= self.plotCount {
                        self.rangeFrom += interval
                        self.rangeTo += interval
                        
                    } else {
                        self.rangeFrom += self.plotCount - self.rangeTo
                        self.rangeTo  = self.plotCount
                        
                        
                    }
                    self.setNeedsDisplay()
                }
            }
        }
        
        sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
    }
    
    /**
     *  点击事件处理
     *
     *  @param sender
     */
    func doTapAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        let (_, section) = self.getSectionByTouchPoint(point)
        if section != nil {
            if section!.paging {
                //显示下一页
                section!.nextPage()
            } else {
                //显示点击选中的内容
                self.setSelectedIndexByPoint(point)
            }
            
            self.setNeedsDisplay()
        }
    }
    
    
    /**
     *  双指缩放操作
     */
    func doPinchAction(_ sender: UIPinchGestureRecognizer) {
        //双指合拢或张开
        let interval = self.kPerInterval / 2
        let scale = sender.scale
        let velocity = sender.velocity
        
        var newRangeTo = 0
        var newRangeFrom = 0
        var newRange = 0
        if fabs(velocity) > 0.1 {   //力度的绝对值大于0.1才起作用
            if scale > 1 {
                //双指张开
                newRangeTo = self.rangeTo - interval
                newRangeFrom = self.rangeFrom + interval
                newRange = self.rangeTo - self.rangeFrom
                if newRange >= kMinRange {
                    
                    if self.plotCount > self.rangeTo - self.rangeFrom {
                        if newRangeFrom < self.rangeTo {
                            self.rangeFrom = newRangeFrom
                        }
                        if newRangeTo > self.rangeFrom {
                            self.rangeTo = newRangeTo
                        }
                    }else{
                        if newRangeTo > self.rangeFrom {
                            self.rangeTo = newRangeTo
                        }
                    }
                    self.setNeedsDisplay()
                }
                
            } else {
                //双指合拢
                newRangeTo = self.rangeTo + interval
                newRangeFrom = self.rangeFrom - interval
                newRange = self.rangeTo - self.rangeFrom
                if newRange <= kMaxRange {
                    
                    if newRangeFrom >= 0 {
                        self.rangeFrom = newRangeFrom
                    } else {
                        self.rangeFrom = 0
                        newRangeTo = newRangeTo - newRangeFrom //补充负数位到头部
                    }
                    if newRangeTo <= self.plotCount {
                        self.rangeTo = newRangeTo
                        
                    } else {
                        self.rangeTo = self.plotCount
                        newRangeFrom = newRangeFrom - (newRangeTo - self.plotCount)
                        if newRangeFrom < 0 {
                            self.rangeFrom = 0
                        } else {
                            self.rangeFrom = newRangeFrom
                        }
                    }
                    
                    self.setNeedsDisplay()
                }
            }
        }
        
        sender.scale = 1
    }
    
}
