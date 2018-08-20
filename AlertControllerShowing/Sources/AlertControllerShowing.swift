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

public typealias PopoveConfigurationHandler = ((UIPopoverPresentationController) -> Void)

public protocol AlertControllerShowingInterface {
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle)
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)?)
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)?,
                             popoveConfigurationHandler: PopoveConfigurationHandler?)
    
}

public extension AlertControllerShowingInterface where Self: UIViewController {
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle) {
        showAlertController(with: title, message: message, actionsConfiguration: actionsConfiguration, preferredStyle: preferredStyle,
                            completion: nil, popoveConfigurationHandler: nil)
    }
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)?) {
        showAlertController(with: title, message: message, actionsConfiguration: actionsConfiguration, preferredStyle: preferredStyle,
                            completion: completion, popoveConfigurationHandler: nil)
    }
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfigProvider],
                             preferredStyle: UIAlertControllerStyle, completion: (() -> Void)? = nil,
                             popoveConfigurationHandler: PopoveConfigurationHandler? = nil) {
        let alertController = UIAlertController(title: title, message: message, actionsConfiguration: actionsConfiguration,
                                                preferredStyle: preferredStyle)
        if let popoverPresentationController = alertController.popoverPresentationController {
            guard let popoveConfigurationHandler = popoveConfigurationHandler else {
                assertionFailure("Please, pass PopoveConfigurationHandler, because it is required in your case of presentation")
                return
            }
            popoveConfigurationHandler(popoverPresentationController)
        }
        present(alertController, animated: true, completion: completion)
    }
    
}
