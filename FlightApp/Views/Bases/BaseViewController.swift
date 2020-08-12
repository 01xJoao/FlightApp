//
//  BaseViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class BaseViewController<TViewModel : ViewModel> : UIViewController {
    var parameterData: Any?
    
    private var _viewModel: TViewModel!
    var viewModel: TViewModel {
        get {
            return _viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setViewConfigurations()
        _instantiateViewModel()
        _createViewCloseNotification()
    }
    
    private func _setViewConfigurations() {
        view.backgroundColor = UIColor.Theme.white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func _backButtonPressed(sender:UIButton) {
        _viewModel.backAction()
    }
    
    private func _instantiateViewModel() {
        let vm : TViewModel = DiContainer.resolve()
        
        if(parameterData != nil) {
            vm.prepare(dataObject: parameterData!)
        }
        
        _viewModel = vm
        _viewModel?.initialize()
    }
    
    private func _createViewCloseNotification() {
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._handleViewDismiss(_:)),
           name: NSNotification.Name(rawValue: String(describing: type(of: self))),
           object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _setAsVisibleViewController()
        _viewModel?.appearing()
    }
    
    private func _setAsVisibleViewController() {
        let navigationService : NavigationService = DiContainer.resolve()
        navigationService.setVisibleViewController(String(describing: type(of: self)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _viewModel?.disappearing()
    }
    
    @objc func _handleViewDismiss(_ notification: NSNotification) {
        if let params = notification.userInfo as NSDictionary? {
            _viewModel.dataNotify(dataObject: params["arguments"])
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
