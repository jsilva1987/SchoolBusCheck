//
//  RequestParser.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/24/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import Foundation

class RequestParser {
    
    static func parseRoutesResponse(_ data: Data) -> [SchoolBus]? {
        var buses: [SchoolBus] = []

        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        guard let dictionary = jsonResponse as? [String: Any] else { return nil }
        
        guard let arrayResponse = dictionary["school_buses"] as? [[String: Any]] else { return nil }
        
        for response in arrayResponse {
            let schoolBus = SchoolBus(response: response)
            buses.append(schoolBus)
        }
        
        return buses
    }
    
    static func parseBusRouteResponse(_ data: Data) -> CoordinatesList {
        var route: CoordinatesList = []
        
        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        guard let dictionary = jsonResponse as? [String: Any] else { return route }
        
        guard let stopsArray = dictionary["stops"] as? [[String: Double]] else { return route }
        
        for stop in stopsArray {
            if let lat = stop["lat"], let lng = stop["lng"] {
                route.append((lat: lat, lng: lng.isLess(than: 0) ? lng : -lng))
            }
        }
        
        return route
    }
}
