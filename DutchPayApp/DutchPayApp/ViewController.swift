//
//  ViewController.swift
//  DutchPayApp
//
//  Created by SWUCOMPUTER on 4/11/19.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var totalPrice: UITextField!

    //텍스트 필드 delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPeopleCount" {
            let destVC = segue.destination as! PeopleCountVC
            
            if let price: String = totalPrice.text {
                destVC.TP = Int(price)
            }
            else {
                destVC.TP = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

