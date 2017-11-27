//
//  ModelByBrand.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ModelByBrand: NSObject {
    var idVehicleModel: String?
    var idVehicleBrandAsigned: String?
    var nameVehicleModel: String?
    var idStatusVehicleModel: String?
    var idStatusVehicleBrand: String?
    var nameVehicleBrand: String?
    
    override init(){
        super.init()
        idVehicleModel = ""
        idVehicleBrandAsigned = ""
        nameVehicleModel = ""
        idStatusVehicleModel = ""
        idStatusVehicleBrand = ""
        nameVehicleBrand = ""
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idVehicleModel = jsonData["idVehicleModel"] as? String
        idVehicleBrandAsigned = jsonData["idVehicleBrandAsigned"] as? String
        nameVehicleModel = jsonData["nameVehicleModel"] as? String
        idStatusVehicleModel = jsonData["idStatusVehicleModel"] as? String
        idStatusVehicleBrand = jsonData["idStatusVehicleBrand"] as? String
        nameVehicleBrand = jsonData["nameVehicleBrand"] as? String
        
    }
    
}
