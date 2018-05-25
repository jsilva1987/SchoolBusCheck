//
//  RequestManagerMock.swift
//  SchoolBusCheckTests
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import Foundation
@testable import SchoolBusCheck

class RequestManagerMock : RequestManagerDelegate {
    
    var didComplete: ((_ response: [SchoolBus]) -> Void)?
    
    func busesRequestDidComplete(_ response: [SchoolBus]?) {
        if let response = response {
            didComplete?(response)
        }
    }
    
}
