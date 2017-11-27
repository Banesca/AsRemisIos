//
//  UserProfileEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 19/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class UserProfileEntity: NSObject {
    var idProfile: String?
    var firstName: String?
    var lastName: String?
    var dni: String?
    var phoneNumber: String?
    var email: String?
    var idUser: NSNumber?
    var idStatusDriverTravelKf: NSNumber?
    
    init(withIdProfile idProfile: String, firstName: String, lastName: String, dni: String, phone: String, email: String, idUser: NSNumber, idStatusDriver: NSNumber){
        self.idProfile = idProfile
        self.firstName = firstName
        self.lastName = lastName
        self.dni = dni
        self.phoneNumber = phone
        self.email = email
        self.idUser = idUser
        self.idStatusDriverTravelKf = idStatusDriver
    }
    
    init(clientData: [String: Any]){
        print(clientData)
        idProfile = clientData["idClient"] as? String
        firstName = clientData["firstNameClient"] as? String
        lastName = clientData["lastNameClient"] as? String
        dni = clientData["dniClient"] as? String
        phoneNumber = clientData["phoneClient"] as? String
        email = clientData["mailClient"] as? String
        if let tempIdUser = clientData["idUser"] as? String{
            idUser = NSNumber(value: Int(tempIdUser)!)
        }
    }
    
    init(driverData: [String: Any]){
        print(driverData)
        idProfile = driverData["idClient"] as? String
        firstName = driverData["fisrtNameDriver"] as? String
        lastName = driverData["lastNameDriver"] as? String
        dni = driverData["dniDriver"] as? String
        phoneNumber = driverData["phoneNumberDriver"] as? String
        email = driverData["emailDriver"] as? String
        if let tempIdUser = driverData["idUser"] as? String{
            idUser = NSNumber(value: Int(tempIdUser)!)
        }
        if let tempIdStatusDriverTravelKf = driverData["idStatusDriverTravelKf"] as? String{
            idStatusDriverTravelKf = NSNumber(value: Int(tempIdStatusDriverTravelKf)!)
        }
    }
    
    func toClientJSON() -> [String: Any]{
        return [
            "idClient": idProfile as Any,
            "clientEntityAdd": firstName as Any,
            "fisrtNameDriver": firstName as Any,
            "lastNameClient": lastName as Any,
            "dniClient": dni as Any,
            "phoneClient": phoneNumber as Any,
            "mailClient": email as Any,
            "idUser": idUser as Any
        ]
    }
    
    func toDriverJSON() -> [String: Any]{
        return [
            "idDriver": idProfile as Any,
            "fisrtNameDriver": firstName as Any,
            "lastNameDriver": lastName as Any,
            "dniDriver": dni as Any,
            "phoneNumberDriver": phoneNumber as Any,
            "emailDriver": email as Any,
            "idUser": idUser as Any,
            "idStatusDriverTravelKf": idStatusDriverTravelKf as Any
        ]
    }
}
