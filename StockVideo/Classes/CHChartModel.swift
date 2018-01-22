//
//  CHChartModel.swift
//  CHKLineChart
//

import UIKit



/**
 改数据的走势方向
 
 - Up:    升
 - Down:  跌
 - Equal: 相等
 */
public enum CHChartItemTrend {
    case up
    case down
    case equal
}

/**
 *  数据元素
 */
open class CHChartItem: NSObject {
    
    open var time: String = ""
    open var openPrice: CGFloat = 0
    open var closePrice: CGFloat = 0
    open var lowPrice: CGFloat = 0
    open var highPrice: CGFloat = 0
    open var vol: CGFloat = 0
    open var value: CGFloat?
    open var extVal: [String: CGFloat] = [String: CGFloat]()        //扩展值，用来记录各种技术指标
    
    
    init(fromDictionary dictionary: NSDictionary){
        
        time = (dictionary["Date"] as! NSString) as String
        openPrice = CGFloat((dictionary["Open"] as! NSString).floatValue)
        closePrice = CGFloat((dictionary["Close"] as! NSString).floatValue)
        lowPrice = CGFloat((dictionary["Low"] as! NSString).floatValue)
        highPrice = CGFloat((dictionary["High"] as! NSString).floatValue)
        vol = CGFloat((dictionary["Volume"] as! NSString).floatValue)
        
    }
    
    open var trend: CHChartItemTrend {
        if closePrice == openPrice {
            return .equal
            
        }else{
            //收盘价比开盘低
            if closePrice < openPrice {
                return .down
            } else {
                //收盘价比开盘高
                return .up
            }
        }
    }
    
}

/**
 *  定义图表数据模型
 */
open class CHChartModel {
    
    /// MARK: - 成员变量
    open var upColor = UIColor.green                       //升的颜色
    open var downColor = UIColor.red                       //跌的颜色
    open var titleColor = UIColor.white                    //标题文本的颜色
    open var datas: [CHChartItem] = [CHChartItem]()               //数据值
    open var decimal: Int = 2                                     //小数位的长度
    open var showMaxVal: Bool = false                             //是否显示最大值
    open var showMinVal: Bool = false                             //是否显示最小值
    open var title: String = ""                                   //标题
    open var useTitleColor = true
    open var key: String = ""                                     //key的名字
    
    weak var section: CHSection!
    
    
    
    
    convenience init(upColor: UIColor,
                     downColor: UIColor,
                     title: String = "",
                     titleColor: UIColor,
                     datas: [CHChartItem] = [CHChartItem](),
                     decimal: Int = 2
        ) {
        self.init()
        self.upColor = upColor
        self.downColor = downColor
        self.titleColor = titleColor
        self.title = title
        self.datas = datas
        self.decimal = decimal
    }
    
    /**
     画点线
     
     - parameter startIndex:     起始索引
     - parameter endIndex:       结束索引
     - parameter plotPaddingExt: 点与点之间间断所占点宽的比例
     */
    open func drawSerie(_ startIndex: Int, endIndex: Int, plotPaddingExt: CGFloat = 0.25) { }
}


/**
 *  线点样式模型
 */
open class CHLineModel: CHChartModel {
    
    /**
     画点线
     
     - parameter startIndex:     起始索引
     - parameter endIndex:       结束索引
     - parameter plotPaddingExt: 点与点之间间断所占点宽的比例
     */
    open override func drawSerie(_ startIndex: Int, endIndex: Int,
                                 plotPaddingExt: CGFloat = 0.25) {
        
        //每个点的间隔宽度
        let plotWidth = (self.section.frame.size.width - self.section.padding.left - self.section.padding.right) / CGFloat(endIndex - startIndex)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(true)
        context?.setLineWidth(0.5)
        
        //循环起始到终结 - 1
        for i in stride(from: startIndex, to: endIndex - 1, by: 1) {
            
            let value = self[i].value           //开始的点
            let valueNext = self[i + 1].value   //下一个点
            
            if value == nil || valueNext == nil {
                continue  //无法计算的值不绘画
            }
            
            //开始X
            let ix = self.section.frame.origin.x + self.section.padding.left + CGFloat(i - startIndex) * plotWidth
            //结束X
            let iNx = self.section.frame.origin.x + self.section.padding.left + CGFloat(i + 1 - startIndex) * plotWidth
            
            //把具体的数值转为坐标系的y值
            let iys = self.section.getLocalY(value!)
            let iye = self.section.getLocalY(valueNext!)
            
            
            context?.setStrokeColor(self.upColor.cgColor)
            context?.move(to: CGPoint(x: ix + plotWidth / 2, y: iys))      //移动到当前点
            context?.addLine(to: CGPoint(x: iNx + plotWidth / 2, y: iye)) //画一条直线到下一个点
            
            context?.strokePath()
            
            
        }
    }
    
}

