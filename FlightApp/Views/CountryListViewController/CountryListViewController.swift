//
//  CountryListViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class CountryListViewController : BaseViewController<CountryListViewModel>, UISearchControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Origin"
        _configureSearchController()
    }
    
    private func _configureSearchController() {
        let searchController = CustomSearchController()
        searchController.delegate = self
        self.navigationItem.searchController = searchController
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationItem.searchController!.searchBar.setSearch("Search")
    }
}
