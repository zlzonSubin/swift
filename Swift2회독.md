## 1강

###이름짓기 규칙

- Lower Camel Case : function, method, variable, constant
  - ex) someVariableName
- Upper Camel Case : type(class, struct, enum, extension ...)
  - ex) Person, Point, Week

대소문자 구분!!

###콘솔로그

print : 단순 문자열 출력

dump : 인스턴스의 자세한 설명까지 출력 (description 프로퍼티)

###문자열 보간법

문자열 내에 상수나 변수의 실제값을 넣기위해 사용

- \\(    )

~~~swift
let age = 10
print("안녕하세요 저는 \(age)살 입니다!")
~~~

~~~swift
class Person {
  var name = "subin"
  var age = 24
}

var subin: Person = Person()
print(subin)
dump(subin) // 인스턴스의 자세한 설명까지 출력해준다
~~~



## 2강

### 상수와 변수

<u>let</u> : 차후에 변경이 불가능한 상수

<u>var</u> : 차후에 변경이 가능한 변수

나중에 초기화 해주려는 상수나 변수는 꼭 타입을 명시해줘야함

~~~swift
let sum: Int
let num1: Int = 100
let num2: Int = 200
sum = num1 + num2 // sum 선언 후 첫 할당
//sum = 1 -> 상수라서 에러나요

var subin: String
//print(subin) -> 초기화 안해서 에러나요
subin = "Subin"
subin = "Hi" // 변수여서 에러안남
~~~



## 3강

### 데이터 타입

Bool, Int, Uint, Float, Double, Character, String 

~~~swift
var emoji: Character = "😇"
var emojis: String = "😇😇😇"
~~~



## 4강

### Any, AnyObject, nil

- Any : Swift의 모든 타입을 지칭하는 키워드
- AnyObject : 모든 클래스 타입을 지칭하는 프로토콜
- nil : 없음을 의미하는 키워드

~~~swift
var someAny: Any = 100
someAny = "String도 써도댐"
someAny = 163.9

let someDouble: Double = someAny // 이거는 에러남
~~~

~~~swift
class someClass {}
var someAnyObject: AnyObject = someClass() // someAnyObject 에는 class만 들어가야함!
someAnyObject = 123.4 // 에러남. 왜냐하면 Double은 구조체로 이루어져있기때문에
~~~

~~~swift
someAny = nil // 불가능. 어떤 데이터 타입이 들어와도 상관없지만 빈 값은 들어올 수 없다
someAnyObject = nil // 불가능. 
~~~

nil은 옵셔널에서 필요해요~~



## 5강

###컬렉션 타입(Array, Dictionary, Set)

- Array : 순서가 있는 리스트 컬렉션
- Dictionary : 키와 값이 쌍으로 이뤄진 컬렉션
- Set : 순서가 없고 멤버가 유일한 컬렉션

~~~swift
// 빈 배열은 타입을 알 수 없기 때문에 좌변에서 타입을 써줘야한다
var ints: Array<Int> = Array<Int>()
ints.append(1)
ints.append(100)
print(ints) // [1,100]

ints.contains(100) // true
ints.contains(99)  // false

ints.remove(at: 0) // 1삭제
ints.removeLast()  // 100삭제
ints.removeAll()   // []

ints.count()       // 0
~~~

~~~swift
// 빈 배열 만들기 다양하게 표현 가능
var ints: Array<Int> = Array<Int>()
var ints: Array<Int> = [Int]()
var ints: [Int] = [Int]()
var ints: [Int] = []
~~~

~~~swift
var anyDict: Dictionary<String, Any> = [String: Any]() // key : String , value : Any
anyDict["SomeKey"] = "value"
anyDict["AnotherKey"] = 100
//["SomeKey": "value", "AnotherKey": 100]
anyDict.removeValue(forKey: "AnotherKey") // 100삭제
~~~

