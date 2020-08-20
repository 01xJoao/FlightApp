//
//  NavigationServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class NavigationServiceImp : NavigationService {
    private var _containerViewController : ContainerViewController?

    func containerViewController() -> ContainerViewController {
        return _containerViewController!
    }
    
    func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        _containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        let navController = UINavigationController(rootViewController: viewController);
        _containerViewController?.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func navigateAndSetAsContainer<TViewModel : ViewModel>(viewModel: TViewModel.Type) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: nil)
        _setNewContainerViewController(UINavigationController(rootViewController: viewController))
    }
    
    private func _getViewController<TViewModel : ViewModel>(type: TViewModel.Type, args: Any?) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)
        
        if(args != nil) {
            if let vc = viewController as? BaseViewController<TViewModel> {
                vc.parameterData = args
            }
        }
    
        return viewController
    }
    
    private func _setNewContainerViewController(_ viewController : UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        _containerViewController = sceneDelegate.containerViewController
        _containerViewController?.changeViewController(viewController)
    }
    
    func close(arguments: Any?, animated: Bool) {
        _containerViewController?.navigationController?.popViewController(animated: true)
        _findVisibleViewController(self._containerViewController!.currentViewController!, arguments)
    }
    
    func closeModal(arguments: Any?) {
        _containerViewController?.navigationController?.dismiss(animated: true)
        _findVisibleViewController(self._containerViewController!.currentViewController!, arguments)
    }
    
    func _findVisibleViewController(_ viewController : UIViewController, _ args: Any?) {
        if(viewController.children.isEmpty) {
            _notifyView(viewController.className, args)
        } else {
            viewController.children.forEach({ vc in
                if(vc.view.superview != nil) {
                    _findVisibleViewController(vc, args)
                }
            })
        }
    }
    
    private func _notifyView(_ viewController : String,  _ arguments: Any?) {
        if(arguments != nil) {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: viewController),
                object: nil,
                userInfo: ["arguments": arguments!]
            )
        }
    }
}

