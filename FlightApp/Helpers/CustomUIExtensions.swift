//
//  CustomUIExtensions.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

public struct CustomUIExtensions {
    public static func textShadow() -> NSShadow {
        let textShadow = NSShadow()
        textShadow.shadowColor = UIColor.Theme.black
        textShadow.shadowBlurRadius = 1.2
        textShadow.shadowOffset = CGSize(width: 0.6, height: 0.6)
        return textShadow
    }
}

extension UIColor {
    struct Theme {
        static var mainBlue = UIColor().fromRGBA(red: 31, green: 91, blue: 172, alpha: 1.0)
        static var babyBlue = UIColor().fromRGBA(red: 229, green: 238, blue: 255, alpha: 1.0)
        static var darkBlue = UIColor().fromRGBA(red: 36, green: 94, blue: 229, alpha: 1.0)
        static var white = UIColor().fromRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)
        static var darkerWhite = UIColor().fromRGBA(red: 249, green: 249, blue: 252, alpha: 1.0)
        static var black = UIColor().fromRGBA(red: 0, green: 0, blue: 0, alpha: 1.0)
        static var grey = UIColor().fromRGBA(red: 233, green: 233, blue: 233, alpha: 1.0)
        static var strongGrey = UIColor().fromRGBA(red: 105, green: 105, blue: 105, alpha: 1.0)
        static var babyGrey = UIColor().fromRGBA(red: 241, green: 241, blue: 241, alpha: 1.0)
        static var darkGrey = UIColor().fromRGBA(red: 154, green: 156, blue: 174, alpha: 1.0)
        static var gold = UIColor().fromRGBA(red: 232, green: 178, blue: 0, alpha: 1.0)
    }
}

extension UIColor {
    func fromRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }
}

final class ShadowView: UIView {
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
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}

class NavigationController: UINavigationController {
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.topViewController?.navigationItem.backBarButtonItem = backButton
        self.topViewController?.navigationItem.backBarButtonItem?.tintColor = UIColor.Theme.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

public class CustomSearchController : UISearchController {
    private lazy var customSearchBar = CustomSearchBar()
    public override var searchBar: UISearchBar { customSearchBar }
}

private class CustomSearchBar : UISearchBar {
    override func didMoveToSuperview() {
        (self.searchTextField.leftView as? UIImageView)?.tintColor = UIColor.Theme.white.withAlphaComponent(0.7)
    }
}

extension UISearchBar {
    func setSearch(_ placeholderName : String) {
        self.searchTextField.textColor = UIColor.Theme.white
        
        self.searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeholderName,
            attributes:[NSAttributedString.Key.foregroundColor : UIColor.Theme.white.withAlphaComponent(0.7)]
        )
    }
}

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}

extension UIView {
     public func removeAllSubViews() {
          self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
