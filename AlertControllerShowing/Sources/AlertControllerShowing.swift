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
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig], preferredStyle: UIAlertControllerStyle,
                             completion: (() -> Void)?)
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig], preferredStyle: UIAlertControllerStyle,
                             completion: (() -> Void)?, popoveConfigurationHandler: PopoveConfigurationHandler?)
    
    
}

public extension AlertControllerShowingInterface where Self: UIViewController {
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig], preferredStyle: UIAlertControllerStyle,
                             completion: (() -> Void)? = nil) {
        showAlertController(with: title, message: message, actionsConfiguration: actionsConfiguration, preferredStyle: preferredStyle,
                            completion: completion)
    }
    
    func showAlertController(with title: String?, message: String?, actionsConfiguration: [AlertActionConfig], preferredStyle: UIAlertControllerStyle,
                             completion: (() -> Void)? = nil, popoveConfigurationHandler: PopoveConfigurationHandler? = nil) {
        let alertController = UIAlertController.build(title: title, message: message, actionsConfiguration: actionsConfiguration,
                                                      preferredStyle: preferredStyle)
        if let popoverPresentationController = alertController.popoverPresentationController,
            let popoveConfigurationHandler = popoveConfigurationHandler {
            popoveConfigurationHandler(popoverPresentationController)
        } else {
            assertionFailure("Please, pass PopoveConfigurationHandler, because it is required in your case of presentation")
        }
        present(alertController, animated: true, completion: completion)
    }
    
}
