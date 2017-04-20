//
//  DataModel.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/20/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import Foundation
import UIKit
class DataModel {
    var isLoadBillingAmount = false
    
    var indexOfSegment: Int {
        get {
            return UserDefaults.standard.integer(forKey: "IndexOfSegment")
        } set {
            UserDefaults.standard.set(newValue, forKey: "IndexOfSegment")
            UserDefaults.standard.synchronize()
        }
    }
    var billingAmount: Double {
        get {
            return UserDefaults.standard.double(forKey: "BillingAmount")
        } set {
            UserDefaults.standard.set(newValue, forKey: "BillingAmount")
            UserDefaults.standard.synchronize()
        }
        
    }
    var previousTime: Double {
        get {
            return UserDefaults.standard.double(forKey: "PreviousTime")
        } set {
            UserDefaults.standard.set(newValue, forKey: "PreviousTime")
            UserDefaults.standard.synchronize()
        }
        
    }

    
    init() {
        registerDefaults()
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["IndexOfSegment": 0, "BillingAmount": 0.00, "PreviousTime": 0]
        UserDefaults.standard.register(defaults: dictionary)
    }

    
}
