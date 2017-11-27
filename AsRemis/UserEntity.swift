//
//  UserEntity.swift
//  AsRemis
//
//  Created by Jorge Gutierrez on 29/9/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import Foundation

class UserEntity {
    var userName: String?
    var idVeichleAsigned: NSNumber?
    var userPass: String?
    var idUser: NSNumber?
    var userNameUser: String?
    var firstNameUser: String?
    var lastNameUser: String?
    var emailUser: String?
    var idProfileUser: NSNumber?
    var idStatusUser: String?
    var idClient: NSNumber?
    var idDriver: NSNumber?
    var idTypeAuth: NSNumber?
    var idResourceSocket: NSNumber?
    
    init(userName:String, userPass:String, idTypeAuth: NSNumber){
        self.userName = userName
        self.userPass = userPass
        self.idTypeAuth = idTypeAuth
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        userName = jsonData["emailUser"] as? String
        if let tempVehicle = jsonData["idVeichleAsigned"] as? String{
            idVeichleAsigned = NSNumber(value: Int(tempVehicle)!)
        }
        if let tempUserId = jsonData["idUser"] as? String{
            idUser = NSNumber(value: Int(tempUserId)!)
        }
        userNameUser = jsonData["emailUser"] as? String
        firstNameUser = jsonData["firstNameUser"] as? String
        lastNameUser = jsonData["lastNameUser"] as? String
        emailUser = jsonData["emailUser"] as? String
        if let tempIdProfileUser = jsonData["idProfileUser"] as? String{
            idProfileUser = NSNumber(value: Int(tempIdProfileUser)!)
        }
        idStatusUser = jsonData["idStatusUser"] as? String
        if let tempIdClient = jsonData["idClient"] as? String{
            idClient = NSNumber(value: Int(tempIdClient)!)
        }
        if let tempIdDriver = jsonData["idDriver"] as? String{
            idDriver = NSNumber(value: Int(tempIdDriver)!)
        }
        idTypeAuth = 2
        if let tempIdResourceSocket = jsonData["idResourceSocket"] as? String{
            idResourceSocket = NSNumber(value: Int(tempIdResourceSocket)!)
        }
    }
    
    func toJSON() -> [String: Any]{
        return [
            "userName": userName as Any,
            "idVeichleAsigned": idVeichleAsigned as Any,
            "userPass": userPass as Any,
            "idUser": idUser as Any,
            "userNameUser": userNameUser as Any,
            "firstNameUser": firstNameUser as Any,
            "lastNameUser": lastNameUser as Any,
            "emailUser": emailUser as Any,
            "idProfileUser": idProfileUser as Any,
            "idStatusUser": idStatusUser as Any,
            "idClient": idClient as Any,
            "idDriver": idDriver as Any,
            "idTypeAuth": idTypeAuth as Any,
            "idResourceSocket": idResourceSocket as Any
        ]
    }
    
    
    
}
