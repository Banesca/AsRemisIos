//
//  listLiquidationDriverEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/22/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class listLiquidationDriverEntity: NSObject {
    var liquidation: String?
    var advance: String?
    var pay: String?
    var ingreso: String?
    var egreso: String?
    var ingresoProcess: String?
    
    override init(){
        super.init()
        liquidation = ""
        advance = ""
        pay = ""
        ingreso = ""
        egreso = ""
        ingresoProcess = ""
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        liquidation = jsonData["liquidation"] as? String
        advance = jsonData["liquidation"] as? String
        pay = jsonData["liquidation"] as? String
        var total = jsonData["total"] as? NSDictionary
        ingreso = total?.value(forKey: "ingreso") as? String
        egreso = total?.value(forKey: "egreso") as? String
        ingresoProcess = total?.value(forKey: "ingresoProcess") as? String
        
    }
    
}
