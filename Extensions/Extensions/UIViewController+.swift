//
//  UIViewController+.swift
//  Extensions
//
//  Created by Yago Marques on 06/09/24.
//

import Foundation
import UIKit

public extension UIViewController {
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
