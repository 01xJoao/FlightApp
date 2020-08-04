//
//  AirportsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//


import UIKit
import LBTATools
import Foundation

class AirportsViewController : BaseViewController<AirportsViewModel>, UISearchControllerDelegate, UISearchBarDelegate {
    private let _searchController = CustomSearchController()
    private let _tableView = UITableView()
    private lazy var _dataSourceProvider = AirportDataSource(tableView: _tableView)
    private var _activityIndicatorView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.airportsTitleLabel
        _setupView()
    }
    
    private func _setupView() {
        _configureSearchController()
        _configureTableView()
        _configureActivityView()
        _createObservers()
    }
    
    private func _configureSearchController() {
        let searchController = CustomSearchController()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }

    private func _configureTableView() {
        self.view.addSubview(_tableView)
        
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.anchor(top: self.view.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)

        _tableView.dataSource = _dataSourceProvider
        _tableView.delegate = _dataSourceProvider
    }
    
    private func _configureActivityView() {
        _activityIndicatorView = createActivityIndicatory(view: self.view)
        
        viewModel.isBusy.addObserver(self, completionHandler: {
            if(self.viewModel.isBusy.value){
                self._activityIndicatorView?.startAnimating()
            } else {
                self._activityIndicatorView?.stopAnimating()
            }
        })
    }
    
    private func _createObservers() {
        viewModel.airports.data.addObserver(self, completionHandler: {
            self._dataSourceProvider.airports = self.viewModel.airports.data.value
        })
        
        viewModel.searchAirports.data.addObserver(self, completionHandler: {
            self._dataSourceProvider.airports = self.viewModel.searchAirports.data.value
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCommand.executeIf(searchText)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
         self._dataSourceProvider.airports = self.viewModel.airports.data.value
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.searchController!.searchBar.setSearch(viewModel.searchLabel)
    }
}


