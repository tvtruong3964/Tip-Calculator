//
//  SettingTableViewController.swift
//  TipCalculator
//
//  Created by Truong Tran on 4/21/17.
//  Copyright © 2017 Truong Tran. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    
    var dataModel: DataModel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBOutlet weak var defaultCell: UITableViewCell!
    @IBOutlet weak var drankCell: UITableViewCell!
    @IBOutlet weak var lightCell: UITableViewCell!
    
    var themeCell = [UITableViewCell]()
    
    
    let step: Float = 1
    

    var currenThem = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateThem(currenThem: dataModel.indexTheme)
        
        let tipPercentDefault = dataModel.tipPercent
        let splitDefault = dataModel.split
        
        tipPercentLabel.text = String(format: "%0.0f%%", tipPercentDefault)
        splitLabel.text = String(format: "%0.0f", splitDefault)
        
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        themeCell = [defaultCell, drankCell, lightCell]
        
        currenThem = dataModel.indexTheme

        themeCell[currenThem].accessoryType = .checkmark

    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        save()
        
        let hudView = HudView.hud(inView: navigationController!.view, animated: true)
        hudView.text = "Save"
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func configureTheDefaultTip() {
        let roundedValueTip = round(tipSlider.value / step) * step
        let roundedValueSplit = round(splitSlider.value / step) * step
        
        tipSlider.value = roundedValueTip
        splitSlider.value = roundedValueSplit
        
        // update label
        tipPercentLabel.text = String(format: "%0.0f%%", tipSlider.value)
        splitLabel.text = String(format: "%0.0f", splitSlider.value)
        
    }
    func save() {
        dataModel.tipPercent =  tipSlider.value
        dataModel.split =  splitSlider.value
        dataModel.indexTheme = currenThem
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row != currenThem {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
            themeCell[currenThem].accessoryType = .none
            currenThem = indexPath.row
        }
        
        updateThem(currenThem: currenThem)
        
    }
    func updateThem(currenThem: Int) {
        let theme = ThemManager.currentThem(index: currenThem)
        ThemManager.applyThem(theme: theme)
        
        navigationController!.navigationBar.barTintColor = theme.navigationColor
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.mainTinColor]
        navigationController!.navigationBar.tintColor = theme.sliderMinTrack
        view.backgroundColor = theme.backgroundColor
        
        
        tableView.headerView(forSection: 1)?.textLabel?.textColor = view.tintColor
        tableView.headerView(forSection: 0)?.textLabel?.textColor = view.tintColor
        tableView.reloadData()
    }

}
