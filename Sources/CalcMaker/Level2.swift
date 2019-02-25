//
//  Level2.swift
//  CalcMaker
//
//  Created by fsi-mac5d-11 on 2019/02/19.
//

import Cocoa

class Level2: NSObject, Level {
    let variables = ["a","b",""]
    struct Node : CustomStringConvertible{
        let v : String
        let p : Int
        var description: String {
            return String(format: "%@%@", p <= 1 && v.count > 0 ? "" : String(p), v)
        }
    }
    struct Ans : CustomStringConvertible{
        let a : Int
        let b : Int
        let p : Int
        var description: String {
            var des = ""
            if a != 0 {
                des = des.appendingFormat("%da", a)
            }
            if b != 0 {
                des.append(des.count > 0 ? " " : "")
                //des = des.appendingFormat("%@%db", )
            }
            return des
        }
    }
    func makeQuestion() -> Question? {
        let a = randNode()
        let b = randNode()
        let c = randNode()
        let d = randNode()
        let e = randNode()
        let type = Int.random(in: 0...25)
        let z1 = LevelTool.makeSign(sign:Int.random(in: 0...2))
        let z2 = LevelTool.makeSign(sign:Int.random(in: 0...2))
        let z3 = LevelTool.makeSign(sign:Int.random(in: 0...2))
        let z4 = LevelTool.makeSign(sign:Int.random(in: 0...2))

        var q : String = ""
        var ans : Int = type
        switch (type, z1, z2, z3, z4) {
        case (0,_,_,_,_):
            q = String(format: "\(a) \(z1) \(b) \(z2) \(c) \(z3) \(d) \(z3) \(e)")
        case (1,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) \(d) \(z4) \(e)")
        case (2,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e)")
        case (3,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
        case (4,_,_,_,_):
            q = String(format: "\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e)")
        case (5,_,_,_,_):
            q = String(format: "\(a) \(z1) (\(b) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
        case (6,_,_,_,_):
            q = String(format: "\(a) \(z1) (\(b) \(z2) \(c) \(z3) \(d) \(z4) \(e))")
        case (7,_,_,_,_):
            q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d)) \(z4) \(e)")
        case (8,_,_,_,_):
            q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d) \(z4) \(e))")
        case (9,_,_,_,_):
            q = String(format: "\(a) \(z1) \(b) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
        case (10,_,_,_,_):
            q = String(format: "((\(a) \(z1) \(b)) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
        case (11,_,_,_,_):
            q = String(format: "((\(a) \(z1) \(b)) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
        case (12,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
        case (13,_,_,_,_):
            q = String(format: "((\(a) \(z1) \(b) \(z2) \(c)) \(z3) \(d)) \(z4) \(e)")
        case (14,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
        case (15,_,_,_,_):
            q = String(format: "(\(a) \(z1) (\(b) \(z2) \(c))) \(z3) \(d) \(z4) \(e)")
        case (16,_,_,_,_):
            q = String(format: "(\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d)) \(z4) \(e)")
        case (17,_,_,_,_):
            q = String(format: "(\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e))")
        case (18,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d))) \(z4) \(e)")
        case (19,_,_,_,_):
            q = String(format: "\(a) \(z1) (\(b) \(z2) (\(c) \(z3) \(d)) \(z4) \(e))")
        case (20,_,_,_,_):
            q = String(format: "\(a) \(z1) (\(b) \(z2) (\(c) \(z3) \(d) \(z4) \(e)))")
        case (21,_,_,_,_):
            q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) (\(d) \(z4) \(e)))")
        case (22,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b)) \(z2) (\(c) \(z3) \(d)) \(z4) \(e)")
        case (23,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
        case (24,_,_,_,_):
            q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
        case (25,_,_,_,_):
            q = String(format: "((\(a) \(z1) \(b)) \(z2) (\(c) \(z3) \(d))) \(z4) \(e)")
        default:
            ans = 0
        }
        return Question(content: q,answer: String(ans))
    }
    
    func randNode() -> Node {
        let v = variables[Int.random(in: 0..<variables.count)]
        let p = Int.random(in: 1...10)
        return Node(v: v, p: p)
    }
    
//    func calcSign(_ nodes:[Node]) throws -> [Node] {
//        switch sign {
//        case 0:
//            return a+b
//        case 1:
//            return a-b
//        case 2:
//            return a*b
//        case 3:
//            if b == 0 {throw CalcError.divide_zero}
//            if Double(a) / Double(b) != Double(a/b) {throw CalcError.no_int}
//            return a/b
//        default:
//            return 0
//        }
//    }
}
