//
//  FindFlightsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import DrawerView

class FindFlightsViewController : FormBaseViewController<FindFlightsViewModel> {
    private var _activityIndicatorView: UIActivityIndicatorView!
    private var _originCodeLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 18), textColor: UIColor.Theme.darkGrey, textAlignment: .center)
    private var _originNameLabel = UILabel(text:"", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black, textAlignment: .left)
    private var _destinationCodeLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 18), textColor: UIColor.Theme.darkGrey,textAlignment: .center)
    private var _destinationNameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black, textAlignment: .left)
    private let _departureLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black, textAlignment: .left)
    private let _passengersLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black, textAlignment: .left)
    private var _drawerDepartureView: DrawerView?
    private var _drawerPassengersView: DrawerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.findFlightsTitleLabel
       _setupView()
    }

    private func _setupView() {
        _createClearButton()
        _configureFormView()
        _setDefaultData()
        _configureActivityView()
        _createObservers()
    }
    
    private func _createClearButton() {
        let rightBarButton = UIBarButtonItem(title: viewModel.clearLabel, style: .plain, target: self, action: #selector(_clearButtonAction))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.Theme.white], for: .normal)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func _configureFormView() {
        formViewAlignment = .top
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 12, left: 12, bottom: 100, right: 12)
       
        let flightPlacesView = backgroundRoundBorderView()
        flightPlacesView.constrainHeight(150)
       
        _addSwapCountriesStack(flightPlacesView)
        _addCountriesStackAndSeparator(flightPlacesView)

        formContainerStackView.addArrangedSubview(flightPlacesView)
        formContainerStackView.addArrangedSubview(_formCard(descriptionLabel: viewModel.departureLabel, label: _departureLabel, action: #selector(_departureAction)))
        formContainerStackView.addArrangedSubview(_formCard(descriptionLabel: viewModel.passengersLabel, label: _passengersLabel, action: #selector(_passengersAction)))
       
       _submitButton()
    }
    
    private func _setDefaultData() {
        _departureLabel.text = viewModel.findFlight.value.getDeparture()
        
        _setAirportNamesAndCodes(_originCodeLabel, _originNameLabel,
                                 viewModel.originPlaceholderCodeLabel, viewModel.originPlaceholderNameLabel)
        
        _setAirportNamesAndCodes(_destinationCodeLabel, _destinationNameLabel,
                                 viewModel.destinationPlaceholderCodeLabel, viewModel.destinationPlaceholderNameLabel)
        
        _passengersLabel.text = viewModel.passengersValue
    }
    
    private func _configureActivityView() {
        _activityIndicatorView = createActivityIndicatory(view: self.view)
    }
    
    private func _createObservers() {
        viewModel.isBusy.addObserver(self, completionHandler: {
            if(self.viewModel.isBusy.value) {
                self._activityIndicatorView.startAnimating()
            } else {
                self._activityIndicatorView.stopAnimating()
            }
        })
        
        viewModel.findFlight.addObserver(self, completionHandler: {
            self._setAirportNamesAndCodes(self._originCodeLabel, self._originNameLabel,
                                          self.viewModel.originPlaceholderCodeLabel,
                                          self.viewModel.originPlaceholderNameLabel,
                                          self.viewModel.findFlight.value.getOriginCode(),
                                          self.viewModel.findFlight.value.getOriginName())
            
            self._setAirportNamesAndCodes(self._destinationCodeLabel, self._destinationNameLabel,
                                          self.viewModel.destinationPlaceholderCodeLabel,
                                          self.viewModel.destinationPlaceholderNameLabel,
                                          self.viewModel.findFlight.value.getDestinationCode(),
                                          self.viewModel.findFlight.value.getDestinationName())
            
            self._departureLabel.text = self.viewModel.findFlight.value.getDeparture()
            self._passengersLabel.text = self.viewModel.passengersValue
        })
    }
    
    private func _setAirportNamesAndCodes(_ labelCode : UILabel, _ labelName : UILabel, _ placeholderCode : String,
                                          _ placeholderName : String, _ code : String = "", _ name : String = "") {
        
        labelCode.text = code.isEmpty ? placeholderCode : code
        labelCode.font = code.isEmpty ? .systemFont(ofSize: 16, weight: .medium) : .boldSystemFont(ofSize: 16)
        labelCode.textColor = code.isEmpty ? UIColor.Theme.darkGrey : UIColor.Theme.strongGrey
        
        labelName.text = name.isEmpty ? placeholderName : name
        labelName.font = name.isEmpty ? .italicSystemFont(ofSize: 14) : .boldSystemFont(ofSize: 16)
        labelName.textColor = name.isEmpty ? UIColor.Theme.darkGrey : UIColor.Theme.black
    }
    
    private func _addSwapCountriesStack(_ flightPlacesView : UIView) {
        let swapImageView = changeImageColor("Swap")

        let swapStack = UIView().stack(
            _originCodeLabel,
            swapImageView,
            _destinationCodeLabel,
            spacing: 10
        )
        
        flightPlacesView.addSubview(swapStack)
        swapStack.anchor(top: nil, leading: nil, bottom: nil, trailing: flightPlacesView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 22))
        swapStack.centerYAnchor.constraint(equalTo: flightPlacesView.centerYAnchor).isActive = true
        
        let button = UIButton(title: "", titleColor: .clear, font: .systemFont(ofSize: 0), backgroundColor: .clear, target: self, action: #selector(_swapButtonAction))
        
        flightPlacesView.addSubview(button)
        button.anchor(top: swapStack.topAnchor, leading: swapStack.leadingAnchor, bottom: swapStack.bottomAnchor, trailing: swapStack.trailingAnchor)
    }
    
    private func _addCountriesStackAndSeparator(_ flightPlacesView : UIView) {
        let topCountryStack = _airportSelection(imageName: "Airplane1", subtitleLabel: viewModel.originLabel, countryLabel: _originNameLabel)
        let bottomCountryStack = _airportSelection(imageName: "Airplane2", subtitleLabel: viewModel.destinationLabel, countryLabel: _destinationNameLabel)
        
        let countriesStack = UIView().stack(
            topCountryStack,
            bottomCountryStack,
            spacing: 28
        )
        
        flightPlacesView.addSubview(countriesStack)
        countriesStack.anchor(top: nil, leading: flightPlacesView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 22, bottom: 0, right: 0))
        countriesStack.centerYAnchor.constraint(equalTo: flightPlacesView.centerYAnchor).isActive = true
        
        let separatorLine = UIView()
        separatorLine.constrainHeight(1.5)
        separatorLine.backgroundColor = UIColor.Theme.grey
        
        flightPlacesView.addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: countriesStack.leadingAnchor, bottom: nil,
                             trailing: flightPlacesView.subviews.first!.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 18))
        separatorLine.centerYAnchor.constraint(equalTo: flightPlacesView.centerYAnchor).isActive = true
        
        let button = UIButton(title: "", titleColor: .clear, font: .systemFont(ofSize: 0), backgroundColor: .clear, target: self, action: #selector(_originCountryButtonAction))
        flightPlacesView.addSubview(button)
        button.anchor(top: flightPlacesView.topAnchor, leading: countriesStack.leadingAnchor, bottom: separatorLine.topAnchor, trailing: separatorLine.trailingAnchor,
                      padding: .init(top: 5, left: 0, bottom: 3, right: 5))
        
        let button2 = UIButton(title: "", titleColor: .clear, font: .systemFont(ofSize: 0), backgroundColor: .clear, target: self, action: #selector(_destinationCountryButtonAction))
        flightPlacesView.addSubview(button2)
        button2.anchor(top: separatorLine.bottomAnchor, leading: countriesStack.leadingAnchor, bottom: flightPlacesView.bottomAnchor, trailing: separatorLine.trailingAnchor,
                       padding: .init(top: 3, left: 0, bottom: 5, right: 5))
        
    }
    
    private func _airportSelection(imageName : String, subtitleLabel : String, countryLabel : UILabel) -> UIView {
        let imageView = changeImageColor(imageName)
        let countriesDetails = _cardDetails(descriptionLabel: subtitleLabel, label: countryLabel)
        
        let countriesStack = UIView().hstack(
            imageView,
            countriesDetails,
            UIView(),
            spacing: 16
        )
        
        return countriesStack
    }
    
    private func _cardDetails(descriptionLabel : String, label : UILabel) -> UIView {
        let cardDescription = UIView().stack(
            UILabel(text: descriptionLabel, font: .systemFont(ofSize: 12, weight: .medium), textColor: UIColor.Theme.darkGrey, textAlignment: .left, numberOfLines: 1),
            label,
            spacing: 4
        )
        
        return cardDescription
    }
    
    private func _formCard(descriptionLabel : String, label : UILabel, action : Selector) -> UIView {
        let cardView = backgroundRoundBorderView()
        cardView.constrainHeight(90)
        
        let details = _cardDetails(descriptionLabel: descriptionLabel, label: label)
        let imageView = changeImageColor("DownArrow")
        
        cardView.hstack(
            details,
            UIView(),
            imageView,
            spacing: 0,
            alignment: .center
        ).padLeft(22).padRight(22)
        
        let button = UIButton(title: "", titleColor: .clear, font: .systemFont(ofSize: 0), backgroundColor: .clear, target: self, action: action)
        cardView.addSubview(button)
        button.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .allSides(5))
        
        return cardView
    }
    
    private func _submitButton() {
        let button = createMainBlueButton(name: viewModel.letsGoLabel, target: self, action: #selector(_submitButtonAction))
        
        self.view.addSubview(button)
        button.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                      trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 15, right: 12))
    }
    
    
    @objc private func _clearButtonAction() {
        viewModel.clearCommand.executeIf()
    }
    
    @objc private func _swapButtonAction() {
        viewModel.swapAirportsCommand.executeIf()
    }
    
    @objc private func _originCountryButtonAction() {
        viewModel.openAirportListViewCommand.executeIf(.origin)
    }
    
    @objc private func _destinationCountryButtonAction() {
        viewModel.openAirportListViewCommand.executeIf(.destination)
    }
    
    @objc private func _departureAction() {
        let datePickerVC = DatePickerModalView()
        datePickerVC.config(date: viewModel.findFlight.value.getDepartureDate(), titleLabel: viewModel.departureLabel, confirmLabel: viewModel.confirmLabel, handler: _datePickerSelection)
        
        _drawerDepartureView = viewModel.navigationService.currentViewController().addDrawerView(withViewController: datePickerVC)
        _drawerDepartureView!.partiallyOpenHeight = LocalConstants.DatePickerModalHeight
        _drawerDepartureView!.snapPositions = [.partiallyOpen, .closed]
    }
    
    private func _datePickerSelection(_ obj : Any) {
        if let date = obj as? Date {
            viewModel.setDepartureCommand.executeIf(date)
        }
        
        _drawerDepartureView?.removeFromSuperview(animated: true)
    }
    
    @objc private func _passengersAction() {
        let passengersVC = PassengersModalView()
        
        passengersVC.config(passengers: viewModel.findFlight.value.getPassengers(), titleLabel: viewModel.passengersLabel,
                            applyLabel: viewModel.applyLabel, handler: _passengersSelection,
                            labels: [viewModel.adultsLabel, viewModel.teensLabel, viewModel.childrenLabel])
        
        _drawerPassengersView = viewModel.navigationService.currentViewController().addDrawerView(withViewController: passengersVC)
        _drawerPassengersView!.partiallyOpenHeight = LocalConstants.PassengersModalHeight
        _drawerPassengersView!.snapPositions = [.partiallyOpen, .closed]
    }
    
    private func _passengersSelection(_ obj : Any) {
        if let passengers = obj as? PassengersObject {
            viewModel.setPassengersCommand.executeIf(passengers)
        }
        
        _drawerPassengersView?.removeFromSuperview(animated: true)
    }
    
    @objc private func _submitButtonAction() {
        viewModel.submitButtonCommand.executeIf()
    }
}
