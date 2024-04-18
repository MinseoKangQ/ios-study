//
//  ViewController.swift
//  practice-ch05
//
//  Created by 강민서 on 4/17/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var birdLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var birdTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var birdImageView: UIImageView!
    
    var timer: Timer! // 타이머 객체
    var direction = 1 // 오른쪽으로 움직임
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 객체 생성
        let button = UIButton()
        button.setTitle("Start", for: .normal) // 타이틀 설정
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), // 수평 화면 중앙
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), // 화면의 바닥에 위치
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5) // 버튼 크기는 화면 크기의 절반
        ])
        
        // 버튼 클릭 시 buttonPressed 동작
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    
    }
    
    // 새를 움직이게 하는 함수
    @objc func timerAction() {
        
        // 왼쪽 여백의 값을 변경하여 새 이동
        birdLeadingConstraint.constant += CGFloat(direction * 10)
        
        if birdLeadingConstraint.constant + birdImageView.frame.size.width >= view.frame.size.width {
            
            // 오른쪽 끝에 도달하면
            direction = -1 // 왼쪽으로 이동
            
            // 새의 방향 반전
            birdImageView.transform = .init(scaleX: -1, y: 1)
        } else if birdLeadingConstraint.constant < 0 {
            direction = 1
            birdImageView.transform = .init(scaleX: 1, y: 1)
        }
    
    }
    
    // 버튼이 클릭되었을 때 호출되는 함수
    @objc func buttonPressed(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            
            if text == "Start" {
                
                // 타이머 생성, 새가 날기 시작함
                timer = Timer.scheduledTimer(
                    timeInterval: 0.1, // 호출 주기
                    target: self, // 호출 주체
                    selector: #selector(timerAction), // 실행 함수
                    userInfo: nil, // 사용자 정보
                    repeats: true // 반복 호출 여부
                )
            } else {
                timer.invalidate() // 타이머 중지
            }
            
        
            sender.setTitle((text == "Start") ? "Stop" : "Start", for: .normal)
        }
    }
    
 }



// === 기본 연습 === //
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // UILabel 생성
//        let helloLabel = UILabel()
//
//        // UILabel 꾸미기
//        helloLabel.text = "Hello, Autolayout"
//        helloLabel.backgroundColor = UIColor.green
//        helloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        helloLabel.textAlignment = .center
//
//        // 계층적 뷰에 연결
//        view.addSubview(helloLabel)
//
//        // 오토 리사이징 해제
//        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // 좌/상/너비/높이 제한조건 작성
//        let leadingConstraint = helloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100)
//        let topConstraint = helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
//        let widthConstraint = helloLabel.widthAnchor.constraint(equalToConstant: 200)
//        let heightConstraint = helloLabel.heightAnchor.constraint(equalToConstant: 30)
//
//        // 좌/상/너비/높이 제한조건 활성화
//        leadingConstraint.isActive = true
//        topConstraint.isActive = true
//        widthConstraint.isActive = true
//        heightConstraint.isActive = true
//
//        NSLayoutConstraint.activate([
//            helloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
//            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            helloLabel.widthAnchor.constraint(equalToConstant: 200),
//            helloLabel.heightAnchor.constraint(equalToConstant: 30),
//        ])
//    }
//
// }



// == 이미지 기본 연습 == //
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Angelina Jolie")
//        view.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 상하좌우에 대한 여백 0으로 설정
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//    
//        ])
//        
//    }
//
// }


// == 이미지 safeAreaLayoutGuide 사용
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Angelina Jolie")
//        view.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 상하좌우에 대한 여백 0으로 설정
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//    
//        ])
//        
//    }
//
// }


// == nameLabel과 nameTextField == //
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let nameLabel = UILabel()
//        nameLabel.text = "로그인 ID"
//        nameLabel.backgroundColor = .green
//        let nameTextField = UITextField()
//        nameTextField.placeholder = "아이디 입력"
//        nameTextField.backgroundColor = .cyan
//        
//        // add 순서는 중요하지 않음
//        view.addSubview(nameTextField)
//        view.addSubview(nameLabel)
//        
//        // 오토 리사이징 해제
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -10),
//            
//            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
//        ])
//        
//        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        nameTextField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//    }
//
// }


// == 스택뷰를 사용 == //
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 스택뷰 생성
//        let stackView = UIStackView()
//        stackView.backgroundColor = UIColor(red: 00, green: 0xff, blue: 0xff, alpha: 1)
//        
//        // nameLabel, nameTextField 생성
//        let nameLabel = UILabel()
//        nameLabel.text = "Name"
//        nameLabel.backgroundColor = .green
//        
//        let nameTextField = UITextField()
//        nameTextField.backgroundColor = .yellow
//        
//        
//        // 오토 리사이징 해제
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 스택뷰 속성 설정
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fill
//        stackView.spacing = 10
//        
//        // 스택뷰를 view에 부착
//        view.addSubview(stackView)
//        
//        // nameLabel, nameTextField를 스택뷰에 부착
//        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(nameTextField)
//        
//        // nameLabel,nameTextField 에 허깅 우선순위 적용
//        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            stackView.heightAnchor.constraint(equalToConstant: 120)
//        ])
//    }
//
// }
