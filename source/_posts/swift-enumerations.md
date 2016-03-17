title: 'enumerations' 
tags:
  - Swift
  - iOS
categories:
  - Dev
  - Swift
date: 2015-12-21 17:53:33
---

> 版权声明：自由转载-非商用-非衍生-保持署名 | [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

### Syntax ###

使用 `enum` 关键字引出 enumeration 的定义：

```swift
enum SomeEnumeration {
	// enumeration definition goes here
}
```

<!-- more -->

下面是一个 compass 的例子，使用 `case` 来引出 enumeration 的各项：

```swift
enum CompassPoint {
	case North
	case South
	case East
	case West
}
```

> 跟C或C++不同的是，上面例子中的 `North`, `South`, `East`, `Weat` 并不会隐式地声明为 0, 1, 2, 3，需要 `CompassPoint` 显示的定义。

当有多个时，如下：

```swift
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var planet = Planet.Mercury
planet = .Saturn
```

使用enum定义后都是一种类型。
`planet` 被一个 `Planet` 初始化之后，它就可以被赋以该类型的其他值而不需要重新标明该类型。

### matching enumeration with a switch statement ###

```swift
var direction = CompassPoint.South
switch direction {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rise")
case .West:
    print("Where skies are blue")
}
```

switch 必须是详尽彻底的，即 `case` 必须包含所有的情况，不然应该加上 `default` 分支：


```swift
switch direction {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rise")
default:
	print("Not a safe place for humans")
```

### associated values ###

可以给枚举来存放任何类型的值，例如条形码的例子：

```swift
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
```

`UPCA` 存放的是包含四个 Int 型的元组，`QRCode` 则为 String。可以给它们赋值：

```swift
var productBarcode = Barcode.UPCA(8, 8590, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMN")
```

还可以将枚举中的相关值取出来作为一个 constant (let) 或 variable (var)：

```swift
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let productCode):
    print("QR code: \(productCode)")
}
```

当取出的值均为同一类型时，可以将 let 或 var 提出来，下面代码与上面等价：

```swift
switch productBarcode {
case let  .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .QRCode(productCode):
    print("QR code: \(productCode)")
}
```

### raw values ###


一个叫 `ASCIIControlCharacter` 的枚举存放的是 Character 类型：

```swift
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
```

raw value 可以是 string，character，int，float，每个 raw value 必须唯一。

> raw value 与 associated value 不同，raw value 是预设的值。

### Implicitly Assigned raw value ###

隐式指定的 raw value 是指当指定了 raw type 时，每个值会比前一个大1，如果第一个未指定时，则赋为 0 ，依次增加。还是前面的 `Planet` 例子：

```swift
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
Planet.Mercury.rawValue // prints "0"
Planet.Earth.rawValue // prints "4"
```

如果 raw type 为 String 时，隐式值为 case name：

```swift
enum CompassPoint: String {
    case North, South, East, West
}
CompassPoint.North.rawValue // prints "North"
```

### initializing from a raw value ###

```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 是 Planet? 类型，等于 Planet.Uranus
```

因为初始化时，可能会超过界限，这就是为什么 `possiblePlanet` 为 `Planet?` 类型。

```swift
let positionToFind = 9
if let somePlanet = Planet_raw(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly Harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// prints "There isn't a planet at position 9"
```

### recursive enumrarions ###

像算术表达式一样可以嵌套 (5 + 4) * 2 ，要枚举支持嵌套（递归），需要用 `indirect` 关键字标明：

```swift
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

也可以把 `indirect` 放在外面，使所有 case 都支持 recursive：

```swift
indirect enum ArithmeticExpression {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
```

这个枚举类型包含三个算术表达式：一个数字，两个数相加，两个数相乘。用法：

```swift
func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}
// evaluate (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))// prints "18"
```

这个函数将数字进行简单的返回，而“加法”和“乘法”则 evaluate `left` 和 `right`，然后相加或相乘。