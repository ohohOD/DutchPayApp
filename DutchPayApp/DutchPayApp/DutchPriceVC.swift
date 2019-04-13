//
//  DutchPriceVC.swift
//  DutchPayApp
//
//  Created by SWUCOMPUTER on 4/11/19.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class DutchPriceVC: UIViewController, UITextFieldDelegate {

    var TP: Int! = 0 // 전 Scene으로부터 총 금액을 받아오는 변수
    var countPeople: Int! = 0 // 전 Scene으로부터 총 인원수를 받아오는 변수
    var arrayName: [String] = [] // 이름을 저장하는 변수
    var arrayPrice: [Int] = [] // 금액을 저장하는 변수
    var now: Int = 0
    
    @IBOutlet var goPrev: UIButton!
    @IBOutlet var goNext: UIButton!
    @IBOutlet var buttonNext: UIButton!
    @IBOutlet var textName: UITextField!
    @IBOutlet var textPrice: UITextField!
    @IBOutlet var labelCount: UILabel!
    
    // 버튼 색상 구현을 위한 UIColor 변수 선언
    let gray = UIColor.init(red: 135/255, green: 135/255, blue: 255/255, alpha: 1.0)
    
    func updataData()
    {
        // 1. 이름 배열에 입력값 저장
        if let name = textName.text {
            arrayName[now] = name
        }
        else {
            arrayName[now] = ""
        }
        
        // 2. 금액 배열에 입력값 저장
        if let price0: String = textPrice.text {
            if let price: Int = Int(price0) {
                arrayPrice[now] = price
            }
            else {
                arrayPrice[now] = 0
            }
        }
        else {
            arrayPrice[now] = 0
        }
    }
    
    // 버튼이 눌렸을 때
    @IBAction func updateValue(_ sender: UIButton) {
        
        updataData()
        
        if sender == goPrev { // goPrev을 눌렀을 때
            // 현재 index 값 감소
            now = now - 1
            labelCount.text = String(now + 1) + "."
            
            // 다음 버튼 활성화, 다음 Scene 버튼 비활성화
            goNext.setTitleColor(.white, for: .normal)
            goNext.isUserInteractionEnabled = true
            buttonNext.setTitleColor(gray, for: .normal)
            buttonNext.isUserInteractionEnabled = false
            
            // 배열의 처음일때
            if now == 0 {
                // 이전 버튼 비활성화
                goPrev.setTitleColor(gray, for: .normal)
                goPrev.isUserInteractionEnabled = false
            }
        }
        else if sender == goNext { // goNext를 눌렀을 때
            // 현재 index 값 증가
            now = now + 1
            labelCount.text = String(now + 1) + "."
            
            // 이전 버튼 활성화
            goPrev.setTitleColor(.white, for: .normal)
            goPrev.isUserInteractionEnabled = true
            
            // 배열의 끝일 때
            if now == countPeople {
                // 다음 버튼 비활성화, 다음 Scene 버튼 활성화
                goNext.setTitleColor(gray, for: .normal)
                goNext.isUserInteractionEnabled = false
                buttonNext.setTitleColor(.white, for: .normal)
                buttonNext.isUserInteractionEnabled = true
            }
        }
        
        // 이전에 저장된 값이 있을 경우, 해당 내용을 텍스트 필드에 불러온다
        if let name: String = arrayName[now] {
            textName.text = name
        }
        else {
            textName.text = ""
        }
        
        if let price: Int = arrayPrice[now] {
            if price != 0 {
                textPrice.text = String(price)
            }
            else {
                textPrice.text = ""
            }
        }
        else{
            textPrice.text = ""
        }
    }
    
    // 텍스트 필드 delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 이름과 금액 배열에 초기값을 삽입함
        for _ in 0 ... countPeople {
            arrayName.append("")
            arrayPrice.append(0)
        }

        // 버튼 사전설정
        goPrev.setTitleColor(gray, for: .normal)
        goNext.setTitleColor(.white, for: .normal)
        buttonNext.setTitleColor(gray, for: .normal)
        self.goPrev.isUserInteractionEnabled = false
        self.buttonNext.isUserInteractionEnabled = false
        
        // 라벨 설정
        labelCount.text = "1."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultPrice" {
            updataData() // 마지막 값이 저장 안되었을 경우, 업데이트
            
            let destVC = segue.destination as! ResultPriceVC
            
            var remPrice: [Int] = [] // 각자가 더 내야하는 값 배열
            var aveRemain: Int = 0
            var avePrice: Int = 0
            
            if let totalPrice = self.TP { // 예외 처리 : TP에 값이 없을 경우 처리하지 않음
                aveRemain = totalPrice % ((self.countPeople + 1) * 100) // 남는 돈: (총 금액 / 인원수 / 100)의 나머지 - 10원 단위로 나뉘지 않도록 함
                avePrice = ((totalPrice - aveRemain) / (self.countPeople + 1)) // 각자가 내야하는 값 : (총 금액 - 남는 돈) / 인원 수
            }
            
            for i in 0 ... countPeople {
                remPrice.append(avePrice - self.arrayPrice[i]) // 사람 당 남은 금액 : 평균 금액 - 이미 낸 금액
            }
            
            // 다음 Scene으로 값을 넘겨준다
            destVC.remPrice = remPrice
            destVC.aveRemain = aveRemain
            destVC.avePrice = avePrice
            
            destVC.arrayName = self.arrayName
            destVC.countPeople = self.countPeople
        }
    }
}
