//
//  CountryListViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class AirportListViewController : BaseViewController<AirportListViewModel>, UISearchControllerDelegate, UISearchBarDelegate {
    private let _searchController = CustomSearchController()
    private let _tableView = UITableView()
    private lazy var _dataSourceProvider = AirportListDataSource(tableView: _tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        _setupView()
    }
    
    private func _setupView() {
        _configureSearchController()
        _configureTableView()
        _createObservers()
    }
    
    private func _configureSearchController() {
        let searchController = CustomSearchController()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(_closeButton))
    }
    
    private func _configureTableView() {
        self.view.addSubview(_tableView)
        
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.anchor(top: self.view.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)

        _tableView.dataSource = _dataSourceProvider
        _tableView.delegate = _dataSourceProvider
        
        _dataSourceProvider.selectRowAction = viewModel.closeViewCommand
        _dataSourceProvider.airportList = viewModel.airports.data.value
    }
    
    
    private func _createObservers() {
        viewModel.airports.data.addObserver(self, completionHandler: {
            self._dataSourceProvider.airportList = self.viewModel.airports.data.value
        })
        
        viewModel.searchAirports.data.addObserver(self, completionHandler: {
            self._dataSourceProvider.airportList = self.viewModel.searchAirports.data.value
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCommand.execute(searchText)
     }
     
     func willDismissSearchController(_ searchController: UISearchController) {
        _dataSourceProvider.airportList = viewModel.airports.data.value
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationItem.searchController!.searchBar.setSearch(viewModel.searchLabel)
    }
    
    @objc fileprivate func _closeButton() {
        viewModel.closeViewCommand.execute("")
    }
}
