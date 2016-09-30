//
//  ViewController.swift
//  tipper
//
//  Created by Harsh Trivedi on 9/29/16.
//  Copyright © 2016 Harsh Trivedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalField: UILabel!
    
    @IBOutlet weak var selectedTip: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bring bill amount text field in focus
        billTextField.becomeFirstResponder();
        let defaults = UserDefaults.standard;
        let intValue = defaults.integer(forKey: "defaultTip");
        selectedTip.selectedSegmentIndex = intValue

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.12, 0.15, 0.18, 0.20];
        let billAmount = Double(billTextField.text!) ?? 0.00;
        let tipAmount = billAmount * tipPercentages[selectedTip.selectedSegmentIndex];
        
        let totalAmount = billAmount + tipAmount;
        
        tipLabel.text = String(format: "%.2f", tipAmount);
        totalField.text = String(format: "%.2f", totalAmount);
    
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard;
        let intValue = defaults.integer(forKey: "defaultTip");
        selectedTip.selectedSegmentIndex = intValue;
    }
}

