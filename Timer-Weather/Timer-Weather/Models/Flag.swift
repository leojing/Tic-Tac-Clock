//
//	Flag.swift
//
//	Create by Jing Luo on 20/4/2018
//	Copyright © 2018. All rights reserved.
//

import Foundation 

class Flag: Codable {
    let icon : String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

//    var isdstations : [String]?
//    var sources : [String]?
//    var units : String?
//
//
//    class func newInstance(map: Map) -> Mappable?{
//        return Flag()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        isdstations <- map["isd-stations"]
//        sources <- map["sources"]
//        units <- map["units"]
//
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         isdstations = aDecoder.decodeObject(forKey: "isd-stations") as? [String]
//         sources = aDecoder.decodeObject(forKey: "sources") as? [String]
//         units = aDecoder.decodeObject(forKey: "units") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if isdstations != nil{
//            aCoder.encode(isdstations, forKey: "isd-stations")
//        }
//        if sources != nil{
//            aCoder.encode(sources, forKey: "sources")
//        }
//        if units != nil{
//            aCoder.encode(units, forKey: "units")
//        }
//
//    }
//
//}
