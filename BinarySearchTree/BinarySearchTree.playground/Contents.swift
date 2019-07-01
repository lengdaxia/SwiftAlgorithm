import UIKit

public class BinartSearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinartSearchTree?
    private(set) public var left: BinartSearchTree?
    private(set) public var right:BinartSearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf:Bool {
        return left == nil && right == nil
    }
    
}
