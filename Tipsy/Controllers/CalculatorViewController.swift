//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipAmount = 0.0
    var numberOfPeople = 2.0
    var totalPerPerson = 0.0

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        let tipWithoutPercentSign = (sender.currentTitle?.dropLast())!
        let tipAsANumber = Double(tipWithoutPercentSign)
        tipAmount = tipAsANumber! / 100
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = sender.value
        splitNumberLabel.text = String(format: "%.0f", numberOfPeople)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billEntered = billTextField.text!
        let billEnteredAsANumber = Double(billEntered)!
        let totalBill = billEnteredAsANumber * (1 + tipAmount)
        totalPerPerson = totalBill / numberOfPeople
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            let totalPPString = String(format: "%.2f", totalPerPerson)
            destinationVC.totalPerPerson = totalPPString
            destinationVC.split = Int(numberOfPeople)
            destinationVC.tip = Int(tipAmount * 100)
        }
    }
}

