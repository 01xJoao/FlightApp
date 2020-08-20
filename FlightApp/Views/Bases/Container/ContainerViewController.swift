//
//  ViewController.swift
//  FlightApp
//
//  Created by João Palma on 30/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    private(set) var currentViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func changeViewController(_ viewController: UIViewController) {
        if(_checkIfCurrentViewControllerIsEqualsToNew(viewController)) {
            return
        }
        
        _removeCurrentViewController()
        _addNewViewControllerToContainer_(viewController)
    }
    
    func _checkIfCurrentViewControllerIsEqualsToNew(_ viewController: UIViewController) -> Bool {
        return currentViewController == viewController.self
    }
    
    func _removeCurrentViewController() {
        if(currentViewController != nil) {
            self.willMove(toParent: nil)
            currentViewController?.removeFromParent()
            currentViewController?.view.removeFromSuperview()
            currentViewController = nil
        }
    }
    
    private func _addNewViewControllerToContainer_ (_ viewController: UIViewController) {
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        currentViewController = viewController
    }
}
