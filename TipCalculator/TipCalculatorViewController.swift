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
    
    @IBOutlet weak var splitSlider: UISlider!
   // var indexSegmentDefault = 0
    var dataModel: DataModel!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billingText.becomeFirstResponder()
        
        //load default segment
        let indexSegmentDefault = dataModel.indexOfSegment

        switch indexSegmentDefault {
        case 0...2:
            tipSegment.selectedSegmentIndex = indexSegmentDefault
        default:
            tipSegment.selectedSegmentIndex = 0
        }
        
        calculatorTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // load billing Amount
        if dataModel.isLoadBillingAmount {
            let billingAmount = dataModel.billingAmount
            if billingAmount == 0 {
                billingText.text = ""
            } else {
                billingText.text = String(format: "%0.2f", billingAmount)
            }
        } else {
            billingText.text = ""
            dataModel.billingAmount = 0
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSetting" {
            let navigationControll = segue.destination as! UINavigationController
            let controller = navigationControll.topViewController
            as! SettingsViewController
            controller.dataModel = dataModel
        }
    }
    

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        billingText.resignFirstResponder()
        
    }
    
    @IBAction func calculatorTip() {
        print("*** go to calculatorTip")
        let tipPercentages = [0.15, 0.20, 0.25]
        if let valueText = billingText.text,
            let value = numberFormatter.number(from: valueText) {
            
            let billingAmount = value.doubleValue
            let tip = billingAmount * tipPercentages[tipSegment.selectedSegmentIndex]
            let total = billingAmount + tip
            tipLabel.text = String(format: "$%0.2f", tip)
            totalLabel.text = String(format: "$%0.2f", total)
            
            // save billing amount
            dataModel.billingAmount = billingAmount
            
        } else{
            tipLabel.text = "$0"
            totalLabel.text = "$0"
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    let step: Float = 10
    @IBAction func test (){
        let roundedValue = round(splitSlider.value / step) * step
        splitSlider.value = roundedValue
        print("\(splitSlider.value)")
        
    }
    

}

