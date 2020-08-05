//
//  AirportListDataSource.swift
//  FlightApp
//
//  Created by João Palma on 05/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

import UIKit

class AirportListDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    private let _cellIdentifier = "AirportListCell"
    private let _tableView : UITableView
    
    open var airportList = [Airport]() {
        didSet {
            DispatchQueue.main.async {
                self._tableView.reloadData()
            }
        }
    }
    
    init(tableView : UITableView) {
        _tableView = tableView
        tableView.separatorStyle = .none
        tableView.register(AirportListCell.self, forCellReuseIdentifier: _cellIdentifier)
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellIdentifier, for: indexPath) as! AirportListCell
        cell.selectionStyle = .gray
        
        let item = airportList[indexPath.row]
        cell.config(item)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
