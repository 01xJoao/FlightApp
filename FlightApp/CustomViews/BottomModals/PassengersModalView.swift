//
//  PassengersModalView.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class PassengersModalView : UIViewController {
    private var _titleLabel : String!
    private var _passengers : PassengersStruct!
    private let _topBar = UIView(backgroundColor: UIColor.Theme.mainBlue)
    private let _applyButton = createMainBlueButton(name: "", target: self, action: #selector(_applyButtonAction))
    private var _submitEventHandler : EventHandler?
    private var _passengersLabels: [String] = []
    
    private let _adultLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .semibold), textColor: UIColor.Theme.mainBlue)
    private let _teenLabel  = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .semibold), textColor: UIColor.Theme.mainBlue)
    private var _childrenLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .semibold), textColor: UIColor.Theme.mainBlue)
    
    private let _adultStepper = UIStepper()
    private let _teenStepper = UIStepper()
    private let _childrenStepper = UIStepper()
    
    func config(passengers : PassengersStruct, titleLabel : String, applyLabel : String, handler : @escaping EventHandler, labels: [String]) {
        _passengersLabels.append(contentsOf: labels)
        _passengers = passengers
        _applyButton.setTitle(applyLabel, for: .normal)
        _submitEventHandler = handler
        _titleLabel = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createModalTopBar(self.view, topBar: _topBar, titleLabel: _titleLabel, selector: #selector(_closeButtonAction))
        
        _adultStepper.minimumValue = FlightValues.minAdultsPassenger
        let adults = _createPassengers(description: _passengersLabels[0], stepper: _adultStepper, label: _adultLabel, value: _passengers.adults, tag: 1)
        let teen = _createPassengers(description: _passengersLabels[1], stepper: _teenStepper, label: _teenLabel, value: _passengers.teen, tag: 2)
        let children = _createPassengers(description: _passengersLabels[2], stepper: _childrenStepper, label: _childrenLabel, value: _passengers.children, tag: 3)
        
        let view = UIView().stack(
            adults,
            teen,
            children
        ).padLeft(25).padRight(25).padTop(2.5)
        
        self.view.addSubview(view)
        view.anchor(top: _topBar.bottomAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor)

        _configureApplyButton()
    }
    
    private func _createPassengers(description : String, stepper : UIStepper, label : UILabel, value : Int, tag : Int) -> UIView {
        let titleLabel = UILabel(text: description, font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black)
        label.text = "\(value)"
        
        stepper.tag = tag
        stepper.wraps = false
        stepper.autorepeat = true
        stepper.value = Double(value)
        stepper.maximumValue = FlightValues.maxPerPassengerPerType
        stepper.addTarget(self, action: #selector(_stepperValueChanged(stepper:)), for: .valueChanged)
        
        let stepperStack = UIView().hstack(
            label,
            stepper,
            spacing: 38
        )
        
        let detailsView = UIView().hstack(
            titleLabel,
            stepperStack,
            distribution: .equalCentering
        ).padTop(13).padBottom(13)
        
        let separator = UIView(backgroundColor: UIColor.Theme.babyGrey)
        separator.withHeight(1.5)
        
        detailsView.addSubview(separator)
        separator.anchor(top: detailsView.bottomAnchor, leading: detailsView.leadingAnchor, bottom: nil, trailing: detailsView.trailingAnchor)
        
        return detailsView
    }
    
    private func _configureApplyButton() {
        self.view.addSubview(_applyButton)
        _applyButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                            trailing: self.view.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _topBar.roundCorners(corners: [.topLeft, .topRight], radius: 7)
    }
    
    @objc private func _stepperValueChanged(stepper : UIStepper) {
        let value = Int(stepper.value)
        
        switch stepper.tag {
            case 1: _passengers.adults = value; _adultLabel.text = "\(value)"
            case 2: _passengers.teen = value; _teenLabel.text = "\(value)"
            case 3: _passengers.children = value; _childrenLabel.text = "\(value)"
            default: break
        }
    }
    
    @objc private func _applyButtonAction() {
        _ = _submitEventHandler!(_passengers!)
    }
    
    @objc private func _closeButtonAction() {
        _ = _submitEventHandler!({})
    }
}
