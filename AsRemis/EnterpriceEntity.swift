//
//  EnterpriceEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 11/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class EnterpriceEntity: NSObject {
    var idClientKf: String?
    var idCompanyClient: String?
    var nameClientCompany: String?
    var numberCompany: String?
    
    override init(){
        super.init()
        idClientKf = ""
        idCompanyClient = ""
        nameClientCompany = ""
        numberCompany = ""
    }
    
    init(jsonData: [String: Any]){
        print(jsonData)
        idClientKf = jsonData["idClientKf"] as? String
        idCompanyClient = jsonData["idCompanyClient"] as? String
        nameClientCompany = jsonData["nameClientCompany"] as? String
        numberCompany = jsonData["numberCompany"] as? String
        
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idClientKf": idClientKf as Any,
            "idCompanyClient": idCompanyClient as Any,
            "nameClientCompany": nameClientCompany as Any,
            "numberCompany": numberCompany as Any
        ]
    }

}
