//
//  AlertControllerShowing.swift
//  AlertControllerShowing
//
//  Created by Sergey Kostyan on 28.04.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import Foundation
import UIKit
import AlertActionBuilder
import SKAlertControllerBuilder

public protocol AlertControllerShowingInterface {
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)?)
    
}

public extension AlertControllerShowingInterface where Self: UIViewController {
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController.build(title: title, message: message, actionsConfiguration: actionsConfiguration,
                                                      preferredStyle: preferredStyle)
        if let popoverPresentationController = alertController.popoverPresentationController {
            guard let popoverPresentationDelegate = self as? UIPopoverPresentationControllerDelegate else {
                fatalError("WARNING: UIViewController should confirm to UIPopoverPresentationControllerDelegate. Implement method -prepareForPopoverPresentation")
            }
            popoverPresentationController.delegate = popoverPresentationDelegate
        }
        present(alertController, animated: true, completion: completion)
    }
    
}
