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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Flights"
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
