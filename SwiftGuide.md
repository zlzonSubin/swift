# The Swift Language Guide



## 클로저(Closure)

클로저는 코드블럭으로 C와 Objective-C의 블럭과 다른언어의 람다와 비슷합니다. 클로저는 어떤 상수나 변수의 참조를 캡쳐해 저장할 수 있습니다. Swift는 이 캡쳐와 관련한 모든 메모리를 알아서 처리합니다.

캡쳐의 개념에 대해 익숙하지 않다고 걱정하지 않아도 됩니다. 값 캡처는 아래에 자세히 설명해 두었습니다.

전역 함수와 중첩 함수는 실제 클로저의 특별한 경우 입니다. 클로저는 다음 세 가지 형태 중 하나를 갖습니다.

- 전역함수 : 이름이 있고 어떤 값도 캡처하지 않는 클로저
- 중첩함수 : 이름이 있고 관련한 함수로 부터 값을 캡처할 수 있는 클로저
- 클로저 표현 : 경량화 된 문법으로 쓰여지고 관련된 문맥(콘텍스트)로부터 값을 캡쳐할 수 있는 이름이 없는 클로저

Swift에서 클로저 표현은 최적화 되어서 간결하고 명확합니다. 이 최적화에는 다음과 같은 내용을 포함합니다.

- 문맥(콘텍스트)에서 인자타입과 반환타입의 추론
- 단일 표현 클로저에서의 암시적 반환
- 축약된 인자 이름
- 후위 클로저 문법

하나하나 뜯어보면 어렵지 않고 쉽습니다. ㅜㅜㅜㅜㅜㅜㅜ너무어려운데

### 클로저 표현 (Closure Expressions)

인라인 클로저는 명확하게 표현하는 방법으로 문법에 초점을 두었습니다. 클로저 표현은 코드의 명확성과 의도를 잃지 않으면서도 문법을 축양해 사용할 수 있는 다양한 문법의 최적화 방법을 제공합니다.

##### 정렬 메소드 (The Sorted Method)

Swift의 표준 라이브러리에 sorted(by:) 라는 알려진 타입의 배열 값을 정렬하는 메소드를 제공합니다. 여기 by에 어떤 방법으로 정렬을 수행할 것인지에 대해 기술한 클로저를 넣으면 그 방법대로 정렬된 배열을 얻을 수 있습니다. sorted(by:) 메소드는 원본 배열은 변경하지 않습니다. 아래와 같이 이름으로 구성된 names 배열을 sorted(by:)메소드와 클로저를 이용해 정렬해 보겠습니다.

~~~swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
~~~

sorted(by:) 메소드는 배열의 콘텐츠와 같은 타입을 갖고 두개의 인자를 갖는 클로저를 인자로 사용합니다. name의 콘텐츠는 String 타입이므로 (String, String) -> Bool 의 타입의 클로저를 사용해야 합니다.

클로저를 제공하는 일반적인 방법은 함수를 하나 만드는 것입니다. 위 타입을 만족 시키는 함수를 하나 만들면 정렬에 인자로 넣을 수 있는 클로저를 만들 수 있습니다.

~~~swift
func backward(_ s1: String, _ s2: String) -> Bool {
  return s1 > s2
}
car reversedNames = names.sorted(by: backward)
//결과는 ["Ewa" , "Daniella", "Chris", "Barry", "Alex"]
~~~

backward 클로저를 만들고 그것을 names.sorted(by: backward)에 넣으면 원본 배열의 순서가 정렬된 배열을 뒤집은 배열을 결과로 얻을 수 있습니다. 비교하는 클로저를 사용하는데 제법 긴 코드를 사용했는데, 앞으로 클로저의 다양한 문법 및 사용에 대해 알아 보겠습니다.

##### 클로저 표현 문법 (Closure Expression Syntax)

클로저 표현 문법은 일반적으로 아래의 형태를 띱니다.

~~~swift
{ (parameters) -> return type in
  statements
}
~~~

