//
//  ViewController.swift
//  DutchPayApp
//
//  Created by SWUCOMPUTER on 4/11/19.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class PeopleCountVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var peoplePicker: UIPickerView!
    
    var TP: Int! = 0 // 전 Scene으로부터 총 금액을 받아오는 변수
    let peopleArray: [String] = ["2명", "3명", "4명", "5명", "6명"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return peopleArray[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.peoplePicker.delegate = self
        self.peoplePicker.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDutchPrice" {
            let destVC = segue.destination as! DutchPriceVC
            
            // 다음 Scene으로 picker에서 선택한 값에 해당되는 인원수를 넘겨준다
            if let count: Int = self.peoplePicker.selectedRow(inComponent: 0) {
                destVC.countPeople = count + 1
            }
            else {
                destVC.countPeople = 0
            }
            
            // 이전 Scene에서 받은 TP값을 다음 Scene으로 넘겨준다
            destVC.TP = self.TP
        }
    }
}
