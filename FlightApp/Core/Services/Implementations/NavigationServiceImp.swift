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
    private var _viewControllerStack: [String] = []
    
    func currentViewController() -> UIViewController {
        return _containerViewController!
    }
    
    func setVisibleViewController(_ visibleViewController : String) {
        if(_viewControllerStack.last != visibleViewController) {
            if let index = _viewControllerStack.firstIndex(where: { $0 == visibleViewController }) {
                _viewControllerStack.removeSubrange(index+1..._viewControllerStack.count-1)
            } else {
                _viewControllerStack.append(visibleViewController)
            }
        }
        print(_viewControllerStack)
    }
    
    func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        _containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        let navController = UINavigationController(rootViewController: viewController);
        //navController.presentationController?.delegate = viewController as? UIAdaptivePresentationControllerDelegate
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
            if  let vc = viewController as? BaseViewController<TViewModel> {
                vc.parameterData = args
            }
        }
    
        return viewController
    }
    
    private func _setNewContainerViewController(_ viewController : UIViewController) {
        _viewControllerStack.removeAll()
        _viewControllerStack.append(String(describing: viewController.children.first!.className))
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        _containerViewController = sceneDelegate.containerViewController
        _containerViewController?.changeViewController(viewController)
    }
    
    func close(arguments: Any?, animated: Bool) {
        _viewControllerStack.removeLast()
        
        _containerViewController?.navigationController?.popViewController(animated: animated)
        _notifyView(arguments)
    }
    
    func closeModal(arguments: Any?) {
        _viewControllerStack.removeLast()
        
        _containerViewController?.navigationController?.dismiss(animated: true, completion: nil)
        _notifyView(arguments)
    }
    
    private func _notifyView(_ arguments: Any?) {
        if(arguments != nil) {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: _viewControllerStack.last!),
                object: nil,
                userInfo: ["arguments": arguments!])
        }
    }
}
