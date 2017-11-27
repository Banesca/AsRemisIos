//
//  BrandEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/22/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class BrandEntity: NSObject {
    var idVehicleBrand: String?
    var nameVehicleBrand: String?
    var idStatusVehicleBrand: NSNumber?
    var dateCreatedVehicleBrand: String?
    var idVehicleTypeKf: NSNumber?
    var total: NSNumber?
    
    override init(){
        super.init()
        idVehicleBrand = ""
        nameVehicleBrand = ""
        idStatusVehicleBrand = 0
        dateCreatedVehicleBrand = ""
        idVehicleTypeKf = 0
        total = 0
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idVehicleBrand = jsonData["idVehicleBrand"] as? String
        nameVehicleBrand = jsonData["nameVehicleBrand"] as? String
        if let tempVar = jsonData["idStatusVehicleBrand"] as? String{
            idStatusVehicleBrand = NSNumber(value: Int(tempVar)!)
        }
        dateCreatedVehicleBrand = jsonData["dateCreatedVehicleBrand"] as? String
        if let tempVar = jsonData["idVehicleTypeKf"] as? String{
            idVehicleTypeKf = NSNumber(value: Int(tempVar)!)
        }
        if let tempVar = jsonData["total"] as? String{
            total = NSNumber(value: Int(tempVar)!)
        }
        
    }
    
}
