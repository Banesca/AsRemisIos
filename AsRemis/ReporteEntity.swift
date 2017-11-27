//
//  ReporteEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 18/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class ReporteEntity: NSObject {
    
    var userId: NSNumber?
    var fullName: String?
    var correo: String?
    var correo2: String?
    var reason: String?
    var company: String?
    var message: String?
    var isTravelSendMovil: NSNumber?

    init(userId: NSNumber, fullName: String, correo: String, correo2: String, reason: String, company: String, message: String, isTravelSendMovil: NSNumber) {
        self.userId = userId
        self.fullName = fullName
        self.correo = correo
        self.correo2 = correo2
        self.reason = reason
        self.company = company
        self.message = message
        self.isTravelSendMovil = isTravelSendMovil
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        if let tempIdUser = jsonData["userId"] as? String{
            userId = NSNumber(value: Int(tempIdUser)!)
        }
        fullName = jsonData["fullName"] as? String
        correo = jsonData["correo"] as? String
        correo2 = jsonData["correo2"] as? String
        reason = jsonData["reason"] as? String
        company = jsonData["company"] as? String
        message = jsonData["message"] as? String
        if let tempIsTravelSendMovil = jsonData["isTravelSendMovil"] as? String{
            isTravelSendMovil = NSNumber(value: Int(tempIsTravelSendMovil)!)
        }
    }
    
    func toJSON() -> [String: Any]{
        return [
            "userId": userId as Any,
            "fullName": fullName as Any,
            "correo": correo as Any,
            "correo2": correo2 as Any,
            "reason": reason as Any,
            "company": company as Any,
            "message": message as Any,
            "isTravelSendMovil": isTravelSendMovil as Any
        ]
    }
}
