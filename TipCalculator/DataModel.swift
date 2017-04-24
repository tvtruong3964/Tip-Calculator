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
    
    var tipPercent: Float {
        get {
            return UserDefaults.standard.float(forKey: "TipPercent")
        } set {
            UserDefaults.standard.set(newValue, forKey: "TipPercent")
            UserDefaults.standard.synchronize()
        }
    }
    
    var split: Float {
        get {
            return UserDefaults.standard.float(forKey: "Split")
        } set {
            UserDefaults.standard.set(newValue, forKey: "Split")
            UserDefaults.standard.synchronize()
        }
    }
    var billingAmount: Float {
        get {
            return UserDefaults.standard.float(forKey: "BillingAmount")
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
    
    
    var indexTheme: Int {
        get {
            return UserDefaults.standard.integer(forKey: "IndexTheme")
        } set {
            UserDefaults.standard.set(newValue, forKey: "IndexTheme")
            UserDefaults.standard.synchronize()
        }
    }

    
    init() {
        registerDefaults()
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["TipPercent": 5, "BillingAmount": 0.00, "PreviousTime": 0, "Split": 1, "IndexTheme": 0]
        UserDefaults.standard.register(defaults: dictionary)
    }

    
}
