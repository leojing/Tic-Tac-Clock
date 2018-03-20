//
//	Currently.swift
//
//	Create by Jing Luo on 26/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Currently : NSObject, NSCoding, Mappable{

	var apparentTemperature : Float?
	var cloudCover : Float?
	var dewPoint : Float?
	var humidity : Float?
	var icon : String?
	var ozone : Float?
	var precipIntensity : Float?
	var precipProbability : Float?
	var precipType : String?
	var pressure : Float?
	var summary : String?
	var temperature : Float?
	var time : Int?
	var uvIndex : Int?
	var windBearing : Int?
	var windGust : Float?
	var windSpeed : Float?


	class func newInstance(map: Map) -> Mappable?{
		return Currently()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		apparentTemperature <- map["apparentTemperature"]
		cloudCover <- map["cloudCover"]
		dewPoint <- map["dewPoint"]
		humidity <- map["humidity"]
		icon <- map["icon"]
		ozone <- map["ozone"]
		precipIntensity <- map["precipIntensity"]
		precipProbability <- map["precipProbability"]
		precipType <- map["precipType"]
		pressure <- map["pressure"]
		summary <- map["summary"]
		temperature <- map["temperature"]
		time <- map["time"]
		uvIndex <- map["uvIndex"]
		windBearing <- map["windBearing"]
		windGust <- map["windGust"]
		windSpeed <- map["windSpeed"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         apparentTemperature = aDecoder.decodeObject(forKey: "apparentTemperature") as? Float
         cloudCover = aDecoder.decodeObject(forKey: "cloudCover") as? Float
         dewPoint = aDecoder.decodeObject(forKey: "dewPoint") as? Float
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Float
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         ozone = aDecoder.decodeObject(forKey: "ozone") as? Float
         precipIntensity = aDecoder.decodeObject(forKey: "precipIntensity") as? Float
         precipProbability = aDecoder.decodeObject(forKey: "precipProbability") as? Float
         precipType = aDecoder.decodeObject(forKey: "precipType") as? String
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Float
         summary = aDecoder.decodeObject(forKey: "summary") as? String
         temperature = aDecoder.decodeObject(forKey: "temperature") as? Float
         time = aDecoder.decodeObject(forKey: "time") as? Int
         uvIndex = aDecoder.decodeObject(forKey: "uvIndex") as? Int
         windBearing = aDecoder.decodeObject(forKey: "windBearing") as? Int
         windGust = aDecoder.decodeObject(forKey: "windGust") as? Float
         windSpeed = aDecoder.decodeObject(forKey: "windSpeed") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if apparentTemperature != nil{
			aCoder.encode(apparentTemperature, forKey: "apparentTemperature")
		}
		if cloudCover != nil{
			aCoder.encode(cloudCover, forKey: "cloudCover")
		}
		if dewPoint != nil{
			aCoder.encode(dewPoint, forKey: "dewPoint")
		}
		if humidity != nil{
			aCoder.encode(humidity, forKey: "humidity")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if ozone != nil{
			aCoder.encode(ozone, forKey: "ozone")
		}
		if precipIntensity != nil{
			aCoder.encode(precipIntensity, forKey: "precipIntensity")
		}
		if precipProbability != nil{
			aCoder.encode(precipProbability, forKey: "precipProbability")
		}
		if precipType != nil{
			aCoder.encode(precipType, forKey: "precipType")
		}
		if pressure != nil{
			aCoder.encode(pressure, forKey: "pressure")
		}
		if summary != nil{
			aCoder.encode(summary, forKey: "summary")
		}
		if temperature != nil{
			aCoder.encode(temperature, forKey: "temperature")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}
		if uvIndex != nil{
			aCoder.encode(uvIndex, forKey: "uvIndex")
		}
		if windBearing != nil{
			aCoder.encode(windBearing, forKey: "windBearing")
		}
		if windGust != nil{
			aCoder.encode(windGust, forKey: "windGust")
		}
		if windSpeed != nil{
			aCoder.encode(windSpeed, forKey: "windSpeed")
		}

	}

}