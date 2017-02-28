//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport


/*
let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white

containerView.addSubview(rectangle)
*/


let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let square = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
square.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
containerView.addSubview(square)
UIView.animate(withDuration: 5.0, delay: 0.4, options:[.autoreverse, .repeat, .curveEaseOut], animations: {
    square.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    square.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
}, completion: nil)

PlaygroundPage.current.liveView = containerView














