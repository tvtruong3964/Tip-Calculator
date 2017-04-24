//
//  Them.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/21/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import UIKit
//let selectedThemKey = "SelectedThemKey"
var dataModel = DataModel()
enum Theme: Int {
    case Default, Light, Dark
    
    var mainTinColor: UIColor{
        switch self {
        case .Default:
            return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 155.0/255.0, green: 226.0/255.0, blue: 131.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 240.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 169.0/255.0, green: 255.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 169.0/255.0, green: 255.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor.white
        }
    }
    
    
    var viewColor: UIColor {
        switch self {
        case .Default:
            return UIColor.white
        case .Light:
            return UIColor.white
        case .Dark:
            return UIColor(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)

        }
    }
    
    
    var navigationColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 175.0/255.0, green: 255.0/255.0, blue: 149.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)
            
        }
    }
    
    var backgroundTextColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 155.0/255.0, green: 226.0/255.0, blue: 131.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor.white
        case .Dark:
            return UIColor(red: 104.0/255.0, green: 104.0/255.0, blue: 104.0/255.0, alpha: 1.0)
            
        }
    }
    
    var backgroundCellColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor.white
        case .Dark:
            return UIColor(red: 104.0/255.0, green: 104.0/255.0, blue: 104.0/255.0, alpha: 1.0)
            
        }
    }
    
    var sliderThumTint: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 155.0/255.0, green: 226.0/255.0, blue: 131.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 74.0/255.0, green: 218.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            
        }
    }
    
    var sliderMinTrack: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
    }
    
    var buttonBarColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
    }
    
    var isDark: Bool {
        switch self {
        case .Default, .Light:
            return false
        case .Dark:
            return true
        }
    }
    
    var settingIcon: UIImage? {
        switch self {
        case .Default, .Light:
            if let settingIcon = UIImage(named: "SettingsLight") {
                return settingIcon
            } else {
                return nil
            }
        case .Dark:
            if let settingIcon = UIImage(named: "SettingDark") {
                return settingIcon
            } else {
                return nil
            }
        }
    }
    
    
    
}



struct ThemManager {
    static func currentThem(index: Int) -> Theme {
        if let theme =  Theme(rawValue: index) {
            print("theme: \(theme)")
            return theme
        } else {
            return .Default
        }
    }
    
    
    static func applyThem(theme: Theme){
//        UserDefaults.standard.set(theme.rawValue, forKey: selectedThemKey)
//        UserDefaults.standard.synchronize()
//        
        let shareApplication = AppDelegate.getAppDelegate()
        shareApplication.window?.tintColor = theme.mainTinColor
        UILabel.appearance().textColor = theme.mainTinColor
        UINavigationBar.appearance().barTintColor = theme.navigationColor
        UISlider.appearance().thumbTintColor = theme.sliderThumTint
        UISlider.appearance().tintColor = theme.sliderMinTrack
        
        UITableViewCell.appearance().backgroundColor = theme.backgroundCellColor
        UINavigationBar.appearance().tintColor = theme.buttonBarColor
        
        //UINavigationBar.appearance().tintColor = theme.mainTinColor
        
       // shareApplication.window?.tintColor = UIColor.white
        //UISlider.appearance().tintColor = UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        
    }
}

