//
//  SettingsViewController.swift
//  tipper
//
//  Created by Harsh Trivedi on 9/29/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstTab: UITextField!
    
    @IBOutlet weak var secondTab: UITextField!
    
    @IBOutlet weak var thirdTab: UITextField!
    
    @IBOutlet weak var FourthTab: UITextField!
    
    @IBOutlet weak var nightModeSwitch: UISwitch!
    
    @IBOutlet weak var roundToFullDollarSwitch: UISwitch!
    
    
    @IBOutlet weak var NoTipOnTax: UISwitch!
    
    
    
    
    @IBOutlet weak var defaultTip: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fetch default selected index from user defaults
        //set the default tip to 15 %
        defaultTip.selectedSegmentIndex = 1;
        let defaults = UserDefaults.standard;
        
        
        let intValue = defaults.integer(forKey: "defaultTip")
        
        nightModeSwitch.setOn(defaults.bool(forKey: "nightMode"), animated: true);
        print(defaults.bool(forKey: "roundToFullDollar"));
        print(defaults.bool(forKey:"noTipOnTax"));
        
        roundToFullDollarSwitch.setOn(defaults.bool(forKey: "roundToFullDollar"), animated: true);
        
        NoTipOnTax.setOn(defaults.bool(forKey: "noTipOnTax"), animated: true);
        
        defaultTip.selectedSegmentIndex = intValue;
        
        defaults.set(firstTab.text! + "%", forKey: "firstTab");
        defaults.set(secondTab.text! + "%", forKey: "secondTab");
        defaults.set(thirdTab.text! + "%", forKey: "thirdTab");
        defaults.set(FourthTab.text! + "%", forKey: "fourthTab");
        defaults.synchronize();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tabValueChanged(_
        sender: AnyObject) {
        
        let defaults = UserDefaults.standard;
        defaults.set(firstTab.text, forKey: "firstTab");
        defaults.set(secondTab.text, forKey: "secondTab");
        defaults.set(thirdTab.text, forKey: "thirdTab");
        defaults.set(FourthTab.text, forKey: "fourthTab");
        defaults.synchronize();
    }
   
    @IBAction func defaultTipValueChanged(_ sender: AnyObject) {
        //get the NSUserDefaults
        let defaults = UserDefaults.standard;
        //set default tip
        defaults.set(defaultTip.selectedSegmentIndex, forKey:"defaultTip");
        defaults.synchronize();
    }

    @IBAction func nightModeSwitchChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(nightModeSwitch.isOn, forKey: "nightMode");
    }
    @IBAction func NoTipOnTaxChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(NoTipOnTax.isOn, forKey: "noTipOnTax");
    }
    
    @IBAction func roundToFullDollarChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(roundToFullDollarSwitch.isOn, forKey: "roundToFullDollar");
        
        print(defaults.bool(forKey: "roundToFullDollar"));
    }
    
}
