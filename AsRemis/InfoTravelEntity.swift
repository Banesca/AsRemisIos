//
//  InfoTravelEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 20/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class InfoTravelEntity: NSObject {
    
    var idTravel: NSNumber?
    var MultiDestinationDesc: String?
    var idSatatusTravel: NSNumber?
    var phoneNumber: String?
    var isProcesCurrentAcount: NSNumber?
    var nameStatusTravel: String?
    var origin: PlaceEntity?
    var distanceLabel: String?
    var destination: PlaceEntity?
    var amountCalculate: String?
    var totalAmount: String?
    var amountGps: String?
    var codTravel: String?
    var nameOrigin: String?
    var pasajero: String?
    var observationFromDriver: String?
    var nameDestination: String?
    var driver: String?
    var client: String?
    var idClientKf: NSNumber?
    var classColorTwo: String?
    var isTravelMultiOrigin: String?
    var isMultiDestination: String?
    var OriginMultiple1: PlaceEntity?
    var OriginMultiple2: PlaceEntity?
    var OriginMultiple3: PlaceEntity?
    var OriginMultiple4: PlaceEntity?
    var MultiDestination: String?
    var idUserClient: Bool?
    var idUserDriver: Bool?
    var isRoundTrip: Bool?
    var isTravelSendMovil: Bool?
    var priceDitanceCompany: NSNumber?
    var priceMinSleepCompany: NSNumber?
    var priceReturn: NSNumber?
    var priceHourDriverMultiLan: NSNumber?
    var priceContract: NSNumber?
    var priceTravelSms: NSNumber?
    var benefitsFromKm: NSNumber?
    var benefitsToKm: NSNumber?
    var benefitsPreceKm: NSNumber?
    var isTravelComany: NSNumber?
    var isAceptReservationByDriver: NSNumber?
    var benefitsPerKm: NSNumber?
    var amountOriginPac: NSNumber?
    var dateTravel: String?
    var domain: String?
    var isPaymentCash: NSNumber?
    var distanceSave: NSNumber?
    var priceMinTravel: NSNumber?
    
    init(travelData: [String: Any]){
        print(travelData)
        if let tempIdTravel = travelData["idTravel"] as? String{
            idTravel = NSNumber(value: Int(tempIdTravel)!)
        }
        MultiDestinationDesc = travelData["MultiDestinationDesc"] as? String
        if let tempStatus = travelData["idSatatusTravel"] as? String{
            idSatatusTravel = NSNumber(value: Int(tempStatus)!)
        }
        phoneNumber = travelData["phoneNumber"] as? String
        if let tempIsProcess = travelData["isProcesCurrentAcount"] as? String{
            isProcesCurrentAcount = NSNumber(value: Int(tempIsProcess)!)
        }
        nameStatusTravel = travelData["nameStatusTravel"] as? String
        origin = PlaceEntity.init(originData: ["lonOrigin":travelData["lonOrigin"] ?? "",
                                                "latOrigin":travelData["latOrigin"] ?? "",
                                                "nameOrigin":""])
        distanceLabel = travelData["distanceLabel"] as? String
        destination = PlaceEntity.init(destinationData: ["lonDestination":travelData["lonDestination"] ?? "",
                                                         "latDestination":travelData["latDestination"] ?? "",
                                                         "nameDestination":""])
        amountCalculate = travelData["amountCalculate"] as? String
        totalAmount = travelData["totalAmount"] as? String
        amountGps = travelData["amountGps"] as? String
        codTravel = travelData["codTravel"] as? String
        nameOrigin = travelData["nameOrigin"] as? String
        pasajero = travelData["pasajero"] as? String
        observationFromDriver = travelData["observationFromDriver"] as? String
        nameDestination = travelData["nameDestination"] as? String
        driver = travelData["driver"] as? String
        client = travelData["client"] as? String
        if let tempIdClientKf = travelData["idClientKf"] as? String{
            idClientKf = NSNumber(value: Int(tempIdClientKf)!)
        }
        classColorTwo = travelData["classColorTwo"] as? String
        isTravelMultiOrigin = travelData["isTravelMultiOrigin"] as? String
        isMultiDestination = travelData["isMultiDestination"] as? String
        OriginMultiple1 = PlaceEntity.init(originData: ["lonOrigin":travelData["OriginMultipleLon1"] ?? "",
                                                        "latOrigin":travelData["OriginMultipleLat1"] ?? "",
                                                        "nameOrigin":travelData["OriginMultipleDesc1"] ?? ""])
        OriginMultiple2 = PlaceEntity.init(originData: ["lonOrigin":travelData["OriginMultipleLon2"] ?? "",
                                                        "latOrigin":travelData["OriginMultipleLat2"] ?? "",
                                                        "nameOrigin":travelData["OriginMultipleDesc2"] ?? ""])
        OriginMultiple3 = PlaceEntity.init(originData: ["lonOrigin":travelData["OriginMultipleLon3"] ?? "",
                                                        "latOrigin":travelData["OriginMultipleLat3"] ?? "",
                                                        "nameOrigin":travelData["OriginMultipleDesc3"] ?? ""])
        OriginMultiple4 = PlaceEntity.init(originData: ["lonOrigin":travelData["OriginMultipleLon4"] ?? "",
                                                        "latOrigin":travelData["OriginMultipleLat4"] ?? "",
                                                        "nameOrigin":travelData["OriginMultipleDesc4"] ?? ""])
        MultiDestination = travelData["MultiDestination"] as? String
        if let tempIdUserClient = travelData["idUserClient"] as? String{
            idUserClient = Bool(tempIdUserClient)
        }
        if let tempIdUserDriver = travelData["idUserDriver"] as? String{
            idUserDriver = Bool(tempIdUserDriver)
        }
        if let tempIsRoundTrip = travelData["isRoundTrip"] as? String{
            isRoundTrip = Bool(tempIsRoundTrip)
        }
        if let tempIsTravelSendMovil = travelData["isTravelSendMovil"] as? String{
            isTravelSendMovil = Bool(tempIsTravelSendMovil)
        }
        if let tempPriceDitanceCompany = travelData["priceDitanceCompany"] as? String{
            priceDitanceCompany = NSNumber(value: Double(tempPriceDitanceCompany)!)
        }
        if let tempPriceMinSleepCompany = travelData["priceMinSleepCompany"] as? String{
            priceMinSleepCompany = NSNumber(value: Double(tempPriceMinSleepCompany)!)
        }
        if let tempPriceReturn = travelData["priceReturn"] as? String{
            priceReturn = NSNumber(value: Double(tempPriceReturn)!)
        }
        if let tempPriceHourDriverMultiLan = travelData["priceHourDriverMultiLan"] as? String{
            priceHourDriverMultiLan = NSNumber(value: Double(tempPriceHourDriverMultiLan)!)
        }
        if let tempPriceContract = travelData["priceContract"] as? String{
            priceContract = NSNumber(value: Double(tempPriceContract)!)
        }
        if let tempPriceTravelSms = travelData["priceTravelSms"] as? String{
            priceTravelSms = NSNumber(value: Double(tempPriceTravelSms)!)
        }
        if let tempBenefitsFromKm = travelData["benefitsFromKm"] as? String{
            benefitsFromKm = NSNumber(value: Double(tempBenefitsFromKm)!)
        }
        if let tempBenefitsToKm = travelData["benefitsToKm"] as? String{
            benefitsToKm = NSNumber(value: Double(tempBenefitsToKm)!)
        }
        if let tempBenefitsPreceKm = travelData["benefitsPreceKm"] as? String{
            benefitsPreceKm = NSNumber(value: Int(tempBenefitsPreceKm)!)
        }
        if let tempIsTravelComany = travelData["isTravelComany"] as? String{
            isTravelComany = NSNumber(value: Int(tempIsTravelComany)!)
        }
        if let tempIsAceptReservationByDriver = travelData["isAceptReservationByDriver"] as? String{
            isAceptReservationByDriver = NSNumber(value: Int(tempIsAceptReservationByDriver)!)
        }
        if let tempBenefitsPerKm = travelData["benefitsPerKm"] as? String{
            benefitsPerKm = NSNumber(value: Int(tempBenefitsPerKm)!)
        }
        if let tempAmountOriginPac = travelData["amountOriginPac"] as? String{
            amountOriginPac = NSNumber(value: Double(tempAmountOriginPac)!)
        }
        dateTravel = travelData["dateTravel"] as? String
        domain = travelData["domain"] as? String
        if let tempIsPaymentCash = travelData["isPaymentCash"] as? String{
            isPaymentCash = NSNumber(value: Int(tempIsPaymentCash)!)
        }
        if let tempDistanceSave = travelData["distanceSave"] as? String{
            distanceSave = NSNumber(value: Double(tempDistanceSave)!)
        }
        if let tempPriceMinTravel = travelData["priceMinTravel"] as? String{
            priceMinTravel = NSNumber(value: Int(tempPriceMinTravel)!)
        }
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idTravel": idTravel as Any,
            "MultiDestinationDesc": MultiDestinationDesc as Any,
            "idSatatusTravel": idSatatusTravel as Any,
            "phoneNumber": phoneNumber as Any,
            "isProcesCurrentAcount": isProcesCurrentAcount as Any,
            "nameStatusTravel": nameStatusTravel as Any,
            "lonOrigin": origin?.longitude as Any,
            "latOrigin": origin?.latitude as Any,
            "distanceLabel": distanceLabel as Any,
            "lonDestination": destination?.longitude as Any,
            "latDestination": destination?.latitude as Any,
            "amountCalculate": amountCalculate as Any,
            "totalAmount": totalAmount as Any,
            "amountGps": amountGps as Any,
            "codTravel": codTravel as Any,
            "nameOrigin": nameOrigin as Any,
            "pasajero": pasajero as Any,
            "observationFromDriver": observationFromDriver as Any,
            "nameDestination": nameDestination as Any,
            "driver": driver as Any,
            "client": client as Any,
            "idClientKf": idClientKf as Any,
            "classColorTwo": classColorTwo as Any,
            "isTravelMultiOrigin": isTravelMultiOrigin as Any,
            "isMultiDestination": isMultiDestination as Any,
            "OriginMultipleDesc1": OriginMultiple1?.name as Any,
            "OriginMultipleLat1": OriginMultiple1?.latitude as Any,
            "OriginMultipleLon1": OriginMultiple1?.longitude as Any,
            "OriginMultipleDesc2": OriginMultiple2?.name as Any,
            "OriginMultipleLat2": OriginMultiple2?.latitude as Any,
            "OriginMultipleLon2": OriginMultiple2?.longitude as Any,
            "OriginMultipleDesc3": OriginMultiple3?.name as Any,
            "OriginMultipleLat3": OriginMultiple3?.latitude as Any,
            "OriginMultipleLon3": OriginMultiple3?.longitude as Any,
            "OriginMultipleDesc4": OriginMultiple4?.name as Any,
            "OriginMultipleLat4": OriginMultiple4?.latitude as Any,
            "OriginMultipleLon4": OriginMultiple4?.longitude as Any,
            "MultiDestination": MultiDestination as Any,
            "idUserClient": idUserClient as Any,
            "idUserDriver": idUserDriver as Any,
            "isRoundTrip": isRoundTrip as Any,
            "isTravelSendMovil": isTravelSendMovil as Any,
            "priceDitanceCompany": priceDitanceCompany as Any,
            "priceMinSleepCompany": priceMinSleepCompany as Any,
            "priceReturn": priceReturn as Any,
            "priceHourDriverMultiLan": priceHourDriverMultiLan as Any,
            "priceContract": priceContract as Any,
            "priceTravelSms": priceTravelSms as Any,
            "benefitsFromKm": benefitsFromKm as Any,
            "benefitsToKm": benefitsToKm as Any,
            "benefitsPreceKm": benefitsPreceKm as Any,
            "isTravelComany": isTravelComany as Any,
            "isAceptReservationByDriver": isAceptReservationByDriver as Any,
            "benefitsPerKm": benefitsPerKm as Any,
            "amountOriginPac": amountOriginPac as Any,
            "dateTravel": dateTravel as Any,
            "domain": domain as Any,
            "isPaymentCash": isPaymentCash as Any,
            "distanceSave": distanceSave as Any,
            "priceMinTravel": priceMinTravel as Any
        ]
    }
}
