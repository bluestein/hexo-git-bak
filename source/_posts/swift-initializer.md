title: 'swift: initializers' 
tags:
  - Swift
  - iOS
categories:
  - Dev
  - Swift
date: 2015-12-28 17:53:33
---

*init*是class，structure或enumeration对象准备工作时使用的一些操作。在init中给stored property赋值的话不会调用property observers。

<!-- more -->

initializer with no parameters 或 默认值

```C++
struct Fahrenheit {
    var temperature: Double
    // use default property values
    //var temperature = 32.0
    init() {
        temperature = 32.0
    }
}
```

with parameters

```C++
// with parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(boilingPointOfWater.temperatureInCelsius)
// prints 100.0
print(freezingPointOfWater.temperatureInCelsius)
// prints 0.0
```

**swift为init函数中的每个参数都会默认提供一个 external name**

```C++
// automatic external name
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// will error
//let veryGreen = Color(0.0, 1.0, 0.0)
```

optional peroperty：会被初始化为 nil

```C++
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
```

如果所有的属性都有一个默认值，那么class或structure都会获得一个default initializer

```C++
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```

struct会自动获得一个memberwise initializer

```C++
struct Size {
    var width, height: Double
}
let size = Size(width: 1.0, height: 0.0)
```

> 如果要同时使用 default initializer 和 custom initializer，那么就把 custom initializer的定义放在 Extensions 中

**Initializer Delegation for Value Types**

```C++
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
```

**Designated Initializers and Convenience Initializers**

上面的三个init函数都是designated initializer，每个class至少有一个designated initializer，继承而来的也算。
convenience initializer格式

```C++
convenience init(parameters) {
	statements
}
```

- Designated initializer must always delegate up.
- Convenience initializer must always delegate across.

**初始化函数的继承和override**

继承时，即使是 default initializer，subclass也应该写override关键字

```C++
class Vehicle {
    var numOfWheels = 0
    var description: String{
        return "\(numOfWheels) wheel(s)"
    }
}
class Bicycle: Vehicle {
	// 此处的override
    override init(){
        super.init()
        numOfWheels = 2
    }
}
```

**designated and convenience initializers in action**

```C++
// designated and convenience initializers in action
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    // convenience initializer overrides designated initializer
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
class ShoppingList: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) * \(name)"
        output += purchased ? " yes" : " no"
        return output
    }
}
var breakfastList = [
    ShoppingList(),
    ShoppingList(name: "Bacon"),
    ShoppingList(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// prints
// 1 * Orange juice yes
// 1 * Bacon no
// 6 * Eggs no
```

![][1]

**failable initializer**

```C++
// failable initializer
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let animal = Animal(species: "Giraffe")
// animal is of type Animal?, not Animal
if let giraffe = animal {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// prints
// An animal was initialized with a species of Giraffe
// The anonymous creature could not be initialized
```

**failable initializer for enumeration**

```C++
// failable initializer for enumeration
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unkownUnit = TemperatureUnit(symbol: "X")
if unkownUnit == nil {
    print("This is not a defined temperatur unit, so initialization failed.")
}
```
**propagation of initialization failure**

“可失败初始化”的传播

```C++
// propagation of initialization failure
class CarItem: Product {
    let quantity: Int!
    init?(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 { return nil }
    }
}
if let twoSocks = CarItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroSocks = CarItem(name: "sock", quantity: 0) {
    print("Item: \(zeroSocks.name), quantity: \(zeroSocks.quantity)")
} else {
    print("Unable to initialize zero socks")
}
if let oneUnamed = CarItem(name: "", quantity: 1) {
    print("Item: \(oneUnamed.name), quantity: \(oneUnamed.quantity)")
} else {
    print("Unable to initialize oneUnamed")
}
```

[1]: ../images/designated_and_convenience_initializers.png "designated and convenience initializers"