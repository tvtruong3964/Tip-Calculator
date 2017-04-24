//
//  ViewController.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/17/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import UIKit


class TipCalculatorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var billingText: UITextField!

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!

    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var splitSlider: UISlider!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var lineView3: UIView!
    @IBOutlet weak var lineView4: UIView!
    
    @IBOutlet weak var settingButton: UIBarButtonItem!
    
   // var indexSegmentDefault = 0
    var dataModel: DataModel!
    let step: Float = 1
    
    let numberFormatterSpecificCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
  
    var numberFormatter: NumberFormatter  = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
       // formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateThem()
        
        billingText.becomeFirstResponder()
        
        if let currencySymbol = Locale.current.currencySymbol {
            billingText.placeholder = currencySymbol
        }
        
        
        
        let billingAmount = dataModel.billingAmount
        if billingAmount == 0 {
            billingText.text = ""
        } else {
            billingText.text = numberFormatter.string(from: NSNumber(value: billingAmount))
        }
        
        
        
        
        let tipPercentDefault = dataModel.tipPercent
        let splitDefault = dataModel.split
        
        switch tipPercentDefault {
        case 0...30:
            tipSlider.value = tipPercentDefault
        default:
            tipSlider.value = 5
        }
        
        switch splitDefault {
        case 0...10:
            splitSlider.value = splitDefault
        default:
            splitSlider.value = 1
        }
        
        calculatorTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSetting" {
            let navigationControll = segue.destination as! UINavigationController
            let controller = navigationControll.topViewController
            as! SettingTableViewController
            controller.dataModel = dataModel
        }
        
    }
    

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        billingText.resignFirstResponder()
        
    }
    
    @IBAction func test (){
        let roundedValue = round(splitSlider.value / step) * step
        splitSlider.value = roundedValue
        print("\(splitSlider.value)")
        
    }
    
    @IBAction func calculatorTip() {
        let roundedValueTip = round(tipSlider.value / step) * step
        let roundedValueSplit = round(splitSlider.value / step) * step
        
        tipSlider.value = roundedValueTip
        splitSlider.value = roundedValueSplit
        
        // update label
        tipPercentLabel.text = String(format: "%0.0f%%", tipSlider.value)
        splitLabel.text = String(format: "%0.0f", splitSlider.value)
        
        let tipPercentages = tipSlider.value / 100
        
        formatterTextFieldWithGroupingSeparator()
        
        if let textWithoutGroupingSeparator = billingText.text?.replacingOccurrences(of: Locale.current.groupingSeparator!, with: ""), let number = numberFormatter.number(from: textWithoutGroupingSeparator) {
            
            let amount = number.floatValue
            
            
            let tip = amount * tipPercentages
            let total = amount + tip
            let splitTotal = total / splitSlider.value
            
          //  print("total : \(total)")
            
            tipLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: tip))
            totalLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: total))
            splitTotalLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: splitTotal))

            
            // save billing amount
            dataModel.billingAmount = amount
            
            
        } else{
            tipLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: 0))
            totalLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: 0))
            splitTotalLabel.text = numberFormatterSpecificCurrency.string(from: NSNumber(value: 0))
            dataModel.billingAmount = 0
        }
    }
    
    func formatterTextFieldWithGroupingSeparator() {
        if  let textWithoutGroupingSeparator = billingText.text?.replacingOccurrences(of: Locale.current.groupingSeparator!, with: "") {
            // skip symbol decimalSeparator
            if (textWithoutGroupingSeparator.range(of: Locale.current.decimalSeparator!) == nil) {
                if let textNumber = numberFormatter.number(from: textWithoutGroupingSeparator) {
                    let textNumberWithGroupingSeparator = numberFormatter.string(from: textNumber)
                    billingText.text = textNumberWithGroupingSeparator
                }
            }
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if let text = textField.text {
            print("textField: \(text)")
        }
        
        
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    func updateThem() {
        let theme = ThemManager.currentThem(index: dataModel.indexTheme)
        ThemManager.applyThem(theme: theme)
        
        view.backgroundColor = theme.backgroundColor
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.mainTinColor]
        
        
        firstView.backgroundColor = theme.viewColor
        secondView.backgroundColor = theme.viewColor
        billingText.textColor = theme.mainTinColor
        if let icon = theme.settingIcon {
            settingButton.image = icon
        }
        
        
        billingText.backgroundColor = theme.backgroundTextColor
        
        if theme.isDark {
            billingText.keyboardAppearance = .dark
        } else {
            billingText.keyboardAppearance = .light
        }
        
    }
    

}

