//
//  Level3.swift
//  CalcMaker
//
//  Created by 石 磊 on 2019/3/11.
//

import Cocoa

class Level3: NSObject, Level {
    func makeQuestion() -> Question? {
        let type = Int.random(in: 0...9)
        if type < 8 {
            let a = Int.random(in: 1000...8999)
            let b = Int.random(in: 1000...9999 - a)
            
            let q = String(format: "%d + %d", a, b)
            let ans : Int = a + b
            if ans > 9999 {
                return nil
            }
            return Question(content: q,answer: String(ans))
        }else{
            let a = Int.random(in: 100...999)
            let b = Int.random(in: 1...9)
            
            let q = String(format: "%d x %d", a, b)
            let ans : Int = a * b
            if ans > 9999 {
                return nil
            }
            return Question(content: q,answer: String(ans))
        }
    }
}
