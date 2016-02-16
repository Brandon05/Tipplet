//
//  ViewController.swift
//  TipCalculatorSlider
//
//  Created by Brandon Sanchez on 12/7/15.
//  Copyright © 2015 Brandon Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var splitButton: UIButton!
    @IBOutlet weak var splitPicker: UIPickerView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    var tipPercentage: Double!
    var billAmount: Double!
    var split: Double!
    var pickerDataSource = ["1", "2", "3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    var splitDataSource = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]
    var tip: Double!
    var total: Double!
    let defaults = NSUserDefaults.standardUserDefaults()
    var tipRound: Double? {
        return round(tip)
    }
    var totalRound: Double? {
        return round(total) / split
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.splitPicker.dataSource = self;
        self.splitPicker.delegate = self;
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let tipLabelText = defaults.integerForKey("stepperLabel").description
        tipPercentageLabel.text = "\(tipLabelText)%"
        //prevent tipPercentage from being nil before user interaction
        tipPercentage = defaults.doubleForKey("tipDefault")
        split = 1.0
        splitPicker.hidden = true
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        self.tipSlider.value = defaults.floatForKey("stepperValue")
        let tipPercLabelText = defaults.integerForKey("stepperLabel").description
        tipPercentageLabel.text = "\(tipPercLabelText)%"
        //prevent tipPercentage from being nil before user interaction
        tipPercentage = defaults.doubleForKey("tipDefault")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    //splitPicker functions
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    @IBAction func splitButtonChanged(sender: AnyObject) {
        splitPicker.hidden = false
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        splitLabel.text = pickerDataSource[row]
        split = splitDataSource[row]
        onEditingChanged(splitPicker)
    }
    
    
// tipSlider function; changes tipLabel and establishes tipPercentage
    
    let step: Float = 1
    
    @IBAction func tipSliderChanged(sender: UISlider) {
        
        let roundedValue = round(sender.value / step) * step
            sender.value = roundedValue
        
        tipPercentage = Double(sender.value) * 0.01
        tipPercentageLabel.text = ("\(tipPercentage! * 100)%")
        tipPercentageLabel.text = String(format: "%.0f%%", tipPercentage! * 100)
    }
   
    // Main Function; when billField editing change
   
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var billAmount = Double(billField.text!)
        if billAmount != nil {      //Prevent nil crash in billField
            
            billAmount = Double(billField.text!)
            tip = (billAmount! * tipPercentage!)
            total = (billAmount! + tip) / split
            
       //switch state function
            
        if defaults.boolForKey("switchState") == true {
        
            tip = round(tip)
            total = round(total)
        
        }
        
            tipLabel.text = "$\(tip)"
            totalLabel.text = "$\(total)"
            
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        } else {
            tipLabel.text = "$0.00"
            totalLabel.text = "$0.00"
        }
    }
    
       @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
           //Reloading totals after switch state
           tipPercentage = defaults.doubleForKey("tipDefault")
           
            let billAmount = Double(billField.text!)
            
            if defaults.boolForKey("switchState") == true && billAmount != nil {
                //tipRound = ceil(billAmount! * tipPercentage!)
                //totalRound = ceil(billAmount! + tip) / split
                
                self.tipLabel.text = "$\(tipRound)"
                self.totalLabel.text = "$\(totalRound)"
                
                tipLabel.text = String(format: "$%.2f", tipRound!)
                totalLabel.text = String(format: "$%.2f", totalRound!)
               
            } else if billAmount != nil && defaults.boolForKey("switchState") == false {
                
                tip = (billAmount! * tipPercentage!)
                total = (billAmount! + tip) / split
                
                tipLabel.text = "$\(tip)"
                totalLabel.text = "$\(total)"
                
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
               
            } else {
                
                tipLabel.text = "$0.00"
                totalLabel.text = "$0.00"
               
            }
        }
 
        //Dissmiss Keyboard onTap
    
        @IBAction func keyboardDismiss(sender: AnyObject) {
        
        view.endEditing(true)
        splitPicker.hidden = (true)
        }

}

