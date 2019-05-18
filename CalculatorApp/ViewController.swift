//
//  ViewController.swift
//  CalculatorApp
//
//  Created by admin on 18/05/2019.
//  Copyright © 2019 durbaezgomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    enum operation {
        case plus, minus, mult, div, none
    }
    
    var numberOnScreen:Double = 0
    var numberInMemory:Double? = nil
    var currentOperation: operation?

    @IBAction func numbers(_ sender: UIButton) {
        
        if( 0 < sender.tag && sender.tag < 11 ){
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
        }
        else{
            if(numberOnScreen.truncatingRemainder(dividingBy: 1) == 0){
                label.text = label.text! + "."
                numberOnScreen = Double(label.text!)!
            }
        }
    }
    
    func printAllValues(){
        print("MEMORY: \(numberInMemory!), ONSCREEN: \(numberOnScreen)")
    }
    
    func buttonCalledClear(){
        label.text = ""
        numberOnScreen = 0
    }
    
    func switchSign() { // +/-
        
        if(label.text != ""){
            if(label.text![label.text!.startIndex] != "-"){
                label.text!.insert("-", at: label.text!.startIndex)
                numberOnScreen = numberOnScreen * -1
            }
            else{
                label.text!.remove(at: label.text!.startIndex)
                numberOnScreen = numberOnScreen * -1
            }
        }
        
    }
    
    func displayResult(){
        if(numberOnScreen.truncatingRemainder(dividingBy: 1) == 0){
            label.text = String(Int(numberOnScreen))
        }
        else{
            label.text = String(numberOnScreen)
        }
        
    }
    
    func storeInMemory() {
        numberInMemory = numberOnScreen
        numberOnScreen = 0
        label.text = ""
    }
    
    func returnResult(){
        if(numberInMemory != nil){
            
            switch(currentOperation){
                case .plus?:
                    numberOnScreen = numberOnScreen + numberInMemory!
                    displayResult()
                    currentOperation = .none
                case .minus?:
                    numberOnScreen = numberInMemory! - numberOnScreen
                    displayResult()
                    currentOperation = .none

                case .mult?:
                    numberOnScreen = numberOnScreen * numberInMemory!
                    displayResult()
                    currentOperation = .none

                case .div?:
                    numberOnScreen = numberInMemory! / numberOnScreen
                    displayResult()
                    currentOperation = .none

                default:
                    break
                
            }
            
        }
        
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        
        switch sender.tag {
            
            case 12: buttonCalledClear() // C
            case 13: switchSign() // +/-
            case 15: // -/-
                currentOperation = operation.div
                storeInMemory()
            case 16: // X
                currentOperation = operation.mult
                storeInMemory()
            case 17: // -
                currentOperation = operation.minus
                storeInMemory()
            case 18: // +
                currentOperation = operation.plus
                storeInMemory()
            case 19:
                returnResult()
            default:
                break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

