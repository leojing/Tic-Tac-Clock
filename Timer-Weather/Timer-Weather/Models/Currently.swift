//
//	Currently.swift
//
//	Create by Jing Luo on 20/4/2018
//	Copyright © 2018. All rights reserved.
//

import Foundation 

struct Currently: Codable {
    let icon : String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

//class Currently : NSObject, NSCoding, Mappable{
//
//    var apparentTemperature : Double?
//    var cloudCover : Double?
//    var dewPoint : Double?
//    var humidity : Double?
//    var icon : String?
//    var ozone : Double?
//    var precipIntensity : Int?
//    var precipProbability : Int?
//    var pressure : Double?
//    var summary : String?
//    var temperature : Double?
//    var time : Int?
//    var uvIndex : Int?
//    var visibility : Double?
//    var windBearing : Int?
//    var windGust : Double?
//    var windSpeed : Double?
//
//
//    class func newInstance(map: Map) -> Mappable?{
//        return Currently()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        apparentTemperature <- map["apparentTemperature"]
//        cloudCover <- map["cloudCover"]
//        dewPoint <- map["dewPoint"]
//        humidity <- map["humidity"]
//        icon <- map["icon"]
//        ozone <- map["ozone"]
//        precipIntensity <- map["precipIntensity"]
//        precipProbability <- map["precipProbability"]
//        pressure <- map["pressure"]
//        summary <- map["summary"]
//        temperature <- map["temperature"]
//        time <- map["time"]
//        uvIndex <- map["uvIndex"]
//        visibility <- map["visibility"]
//        windBearing <- map["windBearing"]
//        windGust <- map["windGust"]
//        windSpeed <- map["windSpeed"]
//
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         apparentTemperature = aDecoder.decodeObject(forKey: "apparentTemperature") as? Double
//         cloudCover = aDecoder.decodeObject(forKey: "cloudCover") as? Double
//         dewPoint = aDecoder.decodeObject(forKey: "dewPoint") as? Double
//         humidity = aDecoder.decodeObject(forKey: "humidity") as? Double
//         icon = aDecoder.decodeObject(forKey: "icon") as? String
//         ozone = aDecoder.decodeObject(forKey: "ozone") as? Double
//         precipIntensity = aDecoder.decodeObject(forKey: "precipIntensity") as? Int
//         precipProbability = aDecoder.decodeObject(forKey: "precipProbability") as? Int
//         pressure = aDecoder.decodeObject(forKey: "pressure") as? Double
//         summary = aDecoder.decodeObject(forKey: "summary") as? String
//         temperature = aDecoder.decodeObject(forKey: "temperature") as? Double
//         time = aDecoder.decodeObject(forKey: "time") as? Int
//         uvIndex = aDecoder.decodeObject(forKey: "uvIndex") as? Int
//         visibility = aDecoder.decodeObject(forKey: "visibility") as? Double
//         windBearing = aDecoder.decodeObject(forKey: "windBearing") as? Int
//         windGust = aDecoder.decodeObject(forKey: "windGust") as? Double
//         windSpeed = aDecoder.decodeObject(forKey: "windSpeed") as? Double
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if apparentTemperature != nil{
//            aCoder.encode(apparentTemperature, forKey: "apparentTemperature")
//        }
//        if cloudCover != nil{
//            aCoder.encode(cloudCover, forKey: "cloudCover")
//        }
//        if dewPoint != nil{
//            aCoder.encode(dewPoint, forKey: "dewPoint")
//        }
//        if humidity != nil{
//            aCoder.encode(humidity, forKey: "humidity")
//        }
//        if icon != nil{
//            aCoder.encode(icon, forKey: "icon")
//        }
//        if ozone != nil{
//            aCoder.encode(ozone, forKey: "ozone")
//        }
//        if precipIntensity != nil{
//            aCoder.encode(precipIntensity, forKey: "precipIntensity")
//        }
//        if precipProbability != nil{
//            aCoder.encode(precipProbability, forKey: "precipProbability")
//        }
//        if pressure != nil{
//            aCoder.encode(pressure, forKey: "pressure")
//        }
//        if summary != nil{
//            aCoder.encode(summary, forKey: "summary")
//        }
//        if temperature != nil{
//            aCoder.encode(temperature, forKey: "temperature")
//        }
//        if time != nil{
//            aCoder.encode(time, forKey: "time")
//        }
//        if uvIndex != nil{
//            aCoder.encode(uvIndex, forKey: "uvIndex")
//        }
//        if visibility != nil{
//            aCoder.encode(visibility, forKey: "visibility")
//        }
//        if windBearing != nil{
//            aCoder.encode(windBearing, forKey: "windBearing")
//        }
//        if windGust != nil{
//            aCoder.encode(windGust, forKey: "windGust")
//        }
//        if windSpeed != nil{
//            aCoder.encode(windSpeed, forKey: "windSpeed")
//        }
//
//    }
//
//}
