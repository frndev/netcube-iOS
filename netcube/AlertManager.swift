//
//  AlertManager.swift
//  netcube
//
//  Created by fran on 26/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class AlertManager {
    
    let parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func alertDefaultWith(_ title: String?,
                          message msg: String?,
                          alertTitle: String) {
        
        let alertController = UIAlertController(title: title!,
                                                message: msg!,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: alertTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.parentViewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func alertDefaultWith(_ title: String?,
                          message msg: String?,
                          alertTitle: String,
                          callback: @escaping (UIAlertAction)->Void) {
    
        let alertController = UIAlertController(title: title!,
                                                message: msg!,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: alertTitle, style: .default, handler:callback)
        
        alertController.addAction(defaultAction)
        self.parentViewController.present(alertController, animated: true, completion: nil)
    }
    
    func alertConfirmationWith(_ title: String?,
                               message msg: String?,
                               alertTitle: String,
                               cancellCallback: @escaping (UIAlertAction)->Void,
                               confirmationCallback: @escaping (UIAlertAction)->Void) {
        
        let alertController = UIAlertController(title: title!,
                                                message: msg!,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancellCallback)
        let defaultAction = UIAlertAction(title: alertTitle, style: .destructive, handler:confirmationCallback)
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        self.parentViewController.present(alertController, animated: true, completion: nil)
    }

    
}
    
