//
//  UIViewController+Alert.swift
//  JYHelpers
//
//  Created by Jake Young on 4/18/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//
#if !os(macOS)
import UIKit

extension UIAlertAction {
    public static let defaultOK = UIAlertAction(title: "OK", style: .default, handler: nil)
    public static let defaultCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
}

extension UIViewController {
    
    internal func createAlert(_ title: String?, _ message: String? = nil, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [], completion: (() -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.isEmpty {
            alertVC.addAction(.defaultOK)
        } else {
            actions.forEach { alertVC.addAction($0) }
        }
        return alertVC
    }
    
    public func showAlert(_ title: String?, _ message: String? = nil, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [], completion: (() -> Void)? = nil, sourceView: UIView? = nil, barButtonItem: UIBarButtonItem? = nil) {
        let alertVC = createAlert(title, message, preferredStyle: preferredStyle, actions: actions, completion: completion)
        
        if let sourceView = sourceView {
            alertVC.popoverPresentationController?.sourceView = sourceView
        }
        
        if let barItem = barButtonItem {
            alertVC.popoverPresentationController?.barButtonItem = barItem
        }
        
        present(alertVC, animated: true, completion: completion)
    }
    
}
#endif