인자로 넣을 parameters, 인자 값으로 처리할 내용을 기술하는 statements, 그리고 return type입니다. 앞의 backward클로저를 이용해 배열을 정렬하는 코드는 클로저 표현을 이용해 다음과 바꿀 수 있습니다.

~~~swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
	return s1 > s2
})
~~~

이렇게 함수로 따로 정의된 형태가 아닌 인자로 들어가 있는 형태의 클로저를 인라인 클로저라 부릅니다. 클로저의 몸통은 in 키워드 다음에 시작합니다. 사용할 인자 값과 반환 타입을 알았으니 이제 그것들을 적절히 처리해 넘겨 줄 수 있다는 뜻이죠. 클로저의 body가 짧으니 아래와 같이 한줄에 적을 수도 있습니다.

~~~swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
~~~

#####문맥에서 타입 추론 (Inferring Type From Context)

위 예제에서 정렬 클로저는 String 배열에서 sorted(by:) 매소드의 인자로 사용됩니다. sorted(by:)의 매소드에서 이미 (String, String) -> Bool 타입의 인자가 들어와야 하는지 알기 때문에 클로저에서 이 타입들은 생략 될 수 있습니다. 그래서 위 함수는 더 생략한 형태로 아래와 같이 기술 할 수 있습니다.

~~~swift
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
~~~

위와 같이 클로저의 인자 값과 반환 타입을 생략할 수 있지만, 가독성과 코드의 모호성을 피하기 위해 타입을 명시할 수도 있습니다.

##### 단일 표현 클로저에서의 암시적 반환 (Implicit Returns from Single-Express Closures)

단일 표현 클로저에서는 반환 키워드를 생략할 수 있습니다.

~~~swift
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
~~~

이렇게 표현해도 어떠한 모호성도 없습니다. s1과 s2를 인자로 받아 그 두 값을 비교한 결과를 반환합니다.

#####인자 이름 축약 (Shorthand Arguments Names)

Swift는 인라인 클로저에 자동으로 축약 인자 이름을 제공합니다. 이인 자를 사용하면 인자 값을 순서대로 $0, $1, $2 등으로 사용할 수 있습니다. 축약 인자 이름을 사용하면 인자 값과 그 인자로 처리할 때 사용하는 인자가 같다는 것을 알기 때문에 인자를 입력 받는 부분과 in 키워드 부분을 생략 할 수 있습니다. 그러면 이런 형태로 축약 가능합니다.

~~~swift
reversedNames = names.sorted(by: { $0 > $1 } )
~~~

축약은 되었지만 논리를 표현하는데는 지장이 없습니다. 인라인 클로저에 생략된 내용을 포함해 설명하면 1. $0과 $1 인자를 두개 받아서 2. $0이 $1 보다 큰지를 비교하고 3. 그 결과(Bool)를 반환해라.

##### 연산자 매소드 (Operator Methods)

여기서 더 줄일 수 있습니다. Swift의 String 타입 연산자에는 String끼리 비교할 수 있는 비교 연산자(>) 를 구현해 두었습니다. 이 때문에 그냥 이 연산자를 사용하면 됩니다.

~~~swift
reversedNames = names.sorted(by: >)
~~~



### 후위 클로저

만약 함수의 마지막 인자로 클로저를 넣고 그 클로저가 길다면 후위 클로저를 사용할 수 있습니다. 이런 형태의 함수와 클로저가 있다면

~~~swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // body
}
~~~

~~~swift
someFunctionThatTakesAClosure(closure: {
    // 인자와 반환 생략
})
~~~

~~~swift
someFunctionThatTakesAClosure() {
    // 후위클로저의 표현법
}
~~~

앞에 정렬 예제를 후위로 표현하자면?

~~~swift
reversedNames = names.sorted() { $0 > $1 }
~~~

~~~swift
reversedNames = names.sorted { $0 > $1 } // 마지막 인자가 클로저이고 후위클로저를 사용한다면 ()까지 생략가능
~~~

