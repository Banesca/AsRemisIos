//
//  UserFullEntity.swift
//  AsRemis
//
//  Created by Luis F. Bustos Ramirez on 17/10/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit

class UserFullEntity: NSObject {
    var user: UserEntity?
    var driver: UserProfileEntity?
    var client: UserProfileEntity?
    var params: [ParamEntity]?
    var vehicleType: VehicleTypeEntity?
    var currentTravel: CurrentTravelEntity?
    
    
    init(withUser user:UserEntity) {
        self.user = user
    }
}
