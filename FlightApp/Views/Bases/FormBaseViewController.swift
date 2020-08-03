//
//  FormBaseViewController.swift
//  FlightApp
//
//  Created by João Palma on 03/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

public class FormBaseViewController<TViewModel : ViewModel> : BaseViewController<TViewModel>, UIScrollViewDelegate {
    var bottomButtonHeight: CGFloat = 0
    
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.contentSize = view.frame.size
        sv.keyboardDismissMode = .interactive
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    public let formContainerStackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        return sv
    }()
    
    public var formViewAlignment: FormAlignment = .center
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)
        //setupKeyboardNotifications()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if formViewAlignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = bottomButtonHeight
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        _updateScrollViewSize()
    }
    
    public override func viewDidLayoutSubviews() {
        _updateScrollViewSize()
    }
    
    private func _updateScrollViewSize() {
        if (formContainerStackView.frame.height > view.frame.height) {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        } else {
            scrollView.contentSize.height = view.frame.height
        }
    }
    
    
    
//    fileprivate func setupKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc public func handleKeyboardShow(notification: Notification) {
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        let keyboardScreenEndFrame = keyboardFrame.cgRectValue
//        let keyboardViewEndFrame = self.view.convert(keyboardScreenEndFrame, from: self.view.window)
//
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 5, right: 0)
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//
//        let keyboardTotalSize = keyboardViewEndFrame.height + bottomButtonHeight
//
//        if(self.view.frame.height > formContainerStackView.frame.size.height){
//            scrollView.contentSize.height = (self.view.frame.height - formContainerStackView.frame.size.height) + keyboardTotalSize
//        } else {
//            scrollView.contentSize.height = formContainerStackView.frame.size.height
//        }
//    }
    
//    @objc public func handleKeyboardHide() {
//        scrollView.contentInset = UIEdgeInsets.zero
//        scrollView.contentInset.bottom = 0
//        scrollView.verticalScrollIndicatorInsets.bottom = bottomButtonHeight
//    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
    
    public enum FormAlignment {
        case top, center
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("error \(aDecoder)")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

