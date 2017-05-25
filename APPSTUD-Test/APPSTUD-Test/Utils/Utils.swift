//
//  Utils.swift
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

import Foundation

class Utils {
    class func runOnMainThread(_ block_: ()->()) {
        if Thread.isMainThread {
            block_()
        } else {
            DispatchQueue.main.sync(execute: {
                block_()
            })
        }
    }
}

