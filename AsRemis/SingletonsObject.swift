//
//  SingletonsObject.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 17/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit
import CoreLocation

final class SingletonsObject: NSObject {
    static let sharedInstance = SingletonsObject()
    var userSelected: UserFullEntity?
    var userPosition: CLLocation?
    var appCurrentVersion: String = "0"
    
    private override init() {super.init()}
}

