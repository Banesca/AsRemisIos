//
//  ReasonEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 20/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ReasonEntity: NSObject {
    
    var idReason: NSNumber?
    var reason: String?
    
    init(reasonData: [String: Any]){
        print(reasonData)
        if let tempIdReason = reasonData["idReason"] as? String{
            idReason = NSNumber(value: Int(tempIdReason)!)
        }
        reason = reasonData["reason"] as? String
    }
    
    func toOriginJSON() -> [String: Any]{
        return [
            "idReason": idReason as Any,
            "reason": reason as Any
        ]
    }
}
