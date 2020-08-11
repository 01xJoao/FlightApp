//
//  DatePickerModal.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import LBTATools

class DatePickerModalView : UIViewController {
    private var _titleLabel : String!
    private let _datePicker = UIDatePicker()
    private let _topBar = UIView(backgroundColor: UIColor.Theme.mainBlue)
    private let _submitButton = createMainBlueButton(name: "", target: self, action: #selector(_submitButtonAction))
    private var _submitEventHandler : EventHandler?
    
    func config(date : Date, titleLabel : String, confirmLabel : String, handler : @escaping EventHandler) {
        _datePicker.date = date
        _submitButton.setTitle(confirmLabel, for: .normal)
        _submitEventHandler = handler
        _titleLabel = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createModalTopBar(self.view, topBar: _topBar, titleLabel: _titleLabel, selector: #selector(_closeButtonAction))
        _configureSubmitButton()
        _createDatePicker()
    }
    
    private func _createDatePicker() {
        _datePicker.datePickerMode = .date
        _datePicker.minimumDate = Date()
            
        self.view.addSubview(_datePicker)
        _datePicker.anchor(top: _topBar.bottomAnchor, leading: self.view.leadingAnchor, bottom: _submitButton.topAnchor, trailing: self.view.trailingAnchor)
        _datePicker.timeZone = NSTimeZone.local
    }
    
    private func _configureSubmitButton() {
        self.view.addSubview(_submitButton)
        _submitButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor,
                     trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 15, right: 12))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _topBar.roundCorners(corners: [.topLeft, .topRight], radius: 7)
    }
    
    @objc private func _submitButtonAction() {
        _ = _submitEventHandler!(_datePicker.date)
    }
    
    @objc private func _closeButtonAction() {
        _ = _submitEventHandler!({})
    }
}
