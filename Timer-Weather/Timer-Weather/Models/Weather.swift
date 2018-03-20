//
//	Weather.swift
//
//	Create by Jing Luo on 26/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Weather : NSObject, NSCoding, Mappable{

	var currently : Currently?
	var daily : Daily?
	var flags : Flag?
	var hourly : Daily?
	var latitude : Float?
	var longitude : Float?
	var offset : Int?
	var timezone : String?


	class func newInstance(map: Map) -> Mappable?{
		return Weather()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		currently <- map["currently"]
		daily <- map["daily"]
		flags <- map["flags"]
		hourly <- map["hourly"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		offset <- map["offset"]
		timezone <- map["timezone"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currently = aDecoder.decodeObject(forKey: "currently") as? Currently
         daily = aDecoder.decodeObject(forKey: "daily") as? Daily
         flags = aDecoder.decodeObject(forKey: "flags") as? Flag
         hourly = aDecoder.decodeObject(forKey: "hourly") as? Daily
         latitude = aDecoder.decodeObject(forKey: "latitude") as? Float
         longitude = aDecoder.decodeObject(forKey: "longitude") as? Float
         offset = aDecoder.decodeObject(forKey: "offset") as? Int
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if currently != nil{
			aCoder.encode(currently, forKey: "currently")
		}
		if daily != nil{
			aCoder.encode(daily, forKey: "daily")
		}
		if flags != nil{
			aCoder.encode(flags, forKey: "flags")
		}
		if hourly != nil{
			aCoder.encode(hourly, forKey: "hourly")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if offset != nil{
			aCoder.encode(offset, forKey: "offset")
		}
		if timezone != nil{
			aCoder.encode(timezone, forKey: "timezone")
		}

	}

}
