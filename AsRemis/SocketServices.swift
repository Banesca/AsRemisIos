//
//  SocketServices.swift
//  AsRemis
//
//  Created by Luis Fernando Bustos Ramírez on 10/23/17.
//  Copyright © 2017 Apreciasoft. All rights reserved.
//

import UIKit
import SocketIO

class SocketServices: NSObject {
    func prepareSocket(_ ip:String, userId:NSNumber, urlBase: String){
        let url = "ws://\(ip):3389?idUser=\(userId)&uri=\(urlBase)"
        let socket = SocketIOClient(socketURL: URL(string: url)!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("currentAmount") {data, ack in
            if let cur = data[0] as? Double {
                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                    socket.emit("update", ["amount": cur + 2.50])
                }
                
                ack.with("Got your currentAmount", "dude")
            }
        }
        
        socket.connect()
    }
}
