//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport


var str = "Hello, playground"

struct User {
    let name: String
    let origin: String
}



struct Lens<A, B>  {
    let get: (A) -> B
    let set: (B, A) -> A
}


let nameLens = Lens<User, String>(
    get: { (user) -> String in
        user.name
    },
    set: { (name, user) in
        User(name: name, origin: user.origin)
    }
)

let user1 = User(name: "Braca", origin: "Nis")

nameLens.set("SMT", user1)

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
PlaygroundPage.current.liveView = containerView

let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
circle.center = containerView.center
circle.layer.cornerRadius = 25.0

let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
circle.backgroundColor = startingColor

containerView.addSubview(circle);
/*
let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white

containerView.addSubview(rectangle)
*/


// you can write to stdout for debugging purposes, e.g.
// print("this is a debug message")

public func solution(_ A : inout [Int]) -> Int {
    // write your code in Swift 3.0 (Linux)
    var eq: Int = 0
    //var equilibrium:[Int] = [Int]()
    
    while (eq < A.count) {
        let firstSum = sum(arrayToSum:A, start:0, end:eq)
        let secSum = sum(arrayToSum:A, start:eq+1, end:A.count)
        print("firstSum: \(firstSum)")
        print("secSum: \(secSum)")
        if(firstSum == secSum) {
            //print (index)
            return (eq)
        }
        eq += 1
    }
    return -1
}

func sum(arrayToSum A: [Int], start: Int, end: Int) -> Int {
    var index: Int = start
    var sum: Int = 0
    while index < end {
        sum += A[index]
        index += 1
    }
    return sum
}

var A:[Int] = [500, 1, -1, 2, -2]

let eq: Int = solution(&A)


extension Array where Element: Comparable {
     
    mutating func quickSort() -> Array<Element> {
         
        func qSort(start startIndex: Int, _ pivot: Int) {
             
            if (startIndex < pivot) {
                let iPivot = qPartition(start: startIndex, pivot)
                qSort(start: startIndex, iPivot - 1)
                qSort(start: iPivot + 1, pivot)
            }
        }
         
        qSort(start: 0, self.endIndex - 1)
        return self
         
    }
    
    mutating func qPartition(start startIndex: Int, _ pivot: Int) -> Int {
       
        var wallIndex: Int = startIndex
        
        //compare range with pivot
        for currentIndex in wallIndex..<pivot {

            if self[currentIndex] <= self[pivot] {
                if wallIndex != currentIndex {
                    swap(&self[currentIndex], &self[wallIndex])
                }

                //advance wall
                wallIndex += 1
            }
        }

        //move pivot to final position
        if wallIndex != pivot {
            swap(&self[wallIndex], &self[pivot])
        }
        return wallIndex
    }
}
 
//execute sort
var sequence: Array<Int> = [7, 2, 1, 6, 8, 5, 3, 4]
let results = sequence.quickSort()















