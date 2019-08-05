//
//  Level4.swift
//  CalcMaker
//
//  Created by fsi-mac5d-11 on 2019/03/14.
//

import Cocoa

class Level4: NSObject , Level {
    func makeQuestion() -> Question? {
        let a = Int.random(in: 2...15)
        let b = Int.random(in: 1...a)
        let e = Gcd(a, b)
        let c = Int.random(in: 2...15)
        let d = Int.random(in: 1...c)
        let f = Gcd(c, d)
        let z1 = String.randomSign
        //if z1 == "x" || z1 == "÷" {return nil}
        let qa = b == a ? "1" : String(format: "%d / %d", b / e, a / e)
        let qb = c == d ? "1" : String(format: "%d / %d", d / f, c / f)
        let q = String(format: "%@ %@ %@", qa, z1, qb)
        var ld = a * c
        var ans : String = ""
        do {
            var lu = try LevelTool.calcSign(c*b,d*a,z1)
            if z1 == "x" {
                lu = try LevelTool.calcSign(b,d,z1)
            }else if z1 == "÷" {
                ld = a * d
                lu = b * c
            }
            let g = abs(Gcd(lu, ld))
            ans = String(format: "%d / %d", lu / g, ld / g)
            if lu == ld {
                ans = "1"
            }else if lu == 0 {
                ans = "0"
            }else if ld / g == 1 {
                ans = String(format: "%d", lu / g)
            }
        }catch CalcError.no_int{
            let g = abs(Gcd(c*b, d*a))
            ans = String(format: "%d / %d", c*b / g, d*a / g)
        }catch {
            return nil
        }
        return Question(content: q,answer: ans)
  
    }
    func Gcd(_ a : Int,_ b : Int) -> Int {
        if b == 0 {
            return a;
        }
        return Gcd(b, a % b);
    }
}
