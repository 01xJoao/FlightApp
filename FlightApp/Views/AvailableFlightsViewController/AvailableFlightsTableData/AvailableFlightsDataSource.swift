//
//  AvailableFlightsDataSource.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class AvailableFlightsDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    private let _cellIdentifier = "FlightCell"
    private let _tableView : UITableView
    
    var labels: [String]?
    var flights = [FlightDetail]() {
        didSet {
            DispatchQueue.main.async {
                self._tableView.reloadData()
            }
        }
    }
    
    init(tableView : UITableView) {
        _tableView = tableView
        _tableView.separatorStyle = .none
        _tableView.register(FlightCell.self, forCellReuseIdentifier: _cellIdentifier)
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellIdentifier, for: indexPath) as! FlightCell
        
        let item = flights[indexPath.row]
        cell.config(item, labels!)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
