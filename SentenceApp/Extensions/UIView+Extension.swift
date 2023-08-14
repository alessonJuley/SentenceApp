//
//  UIView+Extension.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/06/23.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}

