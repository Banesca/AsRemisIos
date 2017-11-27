//
//  FleetTypeEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class FleetTypeEntity: NSObject {
    var idVehicleType: String?
    var vehiclenType: String?
    var vehicleMaxPeople: String?
    var vehiclePriceKm: String?
    var vehiclePriceHour: String?
    var vehicleDescription: String?
    var idVeichleBrandAsigned : String?
    var idVehicleModelAsigned : String?
    var idVehiclenTypeAsigned : String?
    var domain : String?
    
    override init(){
        super.init()
        idVehicleType = ""
        vehiclenType = ""
        vehicleMaxPeople = ""
        vehiclePriceKm = ""
        vehiclePriceHour = ""
        vehicleDescription = ""
    }
    
    init(brand:String, model:String, type:String, domainS:String){
        idVeichleBrandAsigned = brand
        idVehicleModelAsigned = model
        idVehiclenTypeAsigned = type
        domain = domainS
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idVehicleType = jsonData["idVehicleType"] as? String
        vehiclenType = jsonData["vehiclenType"] as? String
        vehicleMaxPeople = jsonData["vehicleMaxPeople"] as? String
        vehiclePriceKm = jsonData["vehiclePriceKm"] as? String
        vehiclePriceHour = jsonData["vehiclePriceHour"] as? String
        vehicleDescription = jsonData["vehicleDescription"] as? String
        
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idVeichleBrandAsigned": idVeichleBrandAsigned as Any,
            "idVehicleModelAsigned": idVehicleModelAsigned as Any,
            "idVehiclenTypeAsigned": idVehiclenTypeAsigned as Any,
            "domain": domain as Any
        ]
    }

}