~~~swift
reversedNames = names.sorted(by: { $0 > $1 } )
~~~



#### 값 캡쳐(Capturing Values)

클로저는 특정 문맥의 상수나 변수의 값을 캡쳐할 수 있습니다. 다시말해 원본 값이 사라져도 클로저의 body안에서 그 값을 활용할 수 있습니다. Swift 에서 값을 캡쳐 하는 가장 단순한 형태는 중첩함수 입니다. 중첩 함수는 함수의 body에서 다른 함수를 다시 호출하는 형태로 된 함수 입니다.

~~~swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}
~~~

(forIncrement amount: Int) -> () -> Int 이것을 쪼개서보면 첫번째 -> 앞부분이 인자이고 뒷부분이 반환값이다

인자 : (forIncrement amount: Int)

반환값 : ( ) -> Int  // 반환값이 클로저인 형태 , 인자가없고 Int형의 클로저를 반환한다

함수안에 incrementer() 함수만 따로보면

~~~swift
func incrementer() -> Int {
  runningTotal += amount
  return runningTotal
}
~~~

runningTotal 과 amount도 없지만 함수는 돌아감 그이유는 runningTotal과 amount가 캡쳐링 돼서 그런것이다.

최적화 이유로 swift는 더이상 클로저에 의해 값이 사용되지 않으면 그 값을 복사해 저장하거나 캡쳐링 하지 않는다 Swift는 특정 변수가 더 이상 필요하지 않을때 제거하는 것과 관련한 모든 메모리 관리를 알아서 처리한다.

위에 중첩함수를 실행하면

~~~swift
let incrementByTen = makeIncrementer(forIncrement: 18)
// makeIncrementer 는 클로저를 반환 , makeIncrementer 내부의 incrementer 함수를 실행하는 메소드를 반환
incrementByTen()
// 값으로 10 반환
incrementByTen()
// 값으로 20 반환
incrementByTen()
// 값으로 30 반환

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// return 7

incrementByTen()
// 값으로 40 반환
// 다른 클로저이기 때문에 연산에는 전혀 영향이 없다. 그냥 다른 저장소의 변수를 사용해 계산한다.
~~~

만약 클로저를 어떤 클래스 인스턴스의 프로퍼티로 할당하고 그 클로저가 그 인스턴스를 캡쳐링하면 강한 순환참조에 빠지게됩니다. 즉, 인스턴스의 사용이 끝나도 메모리를 해제하지 못하는것이죠. 그래서 Swift는 이 문제를 다루기 위해 캡처리스트를 사용합니다. 더많은 정보는 클로저의 강함 참조 순환을 참조하세요

#### 클로저는 참조 타입 (Closure Are Reference Types)

앞 예제에서 incrementBySeven 과 incrementByTen 은 상수이다. 그런데 어떻게 runningTotal 변수를 계속 증가시킬 수 있었을까? 탑은 함수와 클로저는 참조타입이기 때문이다. 함수와 클로저를 상수나 변수에 할당할 때 실제로는 상수와 변수에 해당 함수나 클로저의 참조가 할당된다. 그래서 만약 한 클로저를 두 상수나 변수에 할당하면 그 두 상수나 변수는 같은 클로저를 참조하고 있다.

~~~swift
let alsoIncrementByTen() = incrementByTen
alsoIncrementByTen()
// 50을 반환합니다. 앞에서 사용했던 마지막상태의 incrementByTen을 also가 참조하고 그다음 10을 증가시켰기때문에
~~~

#### 이스케이핑 클로저 (Escaping Closure)

클로저를 함수의 파라미터로 넣을 수 있는데, 함수 밖(함수가 끝나고)에서 실행되는 클로저 예를들어, 비동기로 실행되거나 completionHandler로 사용되는 클로저는 파라미터 타입 앞에 @escaping 이라는 키워드를 명시해야 합니다.



