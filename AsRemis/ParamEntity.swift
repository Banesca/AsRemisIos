//
//  ParamEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 17/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ParamEntity: NSObject {
    var idParam: NSNumber?
    var value: String?
    var descriptionParam: String?
    
    init(jsonData: [String: Any]){
        print(jsonData)
        if let tempIdParam = jsonData["idParam"] as? String{
            idParam = NSNumber(value: Int(tempIdParam)!)
        }
        value = jsonData["value"] as? String
        descriptionParam = jsonData["description"] as? String
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idParam": idParam as Any,
            "value": value as Any,
            "description": descriptionParam as Any
        ]
    }
}
