//
//  Level8.swift
//  pdfmaker
//
//  Created by fsi-mac5d-11 on 2019/02/15.
//

import Cocoa

class Level8: NSObject, Level {
    func makeQuestion() -> Question? {
        let a = Int64.random(in: 0...100000)
        let b = Int64.random(in: 0...100000)
        let z1 = String.randomSign

        let q = String(format: "%d%@%d", a, z1, b)
        var ans : Int64 = 0
        do {
            ans = try LevelTool.calcSign64(a,b,z1)
            if ans > 10000000 || ans < -10000000{
                return nil
            }
        } catch(_) {
            //print(q,e)
            return nil
        }
        return Question(content: q,answer: String(ans))
    }
}
