import UIKit


//: - Sort array from low to high


func mergeSort(_ array: [Int]) -> [Int] {
    
    guard array.count > 1 else { return array}
    
    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftPile: leftArray, rightPile: rightArray)
}

func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

mergeSort([3,1,4,12,341,31,44,45,65,76,56,8,4,123,132])
