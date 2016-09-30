//
//  SettingsViewController.swift
//  tipper
//
//  Created by Harsh Trivedi on 9/29/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fetch default selected index from user defaults
        //set the default tip to 15 %
        defaultTip.selectedSegmentIndex = 1;
        let defaults = UserDefaults.standard;
        
        
        let intValue = defaults.integer(forKey: "defaultTip")
        
            defaultTip.selectedSegmentIndex = intValue;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func defaultTipValueChanged(_ sender: AnyObject) {
        //get the NSUserDefaults
        let defaults = UserDefaults.standard;
        //set default tip
        defaults.set(defaultTip.selectedSegmentIndex, forKey:"defaultTip");
        defaults.synchronize();
    }

}
