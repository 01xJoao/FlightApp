//
//  MainViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class MainViewController : BaseTabBarController<MainViewModel> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        _createTabBarController()
    }
    
    private func _createTabBarController() {
        self.viewControllers = [
            _createViewTab(AirportsViewModel.self, L10N.localize(key: "airports_title"),  UIImage(named: "Airport")!),
            _createViewTab(FindFlightsViewModel.self, L10N.localize(key: "findflights_title"), UIImage(named: "FindFlights")!),
        ]
    }
    
    private func _createViewTab<TViewModel : ViewModel>(_ vm : TViewModel.Type, _ title : String, _ image : UIImage) -> UIViewController{
        let viewController: BaseViewController<TViewModel> = DiContainer.resolveViewController(name: String(describing: vm.self))
        viewController.parameterData = viewModel.airports
        viewController.tabBarItem = UITabBarItem(title: title, image: image.withTintColor(UIColor.Theme.darkGrey), selectedImage: image.withTintColor(UIColor.Theme.mainBlue))
        
        let navigationController = UINavigationController();
        navigationController.pushViewController(viewController, animated: false);
        return navigationController;
    }
}
