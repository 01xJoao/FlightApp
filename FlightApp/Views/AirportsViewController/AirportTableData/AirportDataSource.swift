//
//  AirportTableViewSource.swift
//  FlightApp
//
//  Created by João Palma on 02/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class AirportDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    private let _cellIdentifier = "AirportCell"
    private let _tableView : UITableView
    
    var airports = [Airport]() {
        didSet {
            DispatchQueue.main.async {
                self._tableView.reloadData()
            }
        }
    }
    
    init(tableView : UITableView) {
        _tableView = tableView
        tableView.separatorStyle = .none
        tableView.register(AirportCell.self, forCellReuseIdentifier: _cellIdentifier)
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellIdentifier, for: indexPath) as! AirportCell
        
        let item = airports[indexPath.row]
        cell.config(item)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
