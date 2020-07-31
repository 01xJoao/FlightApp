//
//  NavigationServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class NavigationServiceImp : NavigationService {
    private var _containerViewController : ContainerViewController?
    
    public func currentViewController() -> UIViewController {
        return _containerViewController!
    }
    
    public func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool){
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        _containerViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: arguments)
        _containerViewController?.navigationController?.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
    
    public func navigateAndSetAsContainer<TViewModel : ViewModel>(viewModel: TViewModel.Type) {
        let viewController: UIViewController = _getViewController(type: viewModel, args: nil)
        _setNewContainerViewController(UINavigationController(rootViewController: viewController))
    }
    
    private func _getViewController<TViewModel : ViewModel>(type: TViewModel.Type, args: Any?) -> UIViewController {
        let viewModelName = String(describing: TViewModel.self)
        let viewController: UIViewController = DiContainer.resolveViewController(name: viewModelName)
        
        if let vc = viewController as? BaseViewController<TViewModel> {
            if(args != nil) {
                vc.parameterData = args
            }
        } else {
//            let vc = viewController as! BaseCollectionViewController<TViewModel>
//            if(args != nil) {
//                vc.parameterData = args
//            }
        }
    
        return viewController
    }
    
    private func _setNewContainerViewController(_ viewController : UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        _containerViewController = sceneDelegate.containerViewController
        _containerViewController?.changeViewController(viewController)
    }
    
    public func close(arguments: Any?, animated: Bool) {
        _containerViewController?.navigationController?.popViewController(animated: animated)
        _notifyView(arguments, _visibleViewController())
    }
    
    public func closeModal(arguments: Any?) {
        _containerViewController?.navigationController?.dismiss(animated: true, completion: nil)
        _notifyView(arguments, _visibleViewController())
    }
    
    private func _visibleViewController() -> String! {
        return _containerViewController?.children.last?.children.last?.className
    }
    
    private func _notifyView(_ args: Any?, _ view : String ) {
        if(args != nil) {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: view),
                object: nil,
                userInfo: ["arguments": args!])
        }
    }
}
