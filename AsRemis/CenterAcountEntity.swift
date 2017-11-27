//
//  CenterAcountEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class CenterAcountEntity: NSObject {
    var idCostCenter: String?
    var costCenter: String?
    
    override init(){
        super.init()
        idCostCenter = ""
        costCenter = ""
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idCostCenter = jsonData["idCostCenter"] as? String
        costCenter = jsonData["costCenter"] as? String
        
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idCostCenter": idCostCenter as Any,
            "costCenter": costCenter as Any
        ]
    }

}