/**
 *  蜡烛样式模型
 */
open class CHCandleModel: CHChartModel {
    
    /**
     画点线
     
     - parameter startIndex:     起始索引
     - parameter endIndex:       结束索引
     - parameter plotPaddingExt: 点与点之间间断所占点宽的比例
     */
    open override func drawSerie(_ startIndex: Int, endIndex: Int,
                                 plotPaddingExt: CGFloat = 0.25) {
        
        //每个点的间隔宽度
        let plotWidth = (self.section.frame.size.width - self.section.padding.left - self.section.padding.right) / CGFloat(endIndex - startIndex)
        let plotPadding = plotWidth * plotPaddingExt
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(false)
        context?.setLineWidth(0.5)
        
        var maxItem: CHChartItem?       //最大值的项
        var maxPoint: CGPoint?          //最大值所在坐标
        var minItem: CHChartItem?       //最小值的项
        var minPoint: CGPoint?          //最小值所在坐标
        
        //循环起始到终结
        for i in stride(from: startIndex, to: endIndex, by: 1) {
            let item = datas[i]
            //开始X
            let ix = self.section.frame.origin.x + self.section.padding.left + CGFloat(i - startIndex) * plotWidth
            //结束X
            let iNx = self.section.frame.origin.x + self.section.padding.left + CGFloat(i + 1 - startIndex) * plotWidth
            
            //把具体的数值转为坐标系的y值
            let iyo = self.section.getLocalY(item.openPrice)
            let iyc = self.section.getLocalY(item.closePrice)
            let iyh = self.section.getLocalY(item.highPrice)
            let iyl = self.section.getLocalY(item.lowPrice)
            
            if iyh > iyc || iyh > iyo {
                NSLog("highPrice = \(item.highPrice), closePrice = \(item.closePrice), openPrice = \(item.openPrice)")
            }
            
            switch item.trend {
            case .equal:
                //开盘收盘一样，则显示横线
                context?.setStrokeColor(self.upColor.cgColor)
            case .up:
                //收盘价比开盘高，则显示涨的颜色
                context?.setStrokeColor(self.upColor.cgColor)
                context?.setFillColor(self.upColor.cgColor)
            case .down:
                //收盘价比开盘低，则显示跌的颜色
                context?.setStrokeColor(self.downColor.cgColor)
                context?.setFillColor(self.downColor.cgColor)
            }
            
            //1.先画最高和最低价格的线
            context?.move(to: CGPoint(x: ix + plotWidth / 2, y: iyh))
            context?.addLine(to: CGPoint(x: ix + plotWidth / 2, y: iyl))
            context?.strokePath()
            
            //2.画蜡烛柱的矩形，空心的刚好覆盖上面的线
            switch item.trend {
            case .equal:
                //开盘收盘一样，则显示横线
                context?.move(to: CGPoint(x: ix + plotPadding, y: iyo))
                context?.addLine(to: CGPoint(x: iNx - plotPadding, y: iyo))
                context?.strokePath()
            case .up:
                //收盘价比开盘高，则从收盘的Y值向下画矩形
                context?.fill(CGRect(x: ix + plotPadding, y: iyc, width: plotWidth - 2 * plotPadding, height: iyo - iyc))
            case .down:
                //收盘价比开盘低，则从开盘的Y值向下画矩形
                context?.fill(CGRect(x: ix + plotPadding, y: iyo, width: plotWidth - 2 *  plotPadding, height: iyc - iyo))
            }
            
            
            //记录最大值信息
            if item.highPrice == section.yAxis.max {
                maxItem = item
                maxPoint = CGPoint(x: ix + plotWidth / 2, y: iyh - section.padding.top / 2)
            }
            
            //记录最小值信息
            if item.lowPrice == section.yAxis.min {
                minItem = item
                minPoint = CGPoint(x: ix + plotWidth / 2, y: iyl + section.padding.bottom / 2)
            }
            
        }
        
        //显示最大最小值
        if self.showMaxVal && maxItem != nil {
            let highPrice = maxItem!.highPrice.ch_toString(maxF: section.decimal)
            self.drawGuideValue(context!, value: highPrice, section: section, point: maxPoint!)
        }
        
        //显示最大最小值
        if self.showMinVal && minItem != nil {
            let lowPrice = minItem!.lowPrice.ch_toString(maxF: section.decimal)
            self.drawGuideValue(context!, value: lowPrice, section: section, point: minPoint!)
        }
    }
    
