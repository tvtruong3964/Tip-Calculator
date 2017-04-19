//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/18/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingSegment: UISegmentedControl!
    
    let dictionary: [String: Any] = ["ValueDefault": 0]
    var indexSegmentDefault = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.register(defaults: dictionary)
        
        indexSegmentDefault = UserDefaults.standard.integer(forKey: "ValueDefault")
        
        switch indexSegmentDefault {
        case 0...2:
            settingSegment.selectedSegmentIndex = indexSegmentDefault
        default:
            settingSegment.selectedSegmentIndex = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func configureTheDefaultTip() {
        //print("selectSegementIndex is: \(settingSegment.selectedSegmentIndex)")
        UserDefaults.standard.set(settingSegment.selectedSegmentIndex, forKey: "ValueDefault")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
