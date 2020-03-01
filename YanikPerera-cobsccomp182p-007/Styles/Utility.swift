//
//  File.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/27/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//
import Foundation
import UIKit

class Utility {
    
    static func btnButtonStyles(_ button:UIButton) {
        
        button.backgroundColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
        
        
    }
    static func btnButtonStylesRed(_ button:UIButton) {
        
        button.backgroundColor = UIColor.init(red: 255/255, green: 45/255, blue: 33/255, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
        
        
    }
    
    static func txtTextFieldStyles(_ textfield:UITextField) {
        
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
        textfield.layer.cornerRadius = 10
        textfield.tintColor = UIColor.gray
        
        
        
    }
    
}
