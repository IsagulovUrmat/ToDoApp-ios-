//
//  BaseNavigationController.swift
//  SimpleToDoApp
//
//  Created by Isagulov urmat on 17/7/22.
//

import UIKit

class BaseNavigationController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
