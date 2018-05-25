//
//  BusTableViewCell.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit

class BusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var busLogoImageView: UIImageView!
    @IBOutlet weak var busName: UILabel!
    @IBOutlet weak var busDescription: UILabel!

    func setupForBus(_ bus: SchoolBus) {
        busLogoImageView.image = UIImage(data: bus.imageData)
        busName.text = bus.name
        busDescription.text = bus.description
    }
    
    //MARK: - Utils
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
