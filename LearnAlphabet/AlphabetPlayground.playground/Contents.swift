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












