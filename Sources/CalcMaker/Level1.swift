//
//  Level1.swift
//  pdfmaker
//
//  Created by fsi-mac5d-11 on 2019/02/15.
//

import Cocoa

class Level1: NSObject, Level {
    func makeQuestion() -> Question? {
        let a = Int.random(in: 0...100)
        let b = Int.random(in: 0...100)
        let c = Int.random(in: 0...100)
        let type = Int.random(in: 0...2)
        let z1 = Int.random(in: 0...3)
        let z2 = Int.random(in: 0...3)

        let q = String(format: "%@%d%@%@%d%@%@%d%@", type == 0 ? "(" : "",a, LevelTool.makeSign(sign: z1),type == 1 ? "(" : "",b,type == 0 ? ")" : "",LevelTool.makeSign(sign: z2),c,type == 1 ? ")" : "")
        var ans : Int = 0
        do {
            switch (type, z1, z2) {
            case (0,_,_): fallthrough
            case (2,_,_) where (z1 == 0 || z1 == 1) && (z2 == 0 || z2 == 1): fallthrough
            case (2,_,_) where (z1 == 2 || z1 == 3) && (z2 == 2 || z2 == 3): fallthrough
            case (2,_,_) where (z1 == 2 || z1 == 3) && (z2 == 0 || z2 == 1):
                ans = try LevelTool.calcSign(LevelTool.calcSign(a,b,z1), c, z2)
            case (1,_,_): fallthrough
            case (2,_,_) where (z1 == 0 || z1 == 1) && (z2 == 2 || z2 == 3):
                ans = try LevelTool.calcSign(a,LevelTool.calcSign(b,c,z2), z1)
            default:
                ans = 0
            }
        } catch(let e) {
            //print(q,e)
            return nil
        }
        return Question(content: q,answer: String(ans))
    }
}
