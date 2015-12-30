title: 'swift: Classes and Structures' 
tags:
  - Swift
  - iOS
categories:
  - Dev
  - Swift
date: 2015-12-21 20:42:42
---

### comparing classes and structures ###

都可以：

- 定义 property 来存储值
- 定义函数
- 定义下标，以供下表式调用
- 定义初始化函数
- Be extended to expand their functionality beyond a default implementation
- Conform to protocols to provide standard functionality of a certain kind

<!-- more -->

class可以但structure不行：

- Inheritance enables one class to inherit the characteristics of another.（继承另一个类）
- Type casting enables you to check and interpret the type of a class instance at runtime.（类型转换）

- Deinitializers enable an instance of a class to free up any resources it has assigned.（析构函数）
- Reference counting allows more than one reference to a class instance.（引用计数）

> Structures are always copied when they are passed around in your code, and do not use reference counting.

### syntax ###

```swift
class SomeClass {
    // class definition goes here
}
struct SomeStructrue {
    // structure definition goes here
}
```

定义一个 class 或 struct 实际上是定义了一种类型，跟 String，Int 等类似。一般来说 class 和 struct 的名字用 UpperCamelCase，属性和方法名则用 lowerCamelCase。例如

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

上面的 struct 有两个属性，class 有四个属性，其中一个是 struct 类型，name 属性会有一个默认值是 `nil`，因为它是 optional。

### class and structure instances ###

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

上面都使用初始化函数的方式声明对象。

**accessing properties**

使用 `.` 来访问属性：

```swift
print("The width of resolution is \(someResolution.width)")

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
```

除了访问，也可以赋值：

```swift
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
```

可以直接设定 struct 的属性值。

**memberwise initializers for structure types**

struct 按成员的初始化函数：

```swift
let vga = Resolution(width: 640, height: 480)
```

上面的方式，class 不支持。

### structures and enumerations are value types ###

原话：A value type is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.

其实swift中所有的基本类型——integers, floating-point, Booleans, strings, arrays and dictionaries——都是 value type。

也就是说，当你创建 struct 或 enumeration 类型的实例时，都是拷贝。例如：

```swift
et hd = Resolution(width: 1920, height: 1080)
var cinema = hd
```

此时，`cinema` 就是 `hd` 的一份拷贝，尽管现在它们两者有相同的长和宽，它们是完全独立的两个实例。例如：

```swift
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide.")
// prints "cinema is now 2048 pixels wide."
print("hd is still \(hd.width) pixels wide.")
// prints "hd is still 1920 pixels wide."
```

类似的，enumeration 也有：

```swift
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberDirection = currentDirection
currentDirection = .East
if rememberDirection == .West {
    print("The remembered direction is still .west")
}
```

### classes are reference types ###

与 value type 不同，reference type 会取代现有的实例：

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// prints "The frameRate property of tenEighty is now 30.0"
```

### identity operators ###

因为 class 是 reference type，所以有必要比较两个常量或变量是否 refer 到同一个类的实例上，有两个操作符可以完成这件事：

- Identical to (===)
- Not identitcal to (!==)

```swift
if tenEighty === alsoTenEighty {
    print("tenEight and alsoTenEight refer to the same VideoMode instance.")
}
// prints "tenEight and alsoTenEight refer to the same VideoMode instance."
```

- "Identical to": means that two constants or variables of class type refer to exactly the same class instance.
- "Equal to": means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.

**Pointers**

swift 中的 refer 到某个 reference type 的实例跟 C，C++ 中的指针是类似的，但不需要 `*` 来定义。

### choose structure or class ###

structure instances are always passed by value, and class instances are always passed by reference.

如果满足下面一个或多个条件，考虑使用 structure：

- The structure’s primary purpose is to encapsulate a few relatively simple data values.（为了概括一些数据）
- It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.（如果数据一般是拷贝而不是refer）
- Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.（value types）
- The structure does not need to inherit properties or behavior from another existing type.（不需要继承性）

一些可以使用 structure 的例子：

- The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.（几何形状的大小）
- A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.（一系列的范围）
- A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.（坐标系统）

**Assignment and Copy Behavior for Strings, Arrays, and Dictionaries**

In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures.意思是说，当这些类型赋给一个新的 constant 或 variable ，或传递给函数时，都是原始数据的拷贝。