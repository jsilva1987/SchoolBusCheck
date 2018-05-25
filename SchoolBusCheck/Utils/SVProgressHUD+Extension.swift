//
//  SVProgressHUD+Extension.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/24/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {
    
    static func showFullScreen(withStatus status: String) {
        SVProgressHUD.setMinimumSize(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        SVProgressHUD.setFont(UIFont(name: "Montserrat-Regular", size: 14)!)
        SVProgressHUD.setBackgroundColor(UIColor(red: 1, green: 0.97, blue: 0.91, alpha: 1))
        SVProgressHUD.setForegroundColor(.black)
        SVProgressHUD.setCornerRadius(0)
        SVProgressHUD.show(withStatus: status)
    }
    
}
