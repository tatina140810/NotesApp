//
//  AllertHelper.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 14/5/24.
//

import Foundation
import UIKit

class AlertHelper {
    func showAlert(title: String, message: String, style: UIAlertController.Style, prexentingView: UIViewController, actions: [UIAlertAction] ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions{
            alertController.addAction(action)
        }
        prexentingView.present(alertController, animated: true)
    }
    
}
