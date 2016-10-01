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
    
    var tipPercentages = [0.12, 0.15, 0.18, 0.20];
    override func viewDidLoad() {
        super.viewDidLoad()
        //bring bill amount text field in focus
        billTextField.becomeFirstResponder();
        let intValue = getDefaultTipSelectedIndex();
        selectedTip.selectedSegmentIndex = intValue
        let defaults = UserDefaults.standard;
        defaults.set(selectedTip.titleForSegment(at: 0), forKey: "firstTab");
        defaults.set(selectedTip.titleForSegment(at: 1), forKey: "secondTab");
        defaults.set(selectedTip.titleForSegment(at: 2), forKey: "thirdTab");
        defaults.set(selectedTip.titleForSegment(at: 3), forKey: "fourthTab");
        defaults.set(false, forKey: "nightMode");
        defaults.synchronize();
        
        getBillDetailsFromUserDefaults();
        setSegmentMentedControlTextAndPercentage();
        setUserScreenMode();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calculateTip(_ sender: AnyObject) {
        
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
        setSegmentMentedControlTextAndPercentage();
        setUserScreenMode();
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
        if let savedBillAmount = defaults.string(forKey: "billAmount"){
            if let savedTimeDate = defaults.object(forKey: "savedAtTime"){
                let savedTime = savedTimeDate as! NSDate
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
    }
    
    func setSegmentMentedControlTextAndPercentage(){
        
        let defaults = UserDefaults.standard;
        let firstTab = defaults.string(forKey: "firstTab");
        let firstTabToNumber = firstTab?.replacingOccurrences(of: "%", with: "");
        selectedTip.setTitle(firstTab, forSegmentAt: 0);
        tipPercentages[0] = (Double(firstTabToNumber!))!/100;
        
        let secondTab = defaults.string(forKey: "secondTab");
        let secondTabToNumber = secondTab?.replacingOccurrences(of: "%", with: "");
        selectedTip.setTitle(secondTab, forSegmentAt: 1);
        tipPercentages[1] = (Double(secondTabToNumber!))!/100;
        
        let thirdTab = defaults.string(forKey: "thirdTab");
        let thirdTabToNumber = thirdTab?.replacingOccurrences(of: "%", with: "");
        selectedTip.setTitle(thirdTab, forSegmentAt: 2);
        tipPercentages[2] = Double(thirdTabToNumber!)!/100;
        
        let fourthTab = defaults.string(forKey: "fourthTab");
        let fourthTabToNumber = fourthTab?.replacingOccurrences(of: "%", with: "");
        selectedTip.setTitle(fourthTab, forSegmentAt: 3);
        tipPercentages[3] = Double(fourthTabToNumber!)!/100;
    }
    
    func setUserScreenMode(){
        
        let defaults = UserDefaults.standard;
        let nightMode = defaults.bool(forKey: "nightMode");
        if (nightMode) {
            view.backgroundColor = UIColor.black;
            tipLabel.textColor = UIColor.white;
            totalField.textColor = UIColor.white;
            billTextField.textColor = UIColor.white;
            billTextField.backgroundColor = UIColor.black;
            selectedTip.backgroundColor = UIColor.black;
            selectedTip.tintColor = UIColor.white;
        }
        else {
            view.backgroundColor = UIColor.white;
            tipLabel.textColor = UIColor.black;
            totalField.textColor = UIColor.black;
            billTextField.textColor = UIColor.white;
            billTextField.backgroundColor = UIColor.white;
            selectedTip.backgroundColor = UIColor.white;
            selectedTip.tintColor = UIColor.blue;
        }
    }
    
    
}

