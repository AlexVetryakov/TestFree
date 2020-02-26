//
//  Alertable.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit

protocol Alertable {
    func showAlert(title: String?, message: String?)
    func showAlertWthTextField(title: String?, message: String?, complition: @escaping (String?) -> Void)
}

extension Alertable where Self: UIViewController {

    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: L10n.alertButtonOkTitle, style: .cancel, handler: nil)
        alertController.addAction(close)

        present(alertController, animated: true, completion: nil)
    }

    func showAlertWthTextField(title: String?, message: String?, complition: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)

        alertController.addAction(UIAlertAction(
            title: L10n.alertButtonOkTitle,
            style: .default,
            handler: { [weak alertController] _ in
                if let textField = alertController?.textFields?[0] {
                    complition(textField.text)
                }
            })
        )

        let closeAlertAction = UIAlertAction(title: L10n.alertButtonCancelTitle, style: .cancel, handler: nil)
        alertController.addAction(closeAlertAction)

        present(alertController, animated: true, completion: nil)
    }
}
