//
//  SettingsViewController.swift
//  TipCalculatorSlider
//
//  Created by Brandon Sanchez on 12/9/15.
//  Copyright © 2015 Brandon Sanchez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipStepper: UIStepper!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var defaultTipLabel: UILabel!
    var defaultTip: Double!
    let defaults = NSUserDefaults.standardUserDefaults()
    var pickerData: String!
    
    
   
    
    //let switchState = true
    let switchState = "switchState"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let tipLabel = defaults.integerForKey("stepperLabel").description
        defaultTipLabel.text = "\(tipLabel)%"
        
        
        
        
        roundSwitch.on =  NSUserDefaults.standardUserDefaults().boolForKey("switchState")
        
        roundSwitch.addTarget(self, action: Selector("roundSwitchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        let tipLabel = defaults.integerForKey("stepperLabel").description
        defaultTipLabel.text = "\(tipLabel)%"
        tipStepper.value = defaults.doubleForKey("stepperLabel")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func roundSwitchChanged(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(roundSwitch.on, forKey: "switchState")
    }
    
    @IBAction func tipStepperChanged(sender: AnyObject) {
        defaultTipLabel.text = "\(Int(tipStepper.value))%"
        
        let tip: Double! = tipStepper.value / 100
        let tip2:Float! = Float(tipStepper.value)
        let tip3: Int! = Int(tipStepper.value)
        defaults.setInteger(tip3, forKey: "stepperLabel")
        defaults.setFloat(tip2, forKey: "stepperValue")
        defaults.setDouble(tip, forKey: "tipDefault")
        //var stepperValueChanged = tipStepper.value
        
    }



    
    

    
       
        
    }

