//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/17/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataModel = DataModel()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let theme = ThemManager.currentThem(index: dataModel.indexTheme)
        ThemManager.applyThem(theme: theme)
        
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! TipCalculatorViewController
        
        controller.dataModel = dataModel
        
        
        
        let now = Date.timeIntervalSinceReferenceDate
        // update isLoadBillingAmount
        dataModel.isLoadBillingAmount =  (now - dataModel.previousTime) < (10) // Ten minutes
        
        
        // load billing Amount
        if (now - dataModel.previousTime) > (60*10) {
            dataModel.billingAmount = 0 // reset billing amount
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("*** applicationWillResignActive")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // update previous time
        print("*** applicationDidEnterBackground")
        dataModel.previousTime = Date.timeIntervalSinceReferenceDate
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("*** applicationWillEnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("*** applicationDidBecomeActive")
          

    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("*** applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


}

