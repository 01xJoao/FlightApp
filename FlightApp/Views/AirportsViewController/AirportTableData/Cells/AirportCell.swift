//
//  AirportCell.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import ImageLoader

class AirportCell: UITableViewCell {
    func config(_ airport : Airport) {
        self.removeAllSubViews()
        _createCard(airport)
    }
    
    private func _createCard(_ airport : Airport) {
        let cardView = backgroundRoundBorderView(color: UIColor.Theme.white, radius: 5)

        _addBackgroundImage(cardView, airport.getImageUrl())
        _addTitle(cardView, name: airport.getName(), code: airport.getCode())
        _addDeformSquareAndLocationStack(cardView, latitude: airport.getLatitude(), longitude: airport.getLongitude())
        _createCardShadow()
        
        self.addSubview(cardView)
        cardView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    private func _createCardShadow() {
        let shadowView = ShadowView(cornerRadius: 5)
        self.addSubview(shadowView)
        shadowView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    private func _addBackgroundImage(_ cardView: UIView, _ imageURL : URL?) {
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        
        cardView.addSubview(backgroundImage)
        backgroundImage.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)
        
        if let url = imageURL {
            ImageLoader.request(with: url, onCompletion: { image ,_ ,_ in
                DispatchQueue.main.async {
                    backgroundImage.image = image
                }
            })
        }
    }
    
    private func _addTitle(_ cardView: UIView, name : String, code : String) {
        let title = UILabel.init(text: name, font: .systemFont(ofSize: 30, weight: .bold), textColor: UIColor.Theme.white, textAlignment: .left, numberOfLines: 0)
        title.setupShadow(opacity: 0.65, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)
        
        let subtitle = UILabel.init(text: code, font: .systemFont(ofSize: 21, weight: .bold), textColor: UIColor.Theme.white, textAlignment: .left, numberOfLines: 0)
        subtitle.setupShadow(opacity: 0.8, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)

        cardView.stack(
            title,
            subtitle,
            UIView(),
            spacing: 2,
            alignment: .top
        ).padLeft(5)
    }
    
    private func _addDeformSquareAndLocationStack(_ cardView: UIView, latitude: String, longitude: String) {
        let deformSquare = DeformSquare()
        deformSquare.constrainHeight(50)

        cardView.addSubview(deformSquare)
        deformSquare.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)


        let latitudeLabel = UILabel.init(text: latitude, font: .systemFont(ofSize: 9, weight: .semibold), textColor: UIColor.Theme.black , textAlignment: .right, numberOfLines: 0)
        let longitudeLabel = UILabel.init(text: longitude, font: .systemFont(ofSize: 9, weight: .semibold), textColor: UIColor.Theme.black, textAlignment: .right, numberOfLines: 0)

        let locationImage = changeImageColor("Location")
        locationImage.withHeight(25).withWidth(25)
        locationImage.setupShadow(opacity: 0.5, radius: 1, offset: CGSize(width: 1, height: 1), color: UIColor.Theme.black)

        deformSquare.hstack(
            UIView(),
            locationImage,
            stack(
                latitudeLabel,
                longitudeLabel,
                spacing: 1),
            spacing: 4,
            alignment: .bottom
        ).padRight(10).padBottom(10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
      }

      required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
}
