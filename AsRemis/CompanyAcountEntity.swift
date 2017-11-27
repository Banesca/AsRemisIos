//
//  CompanyAcountEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class CompanyAcountEntity: NSObject {
    var idCompanyAcount: String?
    var nrAcount: String?
    
    override init(){
        super.init()
        idCompanyAcount = ""
        nrAcount = ""
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idCompanyAcount = jsonData["idCompanyAcount"] as? String
        nrAcount = jsonData["nrAcount"] as? String
        
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idCompanyAcount": idCompanyAcount as Any,
            "nrAcount": nrAcount as Any
        ]
    }

}
