�ڵ�Ŭ���� (Autoclosures)

�ڵ�Ŭ������ ���� ���� ������ Ư�� ǥ���� ���μ� �ٸ� �Լ��� ���� ���ڷ� ����� �� �ִ� Ŭ�����Դϴ�. �ڵ�Ŭ������ Ŭ������ �����ϱ� ������ ���� ������ ���� �ʽ��ϴ�. �׷��� ����� ������ ������ �ϴµ� �����մϴ�. �ֳĸ� ���� ����� �ʿ��� �� ȣ��Ǳ� �����Դϴ�. ������ ���鼭 ���� ������ �˾� ���ڽ��ϴ�.


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


�� ���� �ڵ带 ���� let customerProvider = { customersInLine.remove(at: 0) } �� Ŭ���� �ڵ带 ���������� �ұ��ϰ� customersInLine.count �� ���Ծ��� 5�� ���� �� �� �ֽ��ϴ�. �׸��� �� Ŭ������ �����Ų print("Now serving \(customerProvider())!") ���Ŀ��� �迭���� ���� �ϳ� ���ŵǾ� �迭�� ���� ������ 4�� �پ�� ���� Ȯ���� �� �ֽ��ϴ�. �̷��� �ڵ� Ŭ������ ������ ���� ������� �ٷ� ������� �ʰ�, ���� ���� �� ���� ȣ�� �˴ϴ�.

�ڵ�Ŭ������ �Լ��� ���� ������ �ִ� ������ �Ʒ��� �����ϴ�.


// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: () -> String) {
    
	print("Now serving \(customerProvider())!")

}

serve(customer: { customersInLine.remove(at: 0) } )

// Prints "Now serving Alex!"


serve�Լ��� ���ڷ� () -> String) ��, �� ���ڰ� ����, String�� ��ȯ�ϴ� Ŭ������ �޴� �Լ� �Դϴ�. �׸��� �� �Լ��� ������ ���� serve(customer: { customersInLine.remove(at: 0) } )�̿� ���� Ŭ����{ customersInLine.remove(at: 0) }�� ��������� ���� ���� �� �ֽ��ϴ�.
�� ���������� �Լ��� ���ڷ� Ŭ������ ���� �� ��������� �ִ� ��쿡 ���� �˾� ���ҽ��ϴ�. 
�� ������ @autoclosureŰ���带 �̿��ؼ� ���� �����ϰ� ����� �� �ֽ��ϴ�. ������ ���ðڽ��ϴ�.


// customersInLine is ["Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: @autoclosure () -> String) {
    
	print("Now serving \(customerProvider())!")

}

serve(customer: customersInLine.remove(at: 0))

// Prints "Now serving Ewa!"


serve�Լ��� ���ڸ� �޴� �κ� customerProvider: @autoclosure () ���� Ŭ������ ����()�տ� @autoclosure��� Ű���带 �ٿ����ϴ�. �� Ű���带 �������ν� ���� ���� �ڵ����� Ŭ������ ��ȯ�˴ϴ�. �׷��� �Լ��� ���� ���� ���� �� Ŭ������ �ƴ϶� Ŭ������ ��ȯ�ϴ� ��ȯ ���� ��ġ�ϴ� ���� �Լ��� ���ڷ� ���� �� �ֽ��ϴ�. �׷��� serve(customer: { customersInLine.remove(at: 0) } ) �̷� �ڵ带 @autoclosureŰ���带 ����߱� ������ serve(customer: customersInLine.remove(at: 0)) �̷��� {} ���� ����� �� �ֽ��ϴ�. �����ϸ� Ŭ���� ���ڿ� @autoclosure�� �����ϸ� �Լ��� �̹� Ŭ���� �ΰ��� �˱� ������ ���ϰ� Ÿ�԰� ���� ���� �־��� �� �ֽ��ϴ�.


NOTE �ڵ�Ŭ������ �ʹ� �����ϸ� �ڵ带 �����ϱ� ����� �� �� �ֽ��ϴ�. �׷��� ���ư� �Լ� �̸��� autoclosure�� ����ϱ⿡ �и��ؾ� �մϴ�.


�ڵ�Ŭ����@autoclosure�� �̽�������@escaping�� ���� ����� �� �ֽ��ϴ�. ���ۿ� ���� ������ �ڵ忡 ���� �ּ��� �޾ҽ��ϴ�.


// customersInLine is ["Barry", "Daniella"]

var customerProviders: [() -> String] = []        //  Ŭ������ �����ϴ� �迭�� ����

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
 
   customerProviders.append(customerProvider)

} // Ŭ������ ���ڷ� �޾� �� Ŭ������ customerProviders �迭�� �߰��ϴ� �Լ��� ����

collectCustomerProviders(customersInLine.remove(at: 0))    // Ŭ������ customerProviders �迭�� �߰�

collectCustomerProviders(customersInLine.remove(at: 0))


print("Collected \(customerProviders.count) closures.")

// Prints "Collected 2 closures."        // 2���� Ŭ������ �߰� ��

for customerProvider in customerProviders {
    
	print("Now serving \(customerProvider())!")//Ŭ������ �����ϸ� �迭�� 0��° ���Ҹ� �����ϸ� �� ���� ���

}

// Prints "Now serving Barry!"

// Prints "Now serving Daniella!"


collectCustomerProviders�Լ��� ���� customerProvider�� @autoclosure�̸鼭 @escaping�� ����Ǿ����ϴ�. @autoclosure�� ����Ʊ� ������ �Լ��� ���ڷ� ���ϰ� String�� �����ϴ� customersInLine.remove(at: 0)���·� �Լ� ���ڿ� ���� �� �ְ�, �� Ŭ������ collectCustomerProviders�Լ��� ����� �Ŀ� ����Ǵ� Ŭ���� �̱� ������ ���� �տ� @escaping Ű���带 �ٿ��־����ϴ�.