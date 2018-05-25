//
//  RequestManager.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit

typealias CoordinatesList = [(lat: Double, lng: Double)]

protocol RequestManagerDelegate {
    func busesRequestDidComplete(_ response: [SchoolBus]?)
}

class RequestManager: NSObject {
    
    private let requestEndpoint = "https://api.myjson.com/bins/10yg1t"
    
    var delegate: RequestManagerDelegate?
    
    init(delegate: RequestManagerDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
    
    func requestRoutes() {
        guard let url = URL(string: requestEndpoint) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {
                self.delegate?.busesRequestDidComplete(nil)
                return
            }
            
            self.delegate?.busesRequestDidComplete(RequestParser.parseRoutesResponse(data))
        }
        
        task.resume()
    }
    
    func requestBusRoute(_ bus: SchoolBus, completionBlock: ((CoordinatesList) -> Void)? = nil) {
        guard let url = URL(string: bus.routeUrl) else { return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            completionBlock?(RequestParser.parseBusRouteResponse(data))
        }
        
        task.resume()
    }

    func requestBusImage(_ bus: SchoolBus) -> Data {
        var imageData = Data()
        
        guard let url = URL(string: bus.imageUrl) else { return imageData }
        
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            print("error when downloading image")
        }
        
        return imageData
    }
}
