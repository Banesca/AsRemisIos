//
//  PlaceEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 19/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class PlaceEntity: NSObject {
    
    var latitude: String?
    var longitude: String?
    var name: String?
    
    init(name: String, latitude: String, longitude: String){
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    init(originData: [String: Any]){
        print(originData)
        latitude = originData["latOrigin"] as? String
        longitude = originData["lonOrigin"] as? String
        name = originData["nameOrigin"] as? String
    }
    
    init(destinationData: [String: Any]){
        print(destinationData)
        latitude = destinationData["latDestination"] as? String
        longitude = destinationData["lonDestination"] as? String
        name = destinationData["nameDestination"] as? String
    }
    
    func toOriginJSON() -> [String: Any]{
        return [
            "latOrigin": latitude as Any,
            "lonOrigin": longitude as Any,
            "nameOrigin": name as Any
        ]
    }
    
    func toDestinationJSON() -> [String: Any]{
        return [
            "latDestination": latitude as Any,
            "lonDestination": longitude as Any,
            "nameDestination": name as Any
        ]
    }
    
}
