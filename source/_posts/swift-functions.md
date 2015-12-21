title: 'swift: functions' 
tags:
  - Swift
  - Objective-C
categories:
  - Dev
  - Swift
date: 2015-12-20 19:53:33
---

**defining and calling**

以定义一个 `sayHello(_:)` 函数作为例子：该函数将一个人的名字作为输入，以一句问候作为返回值：
```swift
func sayHello(personName: String) -> String {
	let greeting = "Hello, " + personName + "!"
	return greeting
}
```
<!-- more -->

- 输入类型: `String`
- 返回值类型： `String`
> 说明： 函数的定义，以 `func` 作为关键字，后面跟该函数的名字，使用 `:` 指定参数的类型， `->` 指定返回值的类型。
```swift
print(sayHello("Anna"))
// prints "Hello, Anna!"
print(sayHello("Brian"))
// prints "Hello, Brian!"
```
使用 `print(_:separator:terminator:)` 来打印输出。

**parameters and return values**
swift中的函数的参数和返回值可以是任何类型，甚至可以是函数类型（在swift中，函数也是一种类型，后面会讲到）。

**without parameters**
```swift
func sayHelloWorld() -> string {
	return "Hello World"
}
```

**multiple parameters**
多个参数时，用逗号隔开即可：
```swift
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
	if already_greeted {
		return "Hello again, " + personName + "!"
	} else {
		return sayHello(personName)
	}
}
print(sayHello("Tim", alreadyGreeted: false))
```
调用的形式是 `sayHello(_:alreadyGreeted:)`，通常第一个参数名后面的所有参数名需要标明。

**without return value**
```swift
func sayBye(personName: String) {
	print("Goodbye, \(personName)!)
}
sayBye("Dave")
```
> 严格地说，`sayBye(_:)` 还是有返回值的，为 `Void` 类型， 记作 `()`。

**multiple return values**
```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
	var currentMin = array[0]
	var currentMax = array[0]
	for value in array[1..<array.count] {
		if value < currentMin {
			currentMin = value
		} else if value > currentMax {
			currentMax = value
		}
	}
	return (currentMin, currentMax)
}
let array = [1, -10, 20]
let bounds = minMax(array)
print("min: \(bounds.min), max: \(bounds.max).")
```
把多个返回值当成一个元组返回。
但如果，用户传入的数组为空则会出错，此时需要使用 `optional tuple`， 即 `(Int, Int)?`，上述程序改成：
```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
	if array.isEmpty { return nil }
	var currentMin = array[0]
	var currentMax = array[0]
	for value in array[1..<array.count] {
		if value < currentMin {
			currentMin = value
		} else if value > currentMax {
			currentMax = value
		}
	}
	return (currentMin, currentMax)
}
let array = [1, -10, 20]
let bounds = minMax(array)
print("min: \(bounds.min), max: \(bounds.max).")
// as above

let emptyArray = [Int]()
print(minMax(emptyArray))
// prints "nil"
```

**functon names**
```swift
func someFuction(fisrtParameterName: Int, secondParameterName: Int) {
	// function body goes here
}
// calling
someFuction(1, secondParameterName: 2)
```
默认情况下，省略了第一个参数额外参数，其他则使用 `local name` 作为 `external name`

**external parameter names**
```swift
func someFuction(externalParameterName localParameterName: Int) {
	// function body goes here
}
// calling
someFuction(externalParameterName: 1)
```

**omitting external names**
使用下划线 `_` 来替代，则调用时不用标明external names：
```swift
func someFuction(fisrtParameterName: Int, _ secondParameterName: Int) {
	// function body goes here
}
// calling
someFuction(1, 2)
```

**default parameter values**
```swift
func someFuction(localParameterName: Int = 12) {
	// function body goes here
}
// calling
someFuction(1)
someFuction()
```

**variadic parameters**
参数个数可变的情况，在参数的类型后面使用 `...` 来表示该类型的参数可以不确定：
```swift
func arithmeticMean(numbers: Double...){
	var total: Double = 0
	for number in numbers {
		total += number
	}
	return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4)
arithmeticMean(3, 1.5, 14.75)
```

**constant and variable parameter**
一般来说函数为常量参数，但也可以用变量参数。使用 `var` 来表明变量参数，这样就可以改变该变量的值：
```swift
func alignRight(var sting: String, totalLength: Int, pad: Character) -> String {
	let amountToPad = totalLength - string.characters.count
	if amountToPad < 1 {
		return string
	}
	let padString = String(pad)
	for _ in 1...amountToPad {
		string = padString + string
	}
	return string
}
let originalString = "hello"
let paddesString = alginRigth(originalString, totalLength: 10, pad: 
"-")
// prints "-----hello"
```

**in-out parameters**
上面所说的变量参数，只能在当前函数内可以改变它的值，如果想要永久改变一个值则需要需用 `inout` 关键字标明。并且调用时需要在变量前加上 `&` 符号：
```swift
func swapTwoInts(inout a: Int, inout _ b: Int) {
	let temporaryA = a
	a = b
	b = a
}

var someInt = 2
var anotherInt = 3
swapTwoInts(&someInt, &anotherInt)
```

**Function types**
swift把函数也当作一种类型看待，可以像 `Int` 那样进行操作：
```swift
func addTwoInts(a: Int, _ b: Int) -> Int {
	return a+ b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
	return a * b
}
```
这两个函数都可以记作为 `(Int, Int) -> Int`。
```swift
func printHelloWorld() {
	print("Hello World")
}
```
则可以看做 `() -> Void`。

**using function type**
把 `addTwoInts` 函数当成是一种类型赋给 `mathFunction` 变量：
```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(1, 2))")
// prints "Result: 3"
```
前面说到， `addTwoInts` 和 `multiplyTwoInts` 函数在形式上是一致的，则下面代码也成立：
```swift
mathFunction = multiplyTwoInts
```

**function types as parameter type**
```swift
func printMathResult(mathFunction: (Int, Int) -> int, _ a: Int, _ b: Int) {
	print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
prints "Result: 8"
```
很容易看懂， `printMathResult(_:_:_:)` 函数有三个参数，分别是：`(Int, Int) -> int`, `Int` 和 `Int`。

**function types as return types**
```swift
func stepForward(input: Int) -> Int {
	return input + 1
}
func stepBackward(input: Int) -> Int {
	return input - 1
}

func chooseStep(backwards: Bool) -> (Int) -> Int {
	return backwards ? stepBackward : stepForward
}
```
显然 `chooseStep(:)` 函数使用 `(Int) -> Int` 类型的函数作为返回值。
```swift
var value = 3
let moveNearerToZearo = chooseStep(value > 0)
print("Counting to zero:")
while value != 0 {
	print("\(value)...")
	value = moveNearerToZero(value)
}
print("zero!")
// prints:
// 3...
// 2...
// 1...
// zero!
```

**Nested function**
```swift
func chooseStep(backwards: Bool) -> (Int) -> Int {
	func stepForward(input: Int) -> Int {
		return input + 1
	}
	func stepBackward(input: Int) -> Int {
		return input - 1
	}
	return backwards ? stepBackward : stepForward
}
var value = -4
let moveNearerToZearo = chooseStep(value > 0)
print("Counting to zero:")
while value != 0 {
	print("\(value)...")
	value = moveNearerToZero(value)
}
print("zero!")
// prints:
// -4...
// -3...
// -2...
// -1...
// zero!
```

END.

---

Github Pages同步更新: [Humooo's Blog][1]

[1]: http://bluestein.github.io/
