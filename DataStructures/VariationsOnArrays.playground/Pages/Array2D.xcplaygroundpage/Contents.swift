//: [Previous](@previous)

import Foundation

var cookies = [[Int]]()

for _ in 1...9 {
    var row = [Int]()
    for _ in 1...7 {
        row.append(0)
    }
    cookies.append(row)
}

let myCookies = cookies[3][6]


func dim<T>(_ count: Int, _ value: T) -> [T] {
    return [T](repeating: value, count: count)
}

// 2-d array
var cookies2 = dim(9, dim(7, 0))
print(cookies2)

//3-d array
var cookies3 = dim(9, dim(7, dim(3, 1)))
print(cookies3)

//: [Next](@next)


public struct Array2D<T> {
    public let columns: Int
    public let rows: Int
    fileprivate var array: [T]
    
    public init(columns: Int, rows: Int, initialValue: T) {
        self.columns = columns
        self.rows = rows
        array = .init(repeating: initialValue, count: rows*columns)
    }
    
    public subscript(column: Int, row: Int) -> T {
        get {
            precondition(column < columns, "Column \(column) index is out of range. Array<T>(columns:\(column),rows:\(row)")
            return array[row*column + column]
        }
        set {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            array[row*column + column] = newValue
        }
    }
}


var newCookies = Array2D(columns: 6, rows: 6, initialValue: 5)
//read
let oneCookie = newCookies[1,2]
print(oneCookie)
//write
newCookies[0,0] = 3
print(newCookies)
