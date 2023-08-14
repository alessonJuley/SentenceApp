//
//  Functions.swift
//  SentenceApp
//
//  Created by Alesson Abao on 14/08/23.
//

import UIKit

// alert function
func showMessage(message : String, buttonCaption : String, controller : UIViewController)
{
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonCaption, style: .default)
    alert.addAction(action)
    controller.present(alert, animated: true)
}
