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
    func makeQuestion() -> Question? {
        let a = randNode()
        let b = randNode()
        let c = randNode()
        let d = randNode()
        let e = randNode()
        let type = Int.random(in: 0...2)
        let z1 = Int.random(in: 0...2)
        let z2 = Int.random(in: 0...2)
        let z3 = Int.random(in: 0...2)
        let z4 = Int.random(in: 0...2)

        let q = String(format: "\(a) %@ \(b) %@ \(c) %@ \(d) %@ \(e)", LevelTool.makeSign(sign: z1)
        ,LevelTool.makeSign(sign: z2), LevelTool.makeSign(sign: z3), LevelTool.makeSign(sign: z4))
        var ans : Int = 0
//        switch (type, z1, z2) {
//        case (0,_,_): fallthrough
//        case (2,_,_) where (z1 == 0 || z1 == 1) && (z2 == 0 || z2 == 1): fallthrough
//        case (2,_,_) where (z1 == 2 || z1 == 3) && (z2 == 2 || z2 == 3): fallthrough
//        case (2,_,_) where (z1 == 2 || z1 == 3) && (z2 == 0 || z2 == 1):
//            ans = LevelTool.calcSign(LevelTool.calcSign(a,b,z1), c, z2)
//        case (1,_,_): fallthrough
//        case (2,_,_) where (z1 == 0 || z1 == 1) && (z2 == 2 || z2 == 3):
//            ans = LevelTool.calcSign(a,LevelTool.calcSign(b,c,z2), z1)
//        default:
//            ans = 0
//        }
        return Question(content: q,answer: String(ans))
    }
    
    func randNode() -> Node {
        let v = variables[Int.random(in: 0..<variables.count)]
        let p = Int.random(in: 1...100)
        return Node(v: v, p: p)
    }
}
