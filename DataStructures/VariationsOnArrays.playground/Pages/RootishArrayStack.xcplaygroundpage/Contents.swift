//: [Previous](@previous)

import Foundation

//:A rootish Array Stack consists of an array holding many fixed size arrays in asceding size
import Darwin

public struct RootishArrayStack<T> {
    
    fileprivate var blocks = [Array<T?>]()
    fileprivate var internalCount = 0
    
    public init() {}
    
    var count: Int {
        return internalCount
    }
    
    var capacity: Int {
        return blocks.count * (blocks.count + 1) / 2
    }
    
    fileprivate func block(from index: Int) -> Int {
        let block = Int(ceil((-3.0 + sqrt(9.0 + 8.0 * Double(index))) / 2))
        
        return block
    }
    
    fileprivate func innerBlockIndex(fromIndex index:Int, fromBlock block:Int) -> Int {
        return index - block * (block  + 1) / 2
    }
    public subscript(index :Int) -> T {
        get {
            let block = self.block(from: index)
            let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
            return blocks[block][innerBlockIndex]!
        }
        set(newValue) {
            let block = self.block(from: index)
            let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
            blocks[block][innerBlockIndex] = newValue
        }
    }
    
    fileprivate mutating func growIfNeeded() {
        if capacity - blocks.count < count + 1 {
            let newArray = [T?](repeating: nil, count: blocks.count + 1)
            blocks.append(newArray)
        }
    }
    
    fileprivate mutating func shrinkIfNeeded() {
        if capacity + blocks.count >= count {
            while blocks.count > 0 && (blocks.count - 2) * (blocks.count - 1) / 2 > count {
                blocks.remove(at: blocks.count - 1)
            }
        }
    }
    
    public mutating func insert(element: T, at index:Int) {
        growIfNeeded()
        
        internalCount += 1
        var i = count - 1
        while i > index {
            self[i] = self[i-1]
            i -= 1
        }
        self[index] = element
    }
    
    public mutating func append(element: T) {
        insert(element: element, at: count)
    }
    
    public mutating func remove(at index:Int) -> T {
        let element = self[index]
        for i in index..<count-1 {
            self[i] = self[i+1]
        }
        internalCount -= 1
        makeNil(at: count)
        shrinkIfNeeded()
        return element
    }
    
    fileprivate mutating func makeNil(at index:Int) {
        let block = self.block(from: index)
        let innderBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
        blocks[block][innderBlockIndex] = nil
    }
    
}


//: [Next](@next)
