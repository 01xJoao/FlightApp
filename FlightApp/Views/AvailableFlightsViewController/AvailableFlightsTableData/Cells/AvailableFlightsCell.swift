//
//  AvailableFlightsCell.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class FlightCell : UITableViewCell {
    public func config(_ flight : FlightDetail, _ labels : [String]) {
        self.removeAllSubViews()
        _createCard(flight, labels)
    }
    
    private func _createCard(_ flight : FlightDetail,_ labels : [String]) {
        _createCardShadow()
        
        let cardView = backgroundRoundBorderView(color: UIColor.Theme.white, radius: 5)
        
        self.addSubview(cardView)
        cardView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        
        let imageView = UIImageView(image: UIImage(named: "Ryanair"))
        imageView.withHeight(40).withWidth(40)
        
        cardView.addSubview(imageView)
        
        imageView.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        imageView.centerXToSuperview()
        
        let departView = _createStringVerticalStack(detail: labels[0], value: flight.getDepartTime(), size: 26, color: UIColor.Theme.black, align: .left)
        
        cardView.addSubview(departView)
        departView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 18, bottom: 0, right: 0))
        
        let arriveView = _createStringVerticalStack(detail: labels[1], value: flight.getArriveTime(), size: 26, color: UIColor.Theme.black, align: .right)
        
        cardView.addSubview(arriveView)
        arriveView.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 18))
        
        let flightNrView = _createStringVerticalStack(detail: labels[2], value: flight.getFlightNumber(), size: 20, color: UIColor.Theme.mainBlue, align: .left)
        
        cardView.addSubview(flightNrView)
        flightNrView.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 18, bottom: 15, right: 0))
        
        let priceView = _createStringHorizontalStack(value: flight.getFare(), currency: flight.getCurrency(), souldOut: labels[3])
        
        cardView.addSubview(priceView)
        priceView.anchor(top: nil, leading: nil, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 15, right: 18))
        
        _addDuration(time: "\(flight.getDurationTime()) \(labels[4])")
    }
    
    private func _addDuration(time : String) {
        let lineView = UIView(backgroundColor: UIColor.Theme.grey)
        lineView.withHeight(1.5).withWidth(300)
        
        self.addSubview(lineView)
        lineView.centerXToSuperview()
        lineView.centerYToSuperview()
        
        let roundedBox = UIView(backgroundColor: UIColor.Theme.white)
        roundedBox.withHeight(50).withWidth(210)
        roundedBox.layer.borderWidth = 1.5
        roundedBox.layer.borderColor = UIColor.Theme.grey.cgColor
        roundedBox.layer.cornerRadius = 25
        
        self.addSubview(roundedBox)
        roundedBox.centerXToSuperview()
        roundedBox.centerYToSuperview()
        
        let label = UILabel(text: time, font: .systemFont(ofSize: 16, weight: .semibold), textColor: UIColor.Theme.mainBlue)
        
        self.addSubview(label)
        label.centerXToSuperview()
        label.centerYToSuperview()
    }
    
    private func _createStringVerticalStack(detail : String, value : String, size : CGFloat, color : UIColor, align : NSTextAlignment) -> UIView {
        let detailLabel = UILabel(text: detail, font: .systemFont(ofSize: 12, weight: .semibold), textColor: UIColor.Theme.darkGrey, textAlignment: align, numberOfLines: 1)
        let valueLabel = UILabel(text: value, font: .systemFont(ofSize: size, weight: .semibold), textColor: color, textAlignment: align, numberOfLines: 1)
        
        let stack = UIView().stack(
            detailLabel,
            valueLabel
        )
        
        return stack
    }
    
    private func _createStringHorizontalStack(value : String, currency : String, souldOut : String) -> UIView {
        if(value.isEmpty) {
            return UILabel(text: souldOut, font: .boldSystemFont(ofSize: 15), textColor: UIColor.Theme.red, textAlignment: .right)
        }
        
        let valueLabel = UILabel(text: value, font: .systemFont(ofSize: 28, weight: .semibold), textColor: UIColor.Theme.gold)
        let currencyLabel = UILabel(text: currency, font: .systemFont(ofSize: 14, weight: .bold), textColor: UIColor.Theme.mainBlue)
        
        let hstack = UIView().hstack(
            valueLabel,
            currencyLabel,
            spacing: 4,
            alignment: .top
        )
        
        return hstack
    }
    
    private func _createCardShadow() {
        let shadowView = ShadowView(cornerRadius: 5)
        self.addSubview(shadowView)
        shadowView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
}

