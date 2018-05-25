//
//  RouteMapViewController.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteMapViewController: UIViewController {
    
    var schoolBus: SchoolBus!
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var detailsViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = schoolBus.name
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: 4.678737, longitude: -74.066001, zoom: 10.0)

        /*
         Note: There is a sync issue when retrieving the Coordinates information from the DataBase.
         On save, the SchoolBus object passed to this ViewController contains a coordinatesList element but nothing on the coordinates one.
         On fetch, the SchoolBus object does contain the coordinates, but not the coordinatesList since this element is not being stored.
         Hence, this small check when loading the mapView.
        */
        if !schoolBus.coordinatesList.isEmpty {
            loadMapView(schoolBus.coordinatesList)
        } else {
            loadMapView(schoolBus.listFromCoordinates())
        }
        
        nameLabel.text = schoolBus.name
        descriptionLabel.text = schoolBus.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        detailsViewHeight.constant = 100
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.detailsStackView.isHidden = false
        }
    }
    
    func loadMapView(_ route: CoordinatesList) {
        
        guard let routeStart = route.first, let routeFinish = route.last else { return }
        
        let startMarker = GMSMarker()
        startMarker.position = CLLocationCoordinate2D(latitude: routeStart.lat, longitude: routeStart.lng)
        startMarker.icon = UIImage(data: schoolBus.imageData, scale: 3.5)
        startMarker.title = "Inicio"
        startMarker.map = mapView
        
        let finishMarker = GMSMarker()
        finishMarker.position = CLLocationCoordinate2D(latitude: routeFinish.lat, longitude: routeFinish.lng)
        finishMarker.icon = UIImage(data: schoolBus.imageData, scale: 3.5)
        finishMarker.title = "Fin"
        finishMarker.map = mapView
        
        let path = GMSMutablePath()
        for location in route {
            path.add(CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng))
        }
        
        let line = GMSPolyline(path: path)
        line.strokeColor = .red
        line.map = mapView
        
        let bounds = GMSCoordinateBounds().includingPath(path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 80))
    }

}
