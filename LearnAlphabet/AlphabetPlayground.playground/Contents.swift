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













