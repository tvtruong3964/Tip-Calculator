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
    
    var dataModel: DataModel!

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let indexSegmentDefault = dataModel.indexOfSegment
        
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
        dataModel.indexOfSegment =  settingSegment.selectedSegmentIndex
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
