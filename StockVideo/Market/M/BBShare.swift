
import Foundation

struct BBShare{
    
    var amount : String!
    var bP1 : String!
    var bP2 : String!
    var bP3 : String!
    var bP4 : String!
    var bP5 : String!
    var bV1 : String!
    var bV2 : String!
    var bV3 : String!
    var bV4 : String!
    var bV5 : String!
    var date : String!
    var high : String!
    var lastClose : String!
    var low : String!
    var name : String!
    var newPrice : String!
    var open : String!
    var openInt : String!
    var price2 : String!
    var price3 : String!
    var priceChangeRatio : String!
    var sP1 : String!
    var sP2 : String!
    var sP3 : String!
    var sP4 : String!
    var sP5 : String!
    var sV1 : String!
    var sV2 : String!
    var sV3 : String!
    var sV4 : String!
    var sV5 : String!
    var symbol : String!
    var vol2 : String!
    var volume : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        amount = dictionary["Amount"] as? String
        bP1 = dictionary["BP1"] as? String
        bP2 = dictionary["BP2"] as? String
        bP3 = dictionary["BP3"] as? String
        bP4 = dictionary["BP4"] as? String
        bP5 = dictionary["BP5"] as? String
        bV1 = dictionary["BV1"] as? String
        bV2 = dictionary["BV2"] as? String
        bV3 = dictionary["BV3"] as? String
        bV4 = dictionary["BV4"] as? String
        bV5 = dictionary["BV5"] as? String
        date = dictionary["Date"] as? String
        high = dictionary["High"] as? String
        lastClose = dictionary["LastClose"] as? String
        low = dictionary["Low"] as? String
        name = dictionary["Name"] as? String
        newPrice = dictionary["NewPrice"] as? String
        open = dictionary["Open"] as? String
        openInt = dictionary["Open_Int"] as? String
        price2 = dictionary["Price2"] as? String
        price3 = dictionary["Price3"] as? String
        priceChangeRatio = dictionary["PriceChangeRatio"] as? String
        sP1 = dictionary["SP1"] as? String
        sP2 = dictionary["SP2"] as? String
        sP3 = dictionary["SP3"] as? String
        sP4 = dictionary["SP4"] as? String
        sP5 = dictionary["SP5"] as? String
        sV1 = dictionary["SV1"] as? String
        sV2 = dictionary["SV2"] as? String
        sV3 = dictionary["SV3"] as? String
        sV4 = dictionary["SV4"] as? String
        sV5 = dictionary["SV5"] as? String
        symbol = dictionary["Symbol"] as? String
        vol2 = dictionary["Vol2"] as? String
        volume = dictionary["Volume"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if amount != nil{
            dictionary["Amount"] = amount
        }
        if bP1 != nil{
            dictionary["BP1"] = bP1
        }
        if bP2 != nil{
            dictionary["BP2"] = bP2
        }
        if bP3 != nil{
            dictionary["BP3"] = bP3
        }
        if bP4 != nil{
            dictionary["BP4"] = bP4
        }
        if bP5 != nil{
            dictionary["BP5"] = bP5
        }
        if bV1 != nil{
            dictionary["BV1"] = bV1
        }
        if bV2 != nil{
            dictionary["BV2"] = bV2
        }
        if bV3 != nil{
            dictionary["BV3"] = bV3
        }
        if bV4 != nil{
            dictionary["BV4"] = bV4
        }
        if bV5 != nil{
            dictionary["BV5"] = bV5
        }
        if date != nil{
            dictionary["Date"] = date
        }
        if high != nil{
            dictionary["High"] = high
        }
        if lastClose != nil{
            dictionary["LastClose"] = lastClose
        }
        if low != nil{
            dictionary["Low"] = low
        }
        if name != nil{
            dictionary["Name"] = name
        }
        if newPrice != nil{
            dictionary["NewPrice"] = newPrice
        }
        if open != nil{
            dictionary["Open"] = open
        }
        if openInt != nil{
            dictionary["Open_Int"] = openInt
        }
        if price2 != nil{
            dictionary["Price2"] = price2
        }
        if price3 != nil{
            dictionary["Price3"] = price3
        }
        if priceChangeRatio != nil{
            dictionary["PriceChangeRatio"] = priceChangeRatio
        }
        if sP1 != nil{
            dictionary["SP1"] = sP1
        }
        if sP2 != nil{
            dictionary["SP2"] = sP2
        }
        if sP3 != nil{
            dictionary["SP3"] = sP3
        }
        if sP4 != nil{
            dictionary["SP4"] = sP4
        }
        if sP5 != nil{
            dictionary["SP5"] = sP5
        }
        if sV1 != nil{
            dictionary["SV1"] = sV1
        }
        if sV2 != nil{
            dictionary["SV2"] = sV2
        }
        if sV3 != nil{
            dictionary["SV3"] = sV3
        }
        if sV4 != nil{
            dictionary["SV4"] = sV4
        }
        if sV5 != nil{
            dictionary["SV5"] = sV5
        }
        if symbol != nil{
            dictionary["Symbol"] = symbol
        }
        if vol2 != nil{
            dictionary["Vol2"] = vol2
        }
        if volume != nil{
            dictionary["Volume"] = volume
        }
        return dictionary
    }
    
}
