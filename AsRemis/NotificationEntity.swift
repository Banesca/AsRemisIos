//
//  NotificationEntity.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 10/26/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class NotificationEntity: NSObject {

    var idNotification: NSNumber?
    var idType: NSNumber?
    var isRead: NSNumber?
    var subTitle: String?
    var title: String?
    
    init(jsonData: [String: Any]){
        print(jsonData)
        if let tempVar = jsonData["idNotification"] as? String{
            idNotification = NSNumber(value: Int(tempVar)!)
        }
        if let tempVar = jsonData["idType"] as? String{
            idType = NSNumber(value: Int(tempVar)!)
        }
        if let tempVar = jsonData["isRead"] as? String{
            isRead = NSNumber(value: Int(tempVar)!)
        }
        title = jsonData["title"] as? String
        subTitle = jsonData["subTitle"] as? String
    }
    
    func toJSON() -> [String: Any]{
        return [
            "idNotification": idNotification as Any,
            "idType": idType as Any,
            "isRead": isRead as Any,
            "subTitle": subTitle as Any,
            "title": title as Any
        ]
    }
}
