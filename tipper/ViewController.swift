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
        let intValue = getDefaultTipSelectedIndex();
        selectedTip.selectedSegmentIndex = intValue
        
        getBillDetailsFromUserDefaults();
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
        setBillDetailsToUserDefaults(billAmount: billTextField.text!, savedAtTime: NSDate());
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let intValue = getDefaultTipSelectedIndex();
        selectedTip.selectedSegmentIndex = intValue;
    }
    
    
    func getDefaultTipSelectedIndex()->Int{
        let defaults = UserDefaults.standard;
        return defaults.integer(forKey: "defaultTip");
    }
    
    //set bill amount and current time to user defaults
    func setBillDetailsToUserDefaults(billAmount:String?, savedAtTime:NSDate){
        if let someBillAmount = billAmount{
        let defaults = UserDefaults.standard;
        defaults.set(someBillAmount, forKey:"billAmount");
        defaults.set(savedAtTime, forKey: "savedAtTime");
        defaults.synchronize();
        }
    }
    
    func getBillDetailsFromUserDefaults(){
        let defaults = UserDefaults.standard;
        let savedBillAmount = defaults.string(forKey: "billAmount");
        let savedTime = defaults.object(forKey: "savedAtTime")as! NSDate;
        switch NSDate().compare(savedTime.addingTimeInterval(600) as Date) {
        case .orderedAscending:
            billTextField.text = "";
            defaults.removeObject(forKey: "billAmount");
            defaults.removeObject(forKey: "savedAtTime")
        case .orderedDescending, .orderedSame  :
            billTextField.text = savedBillAmount;
            defaults.set(NSDate(), forKey: "savedAtTime");
        }
    }
    
    
}

