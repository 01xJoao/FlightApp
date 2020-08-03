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
            _createViewTab(L10N.localize(key: "airports_title"), String(describing: AirportsViewModel.self), UIImage(named: "Airport")!),
            _createViewTab(L10N.localize(key: "findflights_title"), String(describing: FindFlightsViewModel.self), UIImage(named: "FindFlights")!),
        ]
    }
    
    private func _createViewTab(_ title : String, _ viewModelName : String, _ image : UIImage) -> UIViewController{
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)
        viewController.tabBarItem = UITabBarItem(title: title, image: image.withTintColor(UIColor.Theme.darkGrey), selectedImage: image.withTintColor(UIColor.Theme.mainBlue))
        let navigationController = UINavigationController();
        navigationController.pushViewController(viewController, animated: false);
        return navigationController;
    }
}
