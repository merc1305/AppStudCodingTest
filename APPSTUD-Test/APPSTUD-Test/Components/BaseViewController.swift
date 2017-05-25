//
//  BaseViewController.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {}
    
    func showLoadingIndicator() {}
    
    func hideLoadingIndicator() {}
    
    @objc
    func startRequestService() {}
    
}
