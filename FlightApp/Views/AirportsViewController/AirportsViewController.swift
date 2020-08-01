//
//  AirportsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//


import UIKit

class AirportsViewController : BaseViewController<AirportsViewModel>, UISearchControllerDelegate {
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Airports"
        _configureSearchController()
        
        let airpotService : AirportWebService = DiContainer.resolve()
        
        _ = airpotService.getAvailableStations() { airportObj in self._completion(airportObj) }
    }
    
    private func _completion(_ airports: StationListObject?) {
        print(airports)
    }
    
    private func _configureSearchController() {
        let searchController = CustomSearchController()
        searchController.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.searchController!.searchBar.setSearch("Search")
    }
}


