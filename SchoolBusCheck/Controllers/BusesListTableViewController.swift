//
//  ViewController.swift
//  SchoolBusCheck
//
//  Created by trink2 on 5/22/18.
//  Copyright © 2018 trink2. All rights reserved.
//

import UIKit
import SVProgressHUD

class BusesListTableViewController: UITableViewController {
    
    private var buses: [SchoolBus] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.tableView.contentOffset = .zero
                self?.tableView.layoutIfNeeded()
            }
        }
    }
    
    private var storageManager = StorageManager()
    private var requestManager: RequestManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Rutas Escolares"
        tableView.register(BusTableViewCell.nib, forCellReuseIdentifier: BusTableViewCell.identifier)
        
        requestManager = RequestManager(delegate: self)

        buses = storageManager.fetchAllBuses()
        
        if buses.isEmpty {
            SVProgressHUD.showFullScreen(withStatus: "Obteniendo las rutas...")
            requestManager.requestRoutes()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let routeViewController = segue.destination as? RouteMapViewController {
            routeViewController.schoolBus = buses[tableView.indexPathForSelectedRow!.row]
        }
    }

}

//MARK: - RequestManagerDelegate

extension BusesListTableViewController: RequestManagerDelegate {
    func busesRequestDidComplete(_ response: [SchoolBus]?) {
        
        guard let responseBuses = response else { return }
        for bus in responseBuses {
            bus.imageData = requestManager.requestBusImage(bus)
            requestManager.requestBusRoute(bus) { coordinatesList in
                bus.coordinatesList = coordinatesList
                bus.route = coordinatesList.description
                self.storageManager.saveSchoolBus(bus)
            }
        }
        
        buses = responseBuses
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
        
    }
}

//MARK: - TableView DataSource & Delegate

extension BusesListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buses.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busCell = tableView.dequeueReusableCell(withIdentifier: BusTableViewCell.identifier) as! BusTableViewCell
        busCell.setupForBus(buses[indexPath.row])
        return busCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBusRoute", sender: nil)
    }
}

