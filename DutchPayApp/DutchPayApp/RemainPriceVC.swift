//
//  RemainPriceVC.swift
//  DutchPayApp
//
//  Created by SWUCOMPUTER on 4/11/19.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class RemainPriceVC: UIViewController {
    
    @IBOutlet var labelRandom: UILabel!
    var randomName: String = ""
    
    // 이전 화면으로 돌아가는 버튼 구현
    @IBAction func buttonBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelRandom.text = randomName

        // Do any additional setup after loading the view.
    }
}