    /**
     绘画最大值
     */
    func drawGuideValue(_ context: CGContext, value: String, section: CHSection, point: CGPoint) {
        
        let fontSize = value.ch_heightWithConstrainedWidth(section.labelFont)
        var arrowLineWidth: CGFloat = 4
        
        //判断绘画完整时是否超过界限
        var maxPriceStartX = point.x + arrowLineWidth * 5
        if maxPriceStartX + fontSize.width > section.frame.origin.x + section.frame.size.width - section.padding.right {
            //超过了最右边界，则反方向画
            arrowLineWidth = -4
            maxPriceStartX = point.x + arrowLineWidth * 5 - fontSize.width
        }
        
        context.setShouldAntialias(true)
        context.setStrokeColor(self.titleColor.cgColor)
        
        //画小箭头
        context.move(to: CGPoint(x: point.x, y: point.y))
        context.addLine(to: CGPoint(x: point.x + arrowLineWidth, y: point.y - arrowLineWidth))
        context.strokePath()
        
        context.move(to: CGPoint(x: point.x, y: point.y))
        context.addLine(to: CGPoint(x: point.x + arrowLineWidth, y: point.y + arrowLineWidth))
        context.strokePath()
        
        context.move(to: CGPoint(x: point.x, y: point.y))
        context.addLine(to: CGPoint(x: point.x + arrowLineWidth * 4, y: point.y))
        context.strokePath()
        
        
        let fontAttributes = [
            NSAttributedStringKey.font: section.labelFont,
            NSAttributedStringKey.foregroundColor: self.titleColor
            ] as [NSAttributedStringKey : Any]
        
        //计算画文字的位置
        let point = CGPoint(x: maxPriceStartX, y: point.y - fontSize.height / 2)
        
        //画最大值数字
        NSString(string: value)
            .draw(at: point,
                  withAttributes: fontAttributes)
        
        context.setShouldAntialias(false)
        
    }
    
    
}

/**
 *  交易量样式模型
 */
open class CHColumnModel: CHChartModel {
    
    /**
     画点线
     
     - parameter startIndex:     起始索引
     - parameter endIndex:       结束索引
     - parameter plotPaddingExt: 点与点之间间断所占点宽的比例
     */
    open override func drawSerie(_ startIndex: Int, endIndex: Int,
                                 plotPaddingExt: CGFloat = 0.25) {
        
        //每个点的间隔宽度
        let plotWidth = (self.section.frame.size.width - self.section.padding.left - self.section.padding.right) / CGFloat(endIndex - startIndex)
        let plotPadding = plotWidth * plotPaddingExt
        
        let iybase = self.section.getLocalY(section.yAxis.baseValue)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(false)
        context?.setLineWidth(0.5)
        
        //循环起始到终结
        for i in stride(from: startIndex, to: endIndex, by: 1) {
            //            let value = self[i].value
            //            
            //            if value == nil{
            //                continue  //无法计算的值不绘画
            //            }
            
            let item = datas[i]
            //开始X
            let ix = self.section.frame.origin.x + self.section.padding.left + CGFloat(i - startIndex) * plotWidth
            
            //把具体的数值转为坐标系的y值
            let iyv = self.section.getLocalY(item.vol)
            
            //收盘价比开盘低，则显示跌的颜色
            switch item.trend {
            case .up, .equal:
                //收盘价比开盘高，则显示涨的颜色
                context?.setStrokeColor(self.upColor.cgColor)
                context?.setFillColor(self.upColor.cgColor)
            case .down:
                context?.setStrokeColor(self.downColor.cgColor)
                context?.setFillColor(self.downColor.cgColor)
            }
            
            //画交易量的矩形
            context?.fill (CGRect(x: ix + plotPadding, y: iyv, width: plotWidth - 2 * plotPadding, height: iybase - iyv))
            
            
        }
    }
    
}

