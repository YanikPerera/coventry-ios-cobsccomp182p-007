//
//  ViewController.swift
//  YanikPerera-cobsccomp182p-007
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnHome: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnSignin: UIButton!
    
    override func viewDidLoad() {
         styleElements()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func styleElements(){
       
        Utility.btnButtonStyles(btnHome)
        Utility.btnButtonStyles(btnLogin)
        Utility.btnButtonStyles(btnSignin)
        
    }

}

