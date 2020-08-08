//
//  CustomViews.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class DeformSquare : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        
        let p1 = CGPoint(x: 0, y: size.height)
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x, y: 0)
        let p4 = CGPoint(x: 0, y: size.height)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()

        UIColor.Theme.white.set()
        path.fill()
    }
}

func createActivityIndicatory(view : UIView) -> UIActivityIndicatorView {
    let activityView = UIActivityIndicatorView(style: .large)
    activityView.center = view.center
    view.addSubview(activityView)
    
    return activityView
}

func backgroundRoundBorderView(color : UIColor = UIColor.Theme.darkerWhite, radius : CGFloat = 8) -> UIView {
    let backgrounView = UIView()
    backgrounView.backgroundColor = color
    backgrounView.layer.cornerRadius = radius
    backgrounView.layer.masksToBounds = true;
    
    return backgrounView
}

func changeImageColor(_ imageName : String, _ color : UIColor = UIColor.Theme.mainBlue) -> UIImageView {
    let imageView = UIImageView(image: UIImage(named: imageName), contentMode: .scaleAspectFit)
    imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = color
    
    return imageView
}

func createMainBlueButton(name : String, target : Any, action : Selector) -> UIButton {
    let button = UIButton(title: name, titleColor: UIColor.Theme.darkBlue, font: .boldSystemFont(ofSize: 20),
                          backgroundColor: UIColor.Theme.babyBlue, target: target, action: action)
    
    button.layer.cornerRadius = 6
    button.layer.masksToBounds = true;
    button.constrainHeight(52)
    
    return button
}

public func createModalTopBar(_ view : UIView, topBar : UIView, titleLabel : String, selector : Selector) {
    topBar.withHeight(55)
    view.addSubview(topBar)
    topBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    
    let title = UILabel(text: titleLabel, font: .boldSystemFont(ofSize: 18), textColor: UIColor.Theme.white, textAlignment: .center)
    
    topBar.addSubview(title)
    title.anchor(top: topBar.topAnchor, leading: topBar.leadingAnchor, bottom: topBar.bottomAnchor, trailing: topBar.trailingAnchor)
    
    let button = UIButton(image: UIImage(named: "Close")!, tintColor: UIColor.Theme.white, action: selector)
    button.withHeight(55)
    
    topBar.addSubview(button)
    button.anchor(top: topBar.topAnchor, leading: nil, bottom: nil, trailing: topBar.trailingAnchor,
                  padding: .init(top: 0, left: 0, bottom: 0, right: 20))
}

class ShadowView: UIView {
    private let cornerRadius: CGFloat
    private var shadowLayer: CAShapeLayer!
    
    init(cornerRadius : CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}


public func createDashedLine() -> UIView {
    let dashedLine = UIView()
    
    let layer = CALayer()

    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = UIColor.Theme.white.cgColor
    shapeLayer.lineWidth = 1.5
    shapeLayer.lineDashPattern = [4, 4]
    
    let path = CGMutablePath()
    path.addLines(between: [CGPoint(x:0, y: 0), CGPoint(x: 140, y: 0)])
    shapeLayer.path = path
    layer.addSublayer(shapeLayer)
    
    dashedLine.layer.addSublayer(layer)
    
    return dashedLine
}

public func createCircle() -> UIView {
    let circle = UIView(backgroundColor: UIColor.Theme.white)
    
    circle.withWidth(8).withHeight(8)
    circle.layer.cornerRadius = 4
    
    return circle
}
