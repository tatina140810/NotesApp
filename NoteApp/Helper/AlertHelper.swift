//
//  AllertHelper.swift
//  NoteApp
//
//  Created by Tatina Dzhakypbekova on 14/5/24.
//

import Foundation
import UIKit
enum AlertActions{
    case action1
    case action2
    
}

class AlertHelper {
    func showAlert(title: String, message: String, style: UIAlertController.Style, prexentingView: UIViewController, completionHandler: @escaping (AlertActions) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionOne = UIAlertAction(title: "Да", style: .cancel) {action in
            completionHandler(.action1)
        }
        let actionTwo = UIAlertAction(title: "Нет", style: .default) {action in
            completionHandler(.action2)
        }
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        prexentingView.present(alertController, animated: true)
    }
    func showAlertWithOneAction(title: String, message: String, style: UIAlertController.Style, prexentingView: UIViewController, completionHandler: @escaping (AlertActions) -> Void){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionOne = UIAlertAction(title: "ok", style: .cancel) { action in
            completionHandler(.action1)
        }
        alertController.addAction(actionOne)
        prexentingView.present(alertController, animated: true)
            
        }
        
    }
    
