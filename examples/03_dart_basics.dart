// Dart Basics - Understanding Classes, Objects, and Key Concepts

class Student {
  String name;
  int age;

  // Constructor
  Student(this.name, this.age);

  // Method
  void introduce() {
    print('Hi, I\'m $name and I\'m $age years old.');
  }
}

// Demonstrating async/await
Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'User data loaded!';
}

// Demonstrating null safety
void nullSafetyExample() {
  String? nullableString;  // Can be null
  String nonNullable = 'Hello';  // Cannot be null
  
  // Safe navigation operator
  print(nullableString?.length);  // Returns null if nullableString is null
  
  // Null-aware operator
  String value = nullableString ?? 'Default value';
  print(value);
}

// Type inference
void typeInferenceExample() {
  var message = 'Flutter is awesome!';  // Type inferred as String
  var count = 42;  // Type inferred as int
  var items = ['Apple', 'Banana', 'Orange'];  // Type inferred as List<String>
  
  print('Message: $message');
  print('Count: $count');
  print('First item: ${items[0]}');
}

void main() async {
  // Classes & Objects example
  var student1 = Student('Aanya', 20);
  var student2 = Student('Ravi', 22);
  
  student1.introduce();
  student2.introduce();
  
  print('\n--- Async/Await Example ---');
  print('Fetching user data...');
  String result = await fetchUserData();
  print(result);
  
  print('\n--- Null Safety Example ---');
  nullSafetyExample();
  
  print('\n--- Type Inference Example ---');
  typeInferenceExample();
}
