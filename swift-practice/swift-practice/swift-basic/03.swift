// 상수와 변수 선언
// let 상수이름: 타입 = 값
// var 변수이름: 타입 = 값

// 값의 타입이 명확하다면 타입 생략 가능
// let 상수이름 = 값
// var 변수이름 = 값

// 상수와 변수 활용
let constant: String = "차후에 변경이 불가능한 상수 let"
var variable: String = "차후에 변경이 가능한 변수 var"

variable = "변수는 이렇게 차후에 다른 값을 할당할 수 있지만"
// constant = "상수는 차후에 값을 변경할 수 없습니다" // 오류발생

let sum: Int
let inputA: Int = 100
let inputB: Int = 200

// 선언 후 첫 할당
sum = inputA + inputB

// sum = 1 // 그 이후에는 다시 값을 바꿀 수 없음, 오류발생

// 변수도 물론 차후에 할당하는 것이 가능
var nickName: String

// 여기서 print(nickName)을 한다면 초기화 되기 전에 사용했다고 컴파일러가 에러 표시함

nickName = "yagom"

// 변수는 차후에 다시 다른 값을 할당해도 문제가 없음
nickName = "야곰"
