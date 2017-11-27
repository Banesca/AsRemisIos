//
//  TokenEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 18/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class TokenEntity: NSObject {
    
    var tokenFB: String?
    var idUser: NSNumber?
    var idDriver: NSNumber?
    var latVersionApp: String?
    
    override init(){
        super.init()
        tokenFB = ""
        idUser = 0
        idDriver = 0
        latVersionApp = ""
    }
    
    init(tokenFB:String, idUser:NSNumber, idDriver: NSNumber, latVersionApp: String){
        self.tokenFB = tokenFB
        self.idUser = idUser
        self.idDriver = idDriver
        self.latVersionApp = latVersionApp
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        if let tempIdUser = jsonData["idUser"] as? String{
            idUser = NSNumber(value: Int(tempIdUser)!)
        }
        if let tempIdDriver = jsonData["idDriver"] as? String{
            idDriver = NSNumber(value: Int(tempIdDriver)!)
        }
        tokenFB = jsonData["tokenFB"] as? String
        latVersionApp = jsonData["latVersionApp"] as? String
    }
    
    func toJSON() -> [String: Any]{
        return [
            "tokenFB": tokenFB as Any,
            "idUser": idUser as Any,
            "idDriver": idDriver as Any,
            "latVersionApp": latVersionApp as Any
        ]
    }
}
