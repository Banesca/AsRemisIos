//
//  TravelEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 19/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class TravelEntity: NSObject {
    var idUserCompanyKf: NSNumber?
    var idClientKf: String?
    var isTravelComany: Bool?
    var idTypeVehicle: String?
    var origin: PlaceEntity?
    var destination: PlaceEntity?
    var dateTravel: String?
    var isTravelSendMovil: Bool?
    var airlineCompany: String?
    var flyNumber: String?
    var hoursAribo: String?
    var terminal: String?
    
    override init(){
        super.init()
    }
    
    init(travelData: [String: Any]){
        print(travelData)
        if let tempIdUserCompanyKf = travelData["idUserCompanyKf"] as? String{
            idUserCompanyKf = NSNumber(value: Int(tempIdUserCompanyKf)!)
        }
        idClientKf = travelData["idClientKf"] as? String
        if let tempIsTravelComany = travelData["isTravelComany"] as? String{
            isTravelComany = Bool(tempIsTravelComany)!
        }
        idTypeVehicle = travelData["idTypeVehicle"] as? String
        origin = PlaceEntity.init(originData: ["lonOrigin":travelData["lonOrigin"] ?? "",
                                                "latOrigin":travelData["latOrigin"] ?? "",
                                                "nameOrigin":travelData["nameOrigin"] ?? ""])
        
        destination = PlaceEntity.init(destinationData: ["lonDestination":travelData["lonDestination"] ?? "",
                                                         "latDestination":travelData["latDestination"] ?? "",
                                                         "nameDestination":travelData["nameDestination"] ?? ""])
        dateTravel = travelData["dateTravel"] as? String
        if let tempIsTravelSendMovil = travelData["isTravelSendMovil"] as? String{
            isTravelSendMovil = Bool(tempIsTravelSendMovil)
        }
    }
    
    func toOriginJSON() -> [String: Any]{
        return [
            "idUserCompanyKf": idUserCompanyKf as Any,
            "idClientKf": idClientKf as Any,
            "isTravelComany": isTravelComany as Any,
            "idTypeVehicle": idTypeVehicle as Any,
            "latOrigin": origin?.latitude as Any,
            "lonOrigin": origin?.longitude as Any,
            "nameOrigin": origin?.name as Any,
            "latDestination": destination?.latitude as Any,
            "lonDestination": destination?.longitude as Any,
            "nameDestination": destination?.name as Any,
            "dateTravel": dateTravel as Any,
            "isTravelSendMovil": isTravelSendMovil as Any
        ]
    }
    
    func toTripJson() -> [String: Any]{
        return [
            "dateTravel": dateTravel as Any,
            "destination": [
                "latDestination": destination?.latitude as Any,
                "lonDestination": destination?.longitude as Any,
                "nameDestination": destination?.name as Any
                ],
            "idClientKf": idClientKf as Any,
            "idTypeVehicle": idTypeVehicle as Any,
            "isTravelComany": isTravelComany as Any,
            "origin": [
                "latOrigin": origin?.latitude as Any,
                "lonOrigin": origin?.longitude as Any,
                "nameOrigin": origin?.name as Any
            ],
            "airlineCompany": airlineCompany as Any,
            "flyNumber": flyNumber as Any,
            "hoursAribo": hoursAribo as Any,
            "idUserCompanyKf": idUserCompanyKf as Any,
            "isTravelSendMovil": isTravelSendMovil as Any,
            "terminal": terminal as Any
        ]
    }
    
    
}
