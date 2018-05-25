//
//  SchoolBus.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit

class SchoolBus {
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var routeUrl: String = ""
    var imageUrl: String = ""
    var imageData: Data = Data()
    var route: String = ""
    
    var coordinatesList: CoordinatesList = []
    var coordinates: [Coordinate] = []
    
    convenience init(response: [String: Any]) {
        self.init()
        id = response["id"] as! Int
        name = response["name"] as! String
        description = response["description"] as! String
        imageUrl = response["img_url"] as! String
        routeUrl = response["stops_url"] as! String
    }

    /**
     Helper method to parse the stored coordinates into the tuple type.
     */
    func listFromCoordinates() -> CoordinatesList {
        var list: CoordinatesList = []
        for coordinate in coordinates {
            list.append((lat: coordinate.lat, lng: coordinate.lng))
        }
        return list
    }
}
