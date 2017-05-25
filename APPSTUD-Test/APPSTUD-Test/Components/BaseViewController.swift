//
//  BaseViewController.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {}
    
    func showLoadingIndicator() {
        SVProgressHUD.show()
    }
    
    func hideLoadingIndicator() {
        SVProgressHUD.dismiss()
    }
    
    @objc
    func startRequestService() {
        if !isReacheble {
            showAlertWithTitle(message: "No internet connection")
            return
        }
    }
    
    @objc
    func startRequestByName() {
        if !isReacheble {
            showAlertWithTitle(message: "No internet connection")
            return
        }
    }
    
    var isReacheble: Bool {
        if let isReachable = Alamofire.NetworkReachabilityManager()?.isReachable {
            return isReachable
        }
        else{
            return false
        }
    }
    
    private func showAlertWithTitle(_ title: String = "Error", message mess: String,
                            okButton ok: String? = nil, okHandler: ((UIAlertAction) -> Void)? = nil,
                            closeButton close: String? = nil, closeHandler: ((UIAlertAction) -> Void)? = nil,
                            otherButton other: String? = nil, otherHandler: ((UIAlertAction) -> Void)? = nil,
                            completionHanlder completion: (()-> Void)? = nil) -> Void {
        let alertVC = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        
        if let ok = ok{
            let okAction = UIAlertAction(title: ok, style: .default, handler: okHandler)
            alertVC.addAction(okAction)
        }
        
        if let close = close{
            let closeAction = UIAlertAction(title: close, style: .default, handler: closeHandler)
            alertVC.addAction(closeAction)
        }
        
        if let other = other {
            let otherAction = UIAlertAction(title: other, style: .cancel, handler: otherHandler)
            alertVC.addAction(otherAction)
        }
        
        if close == nil && ok == nil && other == nil {
            let defaultAction = UIAlertAction(title: "Close", style: .cancel, handler: closeHandler)
            alertVC.addAction(defaultAction)
        }
        
        self.present(alertVC, animated: true, completion: completion)
    }
    
}
