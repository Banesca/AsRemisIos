//
//  VehicleTYpeEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 17/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class VehicleTypeEntity: NSObject {
    var idVehicleType: NSNumber = 0
    var vehiclenType: String = ""
    
    init(jsonData: [String: Any]){
        print(jsonData)
        if let tempIdVehicleType = jsonData["idVehicleType"] as? String{
            idVehicleType = NSNumber(value: Int(tempIdVehicleType)!)
        }
        vehiclenType = jsonData["vehiclenType"] as! String
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idVehicleType": idVehicleType as Any,
            "vehiclenType": vehiclenType as Any
        ]
    }
}
