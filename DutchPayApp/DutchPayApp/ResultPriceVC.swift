//
//  ResultPriceVC.swift
//  DutchPayApp
//
//  Created by SWUCOMPUTER on 4/11/19.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ResultPriceVC: UIViewController {
    
    var remPrice: [Int] = []
    var aveRemain: Int = 0
    var avePrice: Int = 0
    var arrayName: [String] = []
    var countPeople: Int = 0
    
    @IBOutlet var labelState01: UILabel!
    @IBOutlet var labelState02: UILabel!
    @IBOutlet var labelState03: UILabel!
    @IBOutlet var labelState04: UILabel!
    @IBOutlet var labelState05: UILabel!
    @IBOutlet var labelState06: UILabel!
    @IBOutlet var labelRemain: UILabel!
    @IBOutlet var subviewRemain: UIView!
    
    // 홈으로 돌아가는 버튼 구현
    @IBAction func buttonHome(_ sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    var labelList: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelList = [labelState01, labelState02, labelState03, labelState04, labelState05, labelState06]
        
        // 레이블 값 변경
        
        for i in 0 ..< labelList.count {
            if i < countPeople + 1 {
                labelList[i].isHidden = true
                
                if let _ : String = labelList[i].text {
                    labelList[i].isHidden = false
                    
                    // 라벨에 들어갈 텍스트 만들기
                    var outString: String = arrayName[i]
                    outString += "(은)는 "
                    if remPrice[i] > 0 { // 남은 금액이 있을 때
                        outString += String(remPrice[i])
                        outString += " 더 내야 해요."
                    }
                    else if remPrice[i] < 0 { //더 냈을 때
                        outString += String(-remPrice[i])
                        outString += " 돌려받아야 해요."
                    }
                    else if remPrice[i] == 0 { // 다 냈을 때
                        outString += " 더 낼 필요가 없어요!"
                    }
                    
                    // 라벨에 해당 텍스트 대입
                    labelList[i].text = outString
                }
            }
        }
        
        if aveRemain > 0 { // 남은 금액이 있을 때, 해당 서브 뷰를 활성화
            subviewRemain.isHidden = false
            labelRemain.text = "남은 잔돈 : " + String(aveRemain)
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRemainPrice" {
            let destVC = segue.destination as! RemainPriceVC
            
            // 랜덤 값 송출
            let randomIndex: Int = Int(arc4random_uniform(UInt32(self.countPeople+1)))
            let randomName: String = self.arrayName[randomIndex]
            
            destVC.randomName = randomName
        }
    }
}
