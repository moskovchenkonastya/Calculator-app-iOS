//
//  ViewController.swift
//  calculater_new
//
//  Created by Anastasiya Moskovchenko on 01.12.16.
//  Copyright © 2016 Anastasiya Moskovchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    
    var userIsInTheMiddleofTyping: Bool = false
    
    @IBAction func TouchDigit(_ sender: UIButton){
      
        let digit = sender.currentTitle!
        if userIsInTheMiddleofTyping {
            let textCurrentlyInDisplay = display!.text!
            display.text = textCurrentlyInDisplay + digit
        } else{
            display.text = digit
        }
         userIsInTheMiddleofTyping = true
    }
    
    var displayValue: Double{
        
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    
    }

    private var brain = CalculaterBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleofTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleofTyping = false
        }
        if let mathematicalSymbol =  sender.currentTitle {
            
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
}
