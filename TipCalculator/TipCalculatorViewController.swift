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
    
    var indexSegmentDefault = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billingText.becomeFirstResponder()
        indexSegmentDefault = UserDefaults.standard.integer(forKey: "ValueDefault")
       // print("indexSegmentDefault: \(indexSegmentDefault)")
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        billingText.resignFirstResponder()
        
    }
    
    @IBAction func calculatorTip() {
        let tipPercentages = [0.15, 0.20, 0.25]
        if let bill = Double(billingText.text!) {
            let tip = bill * tipPercentages[tipSegment.selectedSegmentIndex]
            let total = bill + tip
            tipLabel.text = String(format: "$%0.2f", tip)
            totalLabel.text = String(format: "$%0.2f", total)
            
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

    
    

}

