//
//  ViewController.swift
//  assignment9
//
//  Created by macbook  on 01.06.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var switchRequireAllFields: UISwitch!
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    @IBOutlet weak var field5: UITextField!
    @IBOutlet weak var sliderRange: UISlider!
    @IBOutlet weak var labelRange: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    
    var rng = SystemRandomNumberGenerator()
    var fields: [UITextField] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Place all fields into an array as soon as view loads
        fields.append(contentsOf: [field1, field2, field3, field4, field5])
    }
    
    
    @IBAction func generate(_ sender: UIButton) {
        let index = sender.tag
        let maxValue:UInt = UInt(sliderRange.value) //We only need integers
        let randomNumber = rng.next(upperBound: maxValue + 1)
        fields[index].text = "\(randomNumber)"
    }
    
    @IBAction func calculate(_ sender: Any) {
        //We are also counting non-empty fields in order to
        //Calculate average between fields that have been filled
        //Rather then dividing everything by total number of fields
        var sum = 0
        var count = 0
        
        //Iterate over text fields
        for field in fields {
            if let text = field.text, let value = Int(text) {
                //If field has text in it, and this text can be parsed as number
                //We add this number to the total sum and increase the count
                sum += value
                count += 1
            } else if switchRequireAllFields.isOn {
                //If all fields are required to be filled, we show an error and stop the calculation
                labelResult.textColor = .red
                labelResult.text = "Please enter all values"
                return;
            }
        }
        
    
        //Calculate average and show result
        let average = sum / count
        labelResult.textColor = .white
        labelResult.text = "Average is \(average)"
    }
    
    
    @IBAction func sliderValueDidChange(_ sender: Any) {
        //Update range text
        //Only integer value of the slider is considered in calculations,
        //So we can also only show the integer part in this label
        labelRange.text = "Range: 0 - \(Int(sliderRange.value))"
    }
}

