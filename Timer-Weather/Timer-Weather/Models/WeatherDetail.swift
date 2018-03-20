//
//	Data.swift
//
//	Create by Jing Luo on 26/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WeatherDetail : NSObject, NSCoding, Mappable{

	var apparentTemperatureHigh : Float?
	var apparentTemperatureHighTime : Int?
	var apparentTemperatureLow : Float?
	var apparentTemperatureLowTime : Int?
	var apparentTemperatureMax : Float?
	var apparentTemperatureMaxTime : Int?
	var apparentTemperatureMin : Float?
	var apparentTemperatureMinTime : Int?
	var cloudCover : Float?
	var dewPoint : Float?
	var humidity : Float?
	var icon : String?
	var moonPhase : Float?
	var ozone : Float?
	var precipIntensity : Float?
	var precipIntensityMax : Float?
	var precipIntensityMaxTime : Int?
	var precipProbability : Float?
	var precipType : String?
	var pressure : Float?
	var summary : String?
	var sunriseTime : Int?
	var sunsetTime : Int?
	var temperatureHigh : Float?
	var temperatureHighTime : Int?
	var temperatureLow : Float?
	var temperatureLowTime : Int?
	var temperatureMax : Float?
	var temperatureMaxTime : Int?
	var temperatureMin : Float?
	var temperatureMinTime : Int?
	var time : Int?
	var uvIndex : Int?
	var uvIndexTime : Int?
	var windBearing : Int?
	var windGust : Float?
	var windGustTime : Int?
	var windSpeed : Float?
	var apparentTemperature : Float?
	var temperature : Float?


	class func newInstance(map: Map) -> Mappable?{
		return WeatherDetail()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		apparentTemperatureHigh <- map["apparentTemperatureHigh"]
		apparentTemperatureHighTime <- map["apparentTemperatureHighTime"]
		apparentTemperatureLow <- map["apparentTemperatureLow"]
		apparentTemperatureLowTime <- map["apparentTemperatureLowTime"]
		apparentTemperatureMax <- map["apparentTemperatureMax"]
		apparentTemperatureMaxTime <- map["apparentTemperatureMaxTime"]
		apparentTemperatureMin <- map["apparentTemperatureMin"]
		apparentTemperatureMinTime <- map["apparentTemperatureMinTime"]
		cloudCover <- map["cloudCover"]
		dewPoint <- map["dewPoint"]
		humidity <- map["humidity"]
		icon <- map["icon"]
		moonPhase <- map["moonPhase"]
		ozone <- map["ozone"]
		precipIntensity <- map["precipIntensity"]
		precipIntensityMax <- map["precipIntensityMax"]
		precipIntensityMaxTime <- map["precipIntensityMaxTime"]
		precipProbability <- map["precipProbability"]
		precipType <- map["precipType"]
		pressure <- map["pressure"]
		summary <- map["summary"]
		sunriseTime <- map["sunriseTime"]
		sunsetTime <- map["sunsetTime"]
		temperatureHigh <- map["temperatureHigh"]
		temperatureHighTime <- map["temperatureHighTime"]
		temperatureLow <- map["temperatureLow"]
		temperatureLowTime <- map["temperatureLowTime"]
		temperatureMax <- map["temperatureMax"]
		temperatureMaxTime <- map["temperatureMaxTime"]
		temperatureMin <- map["temperatureMin"]
		temperatureMinTime <- map["temperatureMinTime"]
		time <- map["time"]
		uvIndex <- map["uvIndex"]
		uvIndexTime <- map["uvIndexTime"]
		windBearing <- map["windBearing"]
		windGust <- map["windGust"]
		windGustTime <- map["windGustTime"]
		windSpeed <- map["windSpeed"]
		apparentTemperature <- map["apparentTemperature"]
		temperature <- map["temperature"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         apparentTemperatureHigh = aDecoder.decodeObject(forKey: "apparentTemperatureHigh") as? Float
         apparentTemperatureHighTime = aDecoder.decodeObject(forKey: "apparentTemperatureHighTime") as? Int
         apparentTemperatureLow = aDecoder.decodeObject(forKey: "apparentTemperatureLow") as? Float
         apparentTemperatureLowTime = aDecoder.decodeObject(forKey: "apparentTemperatureLowTime") as? Int
         apparentTemperatureMax = aDecoder.decodeObject(forKey: "apparentTemperatureMax") as? Float
         apparentTemperatureMaxTime = aDecoder.decodeObject(forKey: "apparentTemperatureMaxTime") as? Int
         apparentTemperatureMin = aDecoder.decodeObject(forKey: "apparentTemperatureMin") as? Float
         apparentTemperatureMinTime = aDecoder.decodeObject(forKey: "apparentTemperatureMinTime") as? Int
         cloudCover = aDecoder.decodeObject(forKey: "cloudCover") as? Float
         dewPoint = aDecoder.decodeObject(forKey: "dewPoint") as? Float
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Float
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         moonPhase = aDecoder.decodeObject(forKey: "moonPhase") as? Float
         ozone = aDecoder.decodeObject(forKey: "ozone") as? Float
         precipIntensity = aDecoder.decodeObject(forKey: "precipIntensity") as? Float
         precipIntensityMax = aDecoder.decodeObject(forKey: "precipIntensityMax") as? Float
         precipIntensityMaxTime = aDecoder.decodeObject(forKey: "precipIntensityMaxTime") as? Int
         precipProbability = aDecoder.decodeObject(forKey: "precipProbability") as? Float
         precipType = aDecoder.decodeObject(forKey: "precipType") as? String
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Float
         summary = aDecoder.decodeObject(forKey: "summary") as? String
         sunriseTime = aDecoder.decodeObject(forKey: "sunriseTime") as? Int
         sunsetTime = aDecoder.decodeObject(forKey: "sunsetTime") as? Int
         temperatureHigh = aDecoder.decodeObject(forKey: "temperatureHigh") as? Float
         temperatureHighTime = aDecoder.decodeObject(forKey: "temperatureHighTime") as? Int
         temperatureLow = aDecoder.decodeObject(forKey: "temperatureLow") as? Float
         temperatureLowTime = aDecoder.decodeObject(forKey: "temperatureLowTime") as? Int
         temperatureMax = aDecoder.decodeObject(forKey: "temperatureMax") as? Float
         temperatureMaxTime = aDecoder.decodeObject(forKey: "temperatureMaxTime") as? Int
         temperatureMin = aDecoder.decodeObject(forKey: "temperatureMin") as? Float
         temperatureMinTime = aDecoder.decodeObject(forKey: "temperatureMinTime") as? Int
         time = aDecoder.decodeObject(forKey: "time") as? Int
         uvIndex = aDecoder.decodeObject(forKey: "uvIndex") as? Int
         uvIndexTime = aDecoder.decodeObject(forKey: "uvIndexTime") as? Int
         windBearing = aDecoder.decodeObject(forKey: "windBearing") as? Int
         windGust = aDecoder.decodeObject(forKey: "windGust") as? Float
         windGustTime = aDecoder.decodeObject(forKey: "windGustTime") as? Int
         windSpeed = aDecoder.decodeObject(forKey: "windSpeed") as? Float
         apparentTemperature = aDecoder.decodeObject(forKey: "apparentTemperature") as? Float
         temperature = aDecoder.decodeObject(forKey: "temperature") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if apparentTemperatureHigh != nil{
			aCoder.encode(apparentTemperatureHigh, forKey: "apparentTemperatureHigh")
		}
		if apparentTemperatureHighTime != nil{
			aCoder.encode(apparentTemperatureHighTime, forKey: "apparentTemperatureHighTime")
		}
		if apparentTemperatureLow != nil{
			aCoder.encode(apparentTemperatureLow, forKey: "apparentTemperatureLow")
		}
		if apparentTemperatureLowTime != nil{
			aCoder.encode(apparentTemperatureLowTime, forKey: "apparentTemperatureLowTime")
		}
		if apparentTemperatureMax != nil{
			aCoder.encode(apparentTemperatureMax, forKey: "apparentTemperatureMax")
		}
		if apparentTemperatureMaxTime != nil{
			aCoder.encode(apparentTemperatureMaxTime, forKey: "apparentTemperatureMaxTime")
		}
		if apparentTemperatureMin != nil{
			aCoder.encode(apparentTemperatureMin, forKey: "apparentTemperatureMin")
		}
		if apparentTemperatureMinTime != nil{
			aCoder.encode(apparentTemperatureMinTime, forKey: "apparentTemperatureMinTime")
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
		if moonPhase != nil{
			aCoder.encode(moonPhase, forKey: "moonPhase")
		}
		if ozone != nil{
			aCoder.encode(ozone, forKey: "ozone")
		}
		if precipIntensity != nil{
			aCoder.encode(precipIntensity, forKey: "precipIntensity")
		}
		if precipIntensityMax != nil{
			aCoder.encode(precipIntensityMax, forKey: "precipIntensityMax")
		}
		if precipIntensityMaxTime != nil{
			aCoder.encode(precipIntensityMaxTime, forKey: "precipIntensityMaxTime")
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
		if sunriseTime != nil{
			aCoder.encode(sunriseTime, forKey: "sunriseTime")
		}
		if sunsetTime != nil{
			aCoder.encode(sunsetTime, forKey: "sunsetTime")
		}
		if temperatureHigh != nil{
			aCoder.encode(temperatureHigh, forKey: "temperatureHigh")
		}
		if temperatureHighTime != nil{
			aCoder.encode(temperatureHighTime, forKey: "temperatureHighTime")
		}
		if temperatureLow != nil{
			aCoder.encode(temperatureLow, forKey: "temperatureLow")
		}
		if temperatureLowTime != nil{
			aCoder.encode(temperatureLowTime, forKey: "temperatureLowTime")
		}
		if temperatureMax != nil{
			aCoder.encode(temperatureMax, forKey: "temperatureMax")
		}
		if temperatureMaxTime != nil{
			aCoder.encode(temperatureMaxTime, forKey: "temperatureMaxTime")
		}
		if temperatureMin != nil{
			aCoder.encode(temperatureMin, forKey: "temperatureMin")
		}
		if temperatureMinTime != nil{
			aCoder.encode(temperatureMinTime, forKey: "temperatureMinTime")
		}
		if time != nil{
			aCoder.encode(time, forKey: "time")
		}
		if uvIndex != nil{
			aCoder.encode(uvIndex, forKey: "uvIndex")
		}
		if uvIndexTime != nil{
			aCoder.encode(uvIndexTime, forKey: "uvIndexTime")
		}
		if windBearing != nil{
			aCoder.encode(windBearing, forKey: "windBearing")
		}
		if windGust != nil{
			aCoder.encode(windGust, forKey: "windGust")
		}
		if windGustTime != nil{
			aCoder.encode(windGustTime, forKey: "windGustTime")
		}
		if windSpeed != nil{
			aCoder.encode(windSpeed, forKey: "windSpeed")
		}
		if apparentTemperature != nil{
			aCoder.encode(apparentTemperature, forKey: "apparentTemperature")
		}
		if temperature != nil{
			aCoder.encode(temperature, forKey: "temperature")
		}

	}

}
