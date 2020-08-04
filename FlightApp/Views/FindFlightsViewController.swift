//
//  FindFlightsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class FindFlightsViewController : FormBaseViewController<FindFlightsViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.findFlightsTitleLabel
       _setupView()
    }

    private func _setupView() {
        formViewAlignment = .top
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 12, left: 12, bottom: 100, right: 12)
        
        let flightPlacesView = backgroundRoundBorderView()
        flightPlacesView.constrainHeight(150)
        
        _addSwapCountriesStack(flightPlacesView)
        _addCountriesStackAndSeparator(flightPlacesView)

        formContainerStackView.addArrangedSubview(flightPlacesView)
        formContainerStackView.addArrangedSubview(_formCard(descriptionLabel: "Departure", valueLabel: "24 Feb, Wed"))
        formContainerStackView.addArrangedSubview(_formCard(descriptionLabel: "Passengers", valueLabel: "1 Adult"))
        
        _submitButton()
    }
    
    func _addSwapCountriesStack(_ flightPlacesView : UIView) {
        let label1 = UILabel(text: "LTN", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.darkGrey, textAlignment: .center, numberOfLines: 1)
        let label2 = UILabel(text: "PAR", font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.darkGrey, textAlignment: .center, numberOfLines: 1)
        
        let swapImageView = getImageInBlue("Swap")
        
        let swapStack = UIView().stack(
            label1,
            swapImageView,
            label2,
            spacing: 10
        )
        
        flightPlacesView.addSubview(swapStack)
        swapStack.anchor(top: nil, leading: nil, bottom: nil, trailing: flightPlacesView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 22))
        swapStack.centerYAnchor.constraint(equalTo: flightPlacesView.centerYAnchor).isActive = true
    }
    
    func _addCountriesStackAndSeparator(_ flightPlacesView : UIView) {
        let topCountryStack = countriesFormView(imageName: "Airplane1", subtitleLabel: "From", countryLabel: "London")
        let bottomCountryStack = countriesFormView(imageName: "Airplane2", subtitleLabel: "To", countryLabel: "Spain")
        
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

    }
    
    func countriesFormView(imageName : String, subtitleLabel : String, countryLabel : String) -> UIView {
        let imageView = getImageInBlue(imageName)
        
        let countriesDetails = _cardDetails(descriptionLabel: subtitleLabel, valueLabel: countryLabel)
        
        let countriesStack = UIView().hstack(
            imageView,
            countriesDetails,
            UIView(),
            spacing: 16
        )
        
        return countriesStack
    }
    
    
    func _formCard(descriptionLabel : String, valueLabel : String) -> UIView {
        let cardView = backgroundRoundBorderView()
        cardView.constrainHeight(90)
        
        let details = _cardDetails(descriptionLabel: descriptionLabel, valueLabel: valueLabel)
        let imageView = getImageInBlue("DownArrow")
        
        cardView.hstack(
            details,
            UIView(),
            imageView,
            spacing: 0,
            alignment: .center
        ).padLeft(22).padRight(22)
        
        return cardView
    }
    
    
    func _cardDetails(descriptionLabel : String, valueLabel : String) -> UIView {
        let cardDescription = UIView().stack(
            UILabel(text: descriptionLabel, font: .systemFont(ofSize: 12, weight: .medium), textColor: UIColor.Theme.darkGrey, textAlignment: .left, numberOfLines: 1),
            UILabel(text: valueLabel, font: .boldSystemFont(ofSize: 16), textColor: UIColor.Theme.black, textAlignment: .left, numberOfLines: 1),
            spacing: 4
        )
        
        return cardDescription
    }
    
    func _submitButton() {
        let button = createMainBlueButton(name: "Let's go", target: self, action: #selector(_submitButtonAction))
        
        self.view.addSubview(button)
        button.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                      trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 15, right: 12))
    }
    
    @objc fileprivate func _submitButtonAction() {
        print("clicked")
    }
    
}
