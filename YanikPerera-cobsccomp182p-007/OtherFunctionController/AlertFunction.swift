//
//  AlertFunction.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import Foundation
import UIKit

class AlertFunction {
    func showAlert(title: String,message: String,buttonText: String)  {
        let Alert = UIAlertView()
        Alert.title = title
        Alert.message = message
        Alert.addButton(withTitle: buttonText)
        Alert.show()
    }
}
