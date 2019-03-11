//
//  Level2.swift
//  CalcMaker
//
//  Created by fsi-mac5d-11 on 2019/02/19.
//

import Cocoa

class Level2: NSObject, Level {
    static let variables = ["a","b",""]
    class Node : CustomStringConvertible{
        var content : [String:Int] = [:]
        init(v:String, p:Int){
            content[v] = p
        }
        var description: String {
            let v = content.keys.first
            let p = content.values.first
            return String(format: "%@%@", p! <= 1 && v!.count > 0 ? "" : String(p!), v!)
        }
        var toAns: String {
            var ans : String = ""
            Level2.variables.forEach { v in
                let p = content[v] ?? 0
                if p != 0 {
                    ans.append("")
                    if p > 0 {
                        ans.append(" + ")
                    }else{
                        ans.append(" - ")
                    }
                    if abs(p) != 1 || v.count == 0 {
                        ans.append(String(abs(p)))
                    }
                    ans.append(v)
                }
            }
            ans = ans.trimmingCharacters(in: CharacterSet(charactersIn:"+ "))
            if ans.starts(with: "- ") {
                ans.remove(at: .init(encodedOffset: 1))
            }
            return ans
        }
        func calc(node:Node, z:String)throws{
            switch z {
            case "+":
                Level2.variables.forEach { (v) in
                    let p1 = content[v] ?? 0
                    let p2 = node.content[v] ?? 0
                    content[v] = p1 + p2
                }
            case "-":
                Level2.variables.forEach { (v) in
                    let p1 = content[v] ?? 0
                    let p2 = node.content[v] ?? 0
                    content[v] = p1 - p2
                }
            case "x":
                if content.filter({ $0.key.count > 0 }).count > 0 && node.content.filter({ $0.key.count > 0 }).count > 0 {
                    throw CalcError.out_of_syllabus
                }
                if content.filter({ $0.key.count > 0 }).count == 0 {
                    let px = content[""]!
                    Level2.variables.forEach { (v) in
                        let p = node.content[v] ?? 0
                        content[v] = px * p
                    }
                }else{
                    let px = node.content[""]!
                    Level2.variables.forEach { (v) in
                        let p = content[v] ?? 0
                        content[v] = px * p
                    }
                }
            case "÷":
                if node.content.filter({ $0.key.count > 0 }).count > 0 {
                    throw CalcError.out_of_syllabus
                }
                if node.content[""] == 0 {
                    throw CalcError.divide_zero
                }
                let px = node.content[""]!
                try Level2.variables.forEach { (v) in
                    let p = content[v] ?? 0
                    if Double(p) / Double(px) != Double(p/px) {throw CalcError.no_int}
                    content[v] = p / px
                }
            default:
                throw CalcError.unknow
            }
        }
    }

