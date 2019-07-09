import UIKit

public class LinkedListNode<T> {
    
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        
        self.value = value
    }
    
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    private var head: Node?
    private var tail: Node?

    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public func nodeAt(index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
          var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node!
        }
    }
    
    public subscript(index: Int) -> T {
        let newNode = nodeAt(index: index)
        return newNode.value
    }
    
    
    public func insert(_ node:Node, at index:Int) {
        let newNode = node
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = self.nodeAt(index: index - 1)
            let next = prev.next
            
            newNode.previous = prev
            newNode.next = next
            
            prev.next = newNode
            next?.previous = newNode
        }
    }
    
    public func removeAll() {
        head = nil
    }
    
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeAt(_ index: Int) -> T {
        let node = self.nodeAt(index: index)
        return remove(node: node)
    }

    public func removLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    
    public func reverse() {
        var node = head
        tail = node
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
    
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while node != nil {
            result.append(value: transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        
        while node != nil {
            if predicate(node!.value) {
                result.append(value: node!.value)
            }
            node = node!.next
        }
        
        return result
    }
}
extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil {
                s += ", "
            }
        }
        return s + " ]"
    }
}

//testing
let list = LinkedList<String>()
list.isEmpty
list.first
list.append(value: "hello")
list.append(value: "world")

list.first?.previous?.value
list.last?.previous?.value
list.first?.next?.value
list.last?.next?.value

list.nodeAt(index: 0).value
list.nodeAt(index: 1).value
//list.node(at: 2).value

//subsript
list[0]
list[1]

//insert
list.insert(LinkedListNode(value: "swift"), at: 1)
list[0]
list[1]
list[2]

//remove
list.remove(node: list.first!)
list.count
list[0]
list[1]

list.description

let list2 = LinkedList<String>()
list2.append(value: "Hello")
list2.append(value: "Swifty")
list2.append(value: "Universe")

let m = list2.map { (s:String) -> Int in
    return s.count
}

let f = list2.filter { (s) -> Bool in
   return s.count > 5
}
print(f.description)
