//
//  ConversionViewController.swift
//  practice-ch03
//
//  Created by 강민서 on 4/16/24.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면의 다른 영역 탭 -> 키보드 닫힘
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)) // 탭핑이 일어나면 호출되는 dismissKeyboard Callback 함수
        view.addGestureRecognizer(tapGesture)
        
        // 입력 오류 체크를 위한 Delegation
        // 0을 1번 이상 입력하면 입력이 안됨
        fahrenheitTextField.delegate = self
        
    }
    
    @IBAction func fahrenheitEditingChange(_ sender: UITextField) { // sender는 EditingChange를 일으킨 주체 (fahrenheitTextField)
        print(fahrenheitTextField.text!)
        
        if let text = sender.text { // 내용이 있으면 옵셔널 바인딩
            
            // 문자열 -> Double 형 변환, Double(text)가 nil 수도 있음
            if let fahrenheitValue = Double(text) {
                let celsiusValue = 5.0/9.0 * (fahrenheitValue - 32.0)
                celsiusLabel.text = String(format: "%.2f", celsiusValue)
            } else {
                celsiusLabel.text = "???"
            }
        }
    }
    
}

// 화면의 다른 영역 탭 -> 키보드 닫힘
extension ConversionViewController {
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        fahrenheitTextField.resignFirstResponder()
    }
}

// 입력 오류 체크를 위한 Delegation
// 0을 1번 이상 입력하면 입력이 안됨
extension ConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existing = textField.text?.range(of: ".")
        let comming = string.range(of: ".")
        if existing != nil, comming != nil {
            return false
        }
        return true
    }
}
