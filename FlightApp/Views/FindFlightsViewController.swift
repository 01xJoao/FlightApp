//
//  FindFlightsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import DrawerView

class FindFlightsViewController : BaseViewController<FindFlightsViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Find Flights"
        
        let button = UIButton()
        button.frame = CGRect(x: 10, y: 150, width: 120, height: 50)
        button.backgroundColor = UIColor.Theme.mainBlue
        button.setTitle("Navigation", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 140, y: 150, width: 120, height: 50)
        button1.backgroundColor = UIColor.Theme.darkBlue
        button1.setTitle("Modal", for: .normal)
        button1.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 140, y: 210, width: 140, height: 50)
        button2.backgroundColor = UIColor.Theme.darkBlue
        button2.setTitle("Bottom Modal", for: .normal)
        button2.addTarget(self, action: #selector(buttonAction3), for: .touchUpInside)
        self.view.addSubview(button2)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.navigationService.navigate(viewModel: AvailableFlightsViewModel.self, arguments: nil, animated: true)
    }
    
    @objc func buttonAction2(sender: UIButton!) {
        viewModel.navigationService.navigateModal(viewModel: CountryListViewModel.self, arguments: nil)
    }
    
    @objc func buttonAction3(sender: UIButton!) {
        let drawerView = viewModel.navigationService.currentViewController().addDrawerView(withViewController: DatePickerModalView())
        drawerView.partiallyOpenHeight = 400
        drawerView.snapPositions = [.partiallyOpen, .closed]
    }
}
