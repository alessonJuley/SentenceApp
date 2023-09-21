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
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat){
        let border = CALayer()
        border.backgroundColor = color.cgColor
        // width: self.frame.size.width - (left and right constraint value)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 15, height: width)
        self.layer.addSublayer(border)
    }
}

