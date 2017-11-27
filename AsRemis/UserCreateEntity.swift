//
//  UserCreateEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 10/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class UserCreateEntity: NSObject {
    var firtName: String?
    var nrDriver: String?
    var lastName: String?
    var mail: String?
    var pass: String?
    var idType: NSNumber?
    var idCompanyAcount: NSNumber?
    var phone: String?
    var idCostCenter: NSNumber?
    var idCompanyKf: NSNumber?
    var isVehicleProvider: NSNumber?
    var isRequestMobil: NSNumber?
    
    
    init(clientWith name:String, lastName: String, phone: String, email: String, password: String){
        self.mail = email
        self.firtName = name
        self.lastName = lastName
        self.phone = phone
        self.pass = password
        self.idType = 1
    }
    
    init(driverWith name:String, nrDriver: String, phone: String, email: String, password: String){
        self.mail = email
        self.firtName = name
        self.nrDriver = nrDriver
        self.phone = phone
        self.pass = password
        self.idType = 2
    
    }
    
    init(clientData: [String: Any]){
        print(clientData)
        firtName = clientData["firtNameClient"] as? String
        lastName = clientData["lastNameClient"] as? String
        mail = clientData["mailClient"] as? String
        pass = clientData["passClient"] as? String
        if let tempIdType = clientData["idTypeClient"] as? String{
            idType = NSNumber(value: Int(tempIdType)!)
        }
        if let tempIdCompanyAcount = clientData["idCompanyAcount"] as? String{
            idCompanyAcount = NSNumber(value: Int(tempIdCompanyAcount)!)
        }
        phone = clientData["phone"] as? String
        if let tempIdCostCenter = clientData["idCostCenter"] as? String{
            idCostCenter = NSNumber(value: Int(tempIdCostCenter)!)
        }
        if let tempIdCompanyKf = clientData["idCompanyKf"] as? String{
            idCompanyKf = NSNumber(value: Int(tempIdCompanyKf)!)
        }
    }
    
    func toClientJSON() -> [String: Any]{
        return [
            "firtNameClient": firtName as Any,
            "lastNameClient": lastName as Any,
            "mailClient": mail as Any,
            "passClient": pass as Any,
            "idTypeClient": idType as Any,
            "idCompanyAcount": idCompanyAcount as Any,
            "phone": phone as Any,
            "idCostCenter": idCostCenter as Any,
            "idCompanyKf": idCompanyKf as Any
        ]
    }
    
    init(driverData: [String: Any]){
        print(driverData)
        firtName = driverData["fisrtNameDriver"] as? String
        nrDriver = driverData["nrDriver"] as? String
        mail = driverData["emailDriver"] as? String
        pass = driverData["passDriver"] as? String
        phone = driverData["phoneNumberDriver"] as? String
        if let tempIsVehicleProvider = driverData["isVehicleProvider"] as? String{
            isVehicleProvider = NSNumber(value: Int(tempIsVehicleProvider)!)
        }
        if let tempIsRequestMobil = driverData["isRequestMobil"] as? String{
            isRequestMobil = NSNumber(value: Int(tempIsRequestMobil)!)
        }
    }
    
    
    func toDriverJSON() -> [String: Any]{
        return [
            "fisrtNameDriver": firtName as Any,
            "nrDriver": nrDriver as Any,
            "emailDriver": mail as Any,
            "passDriver": pass as Any,
            "phoneNumberDriver": phone as Any,
            "isVehicleProvider": isVehicleProvider as Any,
            "isRequestMobil": isRequestMobil as Any
        ]
    }
}
