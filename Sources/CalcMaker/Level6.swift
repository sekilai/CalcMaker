//
//  Level6.swift
//  pdfmaker
//
//  Created by fsi-mac5d-11 on 2019/02/15.
//

import Cocoa

class Level6: NSObject, Level {
    func makeQuestion() -> Question? {
        let a = Int64.random(in: 0...1000000)
        let b = Int64.random(in: 0...1000000)
        let c = Int64.random(in: 0...10000)
        let type = Int.random(in: 0...2)
        let z1 = String.randomSign
        let z2 = String.randomSign

        let q = String(format: "%@%d%@%@%d%@%@%d%@", type == 0 ? "(" : "",a, z1,type == 1 ? "(" : "",b,type == 0 ? ")" : "",z2,c,type == 1 ? ")" : "")
        var ans : Int64 = 0
        do {
            switch (type, z1, z2) {
            case (0,_,_): fallthrough
            case (2,_,_) where z1.level >= z2.level:
                ans = try LevelTool.calcSign64(LevelTool.calcSign64(a,b,z1), c, z2)
            case (1,_,_): fallthrough
            case (2,_,_) where z1.level < z2.level:
                ans = try LevelTool.calcSign64(a,LevelTool.calcSign64(b,c,z2), z1)
            default:
                ans = 0
            }
            if ans > 1000000000 || ans < -1000000000{
                return nil
            }
        } catch(_) {
            //print(q,e)
            return nil
        }
        return Question(content: q,answer: String(ans))
    }
}
