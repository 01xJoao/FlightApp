//
//  MainViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class MainViewController : BaseTabBarController<MainViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        _createObservers()
        _createTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func _createObservers() {
        viewModel.isBusy.addObserver(self, completionHandler: {
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        })
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    
    private func _createTabBarController() {
        self.viewControllers = [
            _createViewTab(AirportsViewModel.self, viewModel.airportsTitleLabel,  UIImage(named: "Airport")!),
            _createViewTab(FindFlightsViewModel.self, viewModel.findFlightsTitleLabel, UIImage(named: "FindFlights")!)
        ]
    }
    
    private func _createViewTab<TViewModel : ViewModel>(_ vm : TViewModel.Type, _ title : String, _ image : UIImage) -> UIViewController{
        let viewController: BaseViewController<TViewModel> = DiContainer.resolveViewController(name: String(describing: vm.self))
        viewController.parameterData = viewModel.airports
        viewController.tabBarItem = UITabBarItem(title: title, image: image.withTintColor(UIColor.Theme.darkGrey), selectedImage: image.withTintColor(UIColor.Theme.mainBlue))
        
        let navigationController = UINavigationController()
        navigationController.pushViewController(viewController, animated: false)
        return navigationController
    }
}
