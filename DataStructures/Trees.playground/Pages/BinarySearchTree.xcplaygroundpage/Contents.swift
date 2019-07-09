//: [Previous](@previous)
import UIKit

public class BinartSearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinartSearchTree?
    private(set) public var left: BinartSearchTree?
    private(set) public var right:BinartSearchTree?
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        
        self.init(value: array.first!)
        for value in array.dropFirst() {
            insert(value: value)
        }
    }
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf:Bool {
        return left == nil && right == nil
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool{
        return hasLeftChild || hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            }else{
                left = BinartSearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            }else{
                right = BinartSearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    public func search(value: T) -> BinartSearchTree?{
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self
        }
    }
    
    public func search2(value: T) -> BinartSearchTree? {
        var node: BinartSearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        return nil
    }
    
    //    travlesal
    
    public func travelseInOrder(process: (T) -> Void) {
        left?.travelseInOrder(process: process)
        process(value)
        right?.travelseInOrder(process: process)
    }
    
    public func travelsePreOrder(process: (T) -> Void) {
        process(value)
        left?.travelsePreOrder(process: process)
        right?.travelsePreOrder(process: process)
    }
    
    public func travelsePostOrder(procee : (T) -> Void) {
        left?.travelsePostOrder(procee: procee)
        right?.travelsePostOrder(procee: procee)
        procee(value)
    }
    
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula: formula)
        }
        a.append(formula(value))
        if let right = right {
            a += right.map(formula: formula)
        }
        return a
    }
    
    public func toArray() -> [T] {
        return map{ $0 }
    }
    
    
    
    //    min and max
    public func minimum() -> BinartSearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    public func maximun() -> BinartSearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    //    delete nodes
    private func reconnectParentTo(node: BinartSearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    //    remove
    @discardableResult public func remove() -> BinartSearchTree? {
        let replacement: BinartSearchTree?
        
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.minimum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node: replacement)
        
        //        删除当前节点
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    public func depth() -> Int {
        var node = self
        var edges = 0
        
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
}


extension BinartSearchTree: CustomStringConvertible{
    public var description: String {
        var s = ""
        if let left = left {
            s += "\(left.description) <-"
        }
        s += "\(value)"
        
        if let right = right {
            s += "-> \(right.description)"
        }
        return s
    }
}

// 构建
let tree = BinartSearchTree<Int>(value: 7)

tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)

// array 构建
let tree2 = BinartSearchTree(array: [7, 2, 5, 10, 9, 1])
// 描述
tree.description


//search
tree2.search(value: 5)
tree2.search(value: 2)
tree2.search(value: 7)
tree2.search(value: 6)


//travlese
tree2.travelseInOrder { (value) in
    print("inOrder : \(value)")
}
tree2.travelsePreOrder { (value) in
    print("preOrder : \(value)")
}
tree2.travelsePostOrder { (value) in
    print("postOrder: \(value)")
}

tree2.toArray()

//: [Next](@next)
