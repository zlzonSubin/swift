자동클로저 (Autoclosures)

자동클로저는 인자 값이 없으며 특정 표현을 감싸서 다른 함수에 전달 인자로 사용할 수 있는 클로저입니다. 자동클로저는 클로저를 실행하기 전까지 실제 실행이 되지 않습니다. 그래서 계산이 복잡한 연산을 하는데 유용합니다. 왜냐면 실제 계산이 필요할 때 호출되기 때문입니다. 예제를 보면서 무슨 뜻인지 알아 보겠습니다.


var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

print(customersInLine.count)

// Prints "5"



let customerProvider = { customersInLine.remove(at: 0) }

print(customersInLine.count)

// Prints "5"

print("Now serving \(customerProvider())!")

// Prints "Now serving Chris!"
print(customersInLine.count)

// Prints "4"


위 예제 코드를 보면 let customerProvider = { customersInLine.remove(at: 0) } 이 클로저 코드를 지났음에도 불구하고 customersInLine.count 는 변함없이 5인 것을 볼 수 있습니다. 그리고 그 클로저를 실행시킨 print("Now serving \(customerProvider())!") 이후에야 배열에서 값이 하나 제거되어 배열의 원소 개수가 4로 줄어든 것을 확인할 수 있습니다. 이렇듯 자동 클로저는 적혀진 라인 순서대로 바로 실행되지 않고, 실제 사용될 때 지연 호출 됩니다.

자동클로저를 함수의 인자 값으로 넣는 예제는 아래와 같습니다.


// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: () -> String) {
    
	print("Now serving \(customerProvider())!")

}

serve(customer: { customersInLine.remove(at: 0) } )

// Prints "Now serving Alex!"


serve함수는 인자로 () -> String) 형, 즉 인자가 없고, String을 반환하는 클로저를 받는 함수 입니다. 그리고 이 함수를 실행할 때는 serve(customer: { customersInLine.remove(at: 0) } )이와 같이 클로저{ customersInLine.remove(at: 0) }를 명시적으로 직접 넣을 수 있습니다.
위 예제에서는 함수의 인자로 클로저를 넣을 때 명시적으로 넣는 경우에 대해 알아 보았습니다. 
위 예제를 @autoclosure키워드를 이용해서 보다 간결하게 사용할 수 있습니다. 예제를 보시겠습니다.


// customersInLine is ["Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: @autoclosure () -> String) {
    
	print("Now serving \(customerProvider())!")

}

serve(customer: customersInLine.remove(at: 0))

// Prints "Now serving Ewa!"


serve함수의 인자를 받는 부분 customerProvider: @autoclosure () 에서 클로저의 인자()앞에 @autoclosure라는 키워드를 붙였습니다. 이 키워드를 붙임으로써 인자 값은 자동으로 클로저로 변환됩니다. 그래서 함수의 인자 값을 넣을 때 클로저가 아니라 클로저가 반환하는 반환 값과 일치하는 형의 함수를 인자로 넣을 수 있습니다. 그래서 serve(customer: { customersInLine.remove(at: 0) } ) 이런 코드를 @autoclosure키워드를 사용했기 때문에 serve(customer: customersInLine.remove(at: 0)) 이렇게 {} 없이 사용할 수 있습니다. 정리하면 클로저 인자에 @autoclosure를 선언하면 함수가 이미 클로저 인것을 알기 때문에 리턴값 타입과 같은 값을 넣어줄 수 있습니다.


NOTE 자동클로저를 너무 남용하면 코드를 이해하기 어려워 질 수 있습니다. 그래서 문맥과 함수 이름이 autoclosure를 사용하기에 분명해야 합니다.


자동클로저@autoclosure는 이스케이프@escaping와 같이 사용할 수 있습니다. 동작에 대한 설명은 코드에 직접 주석을 달았습니다.


// customersInLine is ["Barry", "Daniella"]

var customerProviders: [() -> String] = []        //  클로저를 저장하는 배열을 선언

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
 
   customerProviders.append(customerProvider)

} // 클로저를 인자로 받아 그 클로저를 customerProviders 배열에 추가하는 함수를 선언

collectCustomerProviders(customersInLine.remove(at: 0))    // 클로저를 customerProviders 배열에 추가

collectCustomerProviders(customersInLine.remove(at: 0))


print("Collected \(customerProviders.count) closures.")

// Prints "Collected 2 closures."        // 2개의 클로저가 추가 됨

for customerProvider in customerProviders {
    
	print("Now serving \(customerProvider())!")//클로저를 실행하면 배열의 0번째 원소를 제거하며 그 값을 출력

}

// Prints "Now serving Barry!"

// Prints "Now serving Daniella!"


collectCustomerProviders함수의 인자 customerProvider는 @autoclosure이면서 @escaping로 선언되었습니다. @autoclosure로 선언됐기 때문에 함수의 인자로 리턴값 String만 만족하는 customersInLine.remove(at: 0)형태로 함수 인자에 넣을 수 있고, 이 클로저는 collectCustomerProviders함수가 종료된 후에 실행되는 클로저 이기 때문에 인자 앞에 @escaping 키워드를 붙여주었습니다.