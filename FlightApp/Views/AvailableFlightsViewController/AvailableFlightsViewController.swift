//
//  AvailableFlightsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class AvailableFlightsViewController : BaseViewController<AvailableFlightsViewModel> {
    private let _searchController = CustomSearchController()
    private let _tableView = UITableView()
    private lazy var _dataSourceProvider = AvailableFlightsDataSource(tableView: _tableView)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        _configureTableView()
    }
    
    private func _configureTableView() {
        self.view.addSubview(_tableView)
        
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.anchor(top: self.view.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)

        _tableView.dataSource = _dataSourceProvider
        _tableView.delegate = _dataSourceProvider
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
