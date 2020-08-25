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
    
    private(set) var viewModel: TViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setViewConfigurations()
        _instantiateViewModel()
        _createAppearingViewNotification()
    }
    
    private func _setViewConfigurations() {
        view.backgroundColor = UIColor.Theme.white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func _instantiateViewModel() {
        let vm : TViewModel = DiContainer.resolve()
        
        if(parameterData != nil) {
            vm.prepare(dataObject: parameterData!)
        }
        
        viewModel = vm
        viewModel?.initialize()
    }
    
    private func _createAppearingViewNotification() {
        NotificationCenter.default.addObserver(self,
           selector: #selector(self._notifyViewOnAppearing(_:)),
           name: NSNotification.Name(rawValue: String(describing: type(of: self))),
           object: nil)
    }
    
    @objc func _notifyViewOnAppearing(_ notification: NSNotification) {
        if let params = notification.userInfo as NSDictionary? {
            viewModel.dataNotify(dataObject: params["arguments"])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.appearing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.disappearing()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
