//
//  CityViewController.swift
//  practice-ch06
//
//  Created by 강민서 on 4/18/24.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    // JSON 데이터 준비
    var cities: [City] = MultipleController.load("cityData.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPickerView.dataSource = self // 데이터 공급자로 등록
        cityPickerView.delegate = self // 대리자로 등록
        
        // 처음으로 선택하고자 하는 row 선택
        cityPickerView.selectRow(5, inComponent: 0, animated: true)
        descriptionLabel.text = cities[5].description
        
    }
}

// PickerView의 데이터 공급자 (dataSource) 만들기
// UIPickerViewDataSource는 프로토콜(=인터페이스), 함수 구현 필요
extension CityViewController: UIPickerViewDataSource {
    
    // 이 함수는 반드시 구현해야 함
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 이 pickerView에 1개의 컴포넌트를 두겠다
    }
    
    // 이 함수도 반드시 구현해야 함
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count // 각 컴포넌트에 몇 개의 데이터가 있는가
    }
    
}

// PickerView의 대리자 (Deletage) 만들기
extension CityViewController: UIPickerViewDelegate {
    
    // PickerView가 각 row에 대해 화면에 나타날 필요가 있을 때 호출
    // 리턴은 UIView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let nameLabel = UILabel()
        nameLabel.text = cities[row].name
        
        // 스택뷰 만들어서 imageView와 nameLabel을 포함시켜 리턴
        let imageView = UIImageView(image: cities[row].uiImage())
        
        let outer = UIStackView(arrangedSubviews: [imageView, nameLabel])
        outer.axis = .vertical // 수직 정렬
        return outer
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return pickerView.frame.size.height / 2
    }
    
    // PickerView의 중앙에 오는 데이터에 대하여 호출 (변경될 때 한 번)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // PickerView 중앙에 오는 데이터 = 선택된 row
        // cities[row].description을 descriptionLabel에 보기에 함
        descriptionLabel.text = cities[row].description
    }
    
}

// MapViewController 에서 선택된 도시를 호출
extension CityViewController {
    func getSelectedCity() -> String {
        return cities[cityPickerView.selectedRow(inComponent: 0)].name
    }
}


// == 생명주기 확인 코드 == //
//import UIKit
//
//class CityViewController: UIViewController {
//
//    override func loadView() {
//        super.loadView() // 호출해야 함
//        print("CityViewController.loadView")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("CityViewController.viewDidLoad")
//
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        print("CityViewController.viewWillAppear")
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        print("CityViewController.viewDidAppear")
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        print("CityViewController.viewWillDisappear")
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        print("CityViewController.viewDidDisappear")
//    }
//
//}