    func makeQuestion() -> Question? {
        let a = randNode()
        let b = randNode()
        let c = randNode()
        let d = randNode()
        let e = randNode()
        let type = Int.random(in: 0...25)
        let z1 = String.randomSign
        let z2 = String.randomSign
        let z3 = String.randomSign
        let z4 = String.randomSign

        var q : String = ""
        var ans : Node?
        do {
            switch (type, z1, z2, z3, z4) {
            case (0,_,_,_,_):
                q = String(format: "\(a) \(z1) \(b) \(z2) \(c) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([a,b,c,d,e],[z1,z2,z3,z4])
            case (1,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([calcNode([a,b],[z1]),c,d,e],[z2,z3,z4])
            case (2,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([calcNode([a,b,c],[z1,z2]),d,e],[z3,z4])
            case (3,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([calcNode([a,b,c,d],[z1,z2,z3]),e],[z4])
            case (4,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([a,calcNode([b,c],[z2]),e],[z1,z3,z4])
            case (5,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([a,calcNode([b,c,d],[z2,z3]),e],[z1,z4])
            case (6,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) \(c) \(z3) \(d) \(z4) \(e))")
                ans = try calcNode([a,calcNode([b,c,d,e],[z2,z3,z4])],[z1])
            case (7,_,_,_,_):
                q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([a,b,calcNode([c,d],[z3]),e],[z1,z2,z4])
            case (8,_,_,_,_):
                q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d) \(z4) \(e))")
                ans = try calcNode([a,b,calcNode([c,d,e],[z3,z4])],[z1,z2])
            case (9,_,_,_,_):
                q = String(format: "\(a) \(z1) \(b) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([a,b,c,calcNode([d,e],[z4])],[z1,z2,z3])
            case (10,_,_,_,_):
                q = String(format: "((\(a) \(z1) \(b)) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([calcNode([calcNode([a,b],[z1]),c],[z2]),calcNode([d,e],[z4])],[z3])
            case (11,_,_,_,_):
                q = String(format: "((\(a) \(z1) \(b)) \(z2) \(c) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([calcNode([calcNode([a,b],[z1]),c,d],[z2,z3]),e],[z4])
            case (12,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([calcNode([a,b],[z1]),c,calcNode([d,e],[z4])],[z2,z3])
            case (13,_,_,_,_):
                q = String(format: "((\(a) \(z1) \(b) \(z2) \(c)) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([calcNode([calcNode([a,b,c],[z1,z2]),d],[z3]),e],[z4])
            case (14,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([calcNode([a,b,c],[z1,z2]),calcNode([d,e],[z4])],[z3])
            case (15,_,_,_,_):
                q = String(format: "(\(a) \(z1) (\(b) \(z2) \(c))) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([calcNode([a,calcNode([b,c],[z2])],[z1]),d,e],[z3,z4])
            case (16,_,_,_,_):
                q = String(format: "(\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([calcNode([a,calcNode([b,c],[z2]),d],[z1,z3]),e],[z4])
            case (17,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) \(c)) \(z3) \(d) \(z4) \(e)")
                ans = try calcNode([a, calcNode([b,c],[z2]),d,e],[z1,z3,z4])
            case (18,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b) \(z2) (\(c) \(z3) \(d))) \(z4) \(e)")
                ans = try calcNode([calcNode([a,b,calcNode([c,d],[z3])],[z1,z2]),e],[z4])
            case (19,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) (\(c) \(z3) \(d)) \(z4) \(e))")
                ans = try calcNode([a,calcNode([b,calcNode([c,d],[z3]),e],[z2,z4])],[z1])
            case (20,_,_,_,_):
                q = String(format: "\(a) \(z1) (\(b) \(z2) (\(c) \(z3) \(d) \(z4) \(e)))")
                ans = try calcNode([a,calcNode([b,calcNode([c,d,e],[z3,z4])],[z2])],[z1])
            case (21,_,_,_,_):
                q = String(format: "\(a) \(z1) \(b) \(z2) (\(c) \(z3) (\(d) \(z4) \(e)))")
                ans = try calcNode([a,b,calcNode([c,calcNode([d,e],[z4])],[z3])],[z1,z2])
            case (22,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b)) \(z2) (\(c) \(z3) \(d)) \(z4) \(e)")
                ans = try calcNode([calcNode([a,b],[z1]),calcNode([c,d],[z3]),e],[z2,z4])
            case (23,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b) \(z2) \(c)) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([calcNode([a,b,c],[z1,z2]),calcNode([d,e],[z4])],[z3])
            case (24,_,_,_,_):
                q = String(format: "(\(a) \(z1) \(b)) \(z2) \(c) \(z3) (\(d) \(z4) \(e))")
                ans = try calcNode([calcNode([a,b],[z1]),c,calcNode([d,e],[z4])],[z2,z3])
            case (25,_,_,_,_):
                q = String(format: "((\(a) \(z1) \(b)) \(z2) (\(c) \(z3) \(d))) \(z4) \(e)")
                ans = try calcNode([calcNode([calcNode([a,b],[z1]),calcNode([c,d],[z3])],[z2]),e],[z4])
            default:
                throw CalcError.unknow
            }
        } catch(_) {
            //print(q,e)
            return nil
        }
        if ans == nil {
            return nil
        }
        return Question(content: q,answer: ans!.toAns)
    }
    
    func randNode() -> Node {
        let v = Level2.variables[Int.random(in: 0..<Level2.variables.count)]
        let p = Int.random(in: 1...10)
        return Node(v: v, p: p)
    }
    
    func calcNode(_ nodes:[Node],_ zs: [String]) throws -> Node {
        var vnodes = nodes
        var vzs = zs
        if vnodes.count - 1 != vzs.count {
            throw CalcError.unknow
        }
        repeat {
            let findex = vzs.firstIndex(where:{$0.level == 2}) ?? 0
            try vnodes[findex].calc(node: vnodes[findex + 1], z: vzs[findex])
            vnodes.remove(at: findex + 1)
            vzs.remove(at: findex)
        } while vnodes.count > 1
        return vnodes.first!
    }
}
