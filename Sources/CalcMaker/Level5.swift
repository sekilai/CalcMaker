//
//  Level4.swift
//  CalcMaker
//
//  Created by fsi-mac5d-11 on 2019/03/14.
//

import Cocoa

class Level5: NSObject , Level {
    func makeQuestion() -> Question? {
        let a = Int.random(in: 2...15)
        var b = Int.random(in: 1...a)
        let e = Gcd(a, b)
        let c = Int.random(in: 2...15)
        var d = Int.random(in: 1...c)
        let f = Gcd(c, d)
        let z1 = String.randomSign
        //if z1 == "x" || z1 == "÷" {return nil}
        let qa = b == a ? "1" : String(format: "(%d/%d)", b / e, a / e)
        let qb = c == d ? "1" : String(format: "(%d/%d)", d / f, c / f)
        let g = Int.random(in: 0...10)
        let h = Int.random(in: 0...10)
        var gs = ""
        if qa == "1" {
            gs = String(g + 1)
        }else if g == 0 {
            gs = qa
        }else {
            gs = String(format: "%@%@", String(g),qa)
        }
        var hs = ""
        if qb == "1" {
            hs = String(h + 1)
        }else if h == 0 {
            hs = qb
        }else {
            hs = String(format: "%@%@", String(h),qb)
        }
        let q = String(format: "%@ %@ %@",gs, z1, hs)
        b = g * a + b
        d = h * c + d
        var ld = 0
        var lu = 0
        var ans : String = ""
        if z1 == "+" || z1 == "-" {
            ld = a * c
            do {
                lu = try LevelTool.calcSign(c*b,d*a,z1)
            }catch {
                return nil
            }
        }else if z1 == "x" {
            ld = a * c
            lu = b * d
        }else if z1 == "÷" {
            ld = a * d
            lu = b * c
        }
        let x = lu % ld
        let y = lu / ld
        let z = abs(Gcd(x, ld))
        ans = String(format: "%d(%d/%d)", y, x / z, ld / z)
        if x == 0 && y == 0 {
            ans = "0"
        }else if x == 0 {
            ans = String(format: "%d", y)
        }else if y == 0 {
            ans = String(format: "%d/%d", x / z, ld / z)
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