/**
 *  交易量样式模型
 */
open class CHBarModel: CHChartModel {
    
    /**
     画点线
     
     - parameter startIndex:     起始索引
     - parameter endIndex:       结束索引
     - parameter plotPaddingExt: 点与点之间间断所占点宽的比例
     */
    open override func drawSerie(_ startIndex: Int, endIndex: Int,
                                 plotPaddingExt: CGFloat = 0.25) {
        
        //每个点的间隔宽度
        let plotWidth = (self.section.frame.size.width - self.section.padding.left - self.section.padding.right) / CGFloat(endIndex - startIndex)
        let plotPadding = plotWidth * plotPaddingExt
        
        let iybase = self.section.getLocalY(section.yAxis.baseValue)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(false)
        context?.setLineWidth(0.5)
        
        //循环起始到终结
        for i in stride(from: startIndex, to: endIndex, by: 1) {
            //            let value = self[i].value
            //
            //            if value == nil{
            //                continue  //无法计算的值不绘画
            //            }
            
            let value = self[i].value           //读取的值
            
            if value == nil {
                continue  //无法计算的值不绘画
            }
            //开始X
            let ix = self.section.frame.origin.x + self.section.padding.left + CGFloat(i - startIndex) * plotWidth
            
            //把具体的数值转为坐标系的y值
            let iyv = self.section.getLocalY(value!)
            
            //如果值是正数
            if value! > 0 {
                //收盘价比开盘高，则显示涨的颜色
                context?.setStrokeColor(self.upColor.cgColor)
                context?.setFillColor(self.upColor.cgColor)
            } else {
                context?.setStrokeColor(self.downColor.cgColor)
                context?.setFillColor(self.downColor.cgColor)
            }
            
            //画交易量的矩形
            context?.fill (CGRect(x: ix + plotPadding, y: iyv, width: plotWidth - 2 * plotPadding, height: iybase - iyv))
            
            
        }
    }
    
}

// MARK: - 工厂方法
extension CHChartModel {
    
    //生成一个点线样式
    class func getLine(_ color: UIColor, title: String, key: String) -> CHLineModel {
        let model = CHLineModel(upColor: color, downColor: color,
                                titleColor: color)
        model.title = title
        model.key = key
        return model
    }
    
    //生成一个蜡烛样式
    class func getCandle(upColor: UIColor, downColor: UIColor) -> CHCandleModel {
        let model = CHCandleModel(upColor: upColor, downColor: downColor,
                                  titleColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
        model.key = "Candle"
        model.showMaxVal = true
        model.showMinVal = true
        return model
    }
    
    //生成一个交易量样式
    class func getVolume(upColor: UIColor, downColor: UIColor) -> CHColumnModel {
        let model = CHColumnModel(upColor: upColor, downColor: downColor,
                                  titleColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
        model.title = NSLocalizedString("Vol", comment: "")
        model.key = "Vol"
        return model
    }
    
    //生成一个柱状样式
    class func getBar(upColor: UIColor, downColor: UIColor, titleColor: UIColor, title: String, key: String) -> CHBarModel {
        let model = CHBarModel(upColor: upColor, downColor: downColor,
                               titleColor: titleColor)
        model.title = title
        model.key = key
        return model
    }
}

// MARK: - 扩展技术指标公式
extension CHChartModel {
    
    public subscript (index: Int) -> CHChartItem {
        var value: CGFloat?
        let item = self.datas[index]
        value = item.extVal[self.key]
        item.value = value
        return item
    }
    
}
