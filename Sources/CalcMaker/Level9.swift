//
//  Level9.swift
//  CalcMaker
//
//  Created by 石磊 on 2020/05/17.
//

import Cocoa

class Level9: NSObject, Level {
    func makeQuestion() -> Question? {
        let a = Int.random(in: 1...20)
        let b = 1//Int.random(in: 1...20)
        let e = Gcd(a, b)

        let c = Int.random(in: 1...19) * 5
        let z1 = Int.random(in: 0...1)

        let be = (b == e) ? "" : String(format:"/%d",b / e)
        let q = String(format: "%d%@ %@ %d%%", a / e, be, z1 == 0 ? "x" : "÷", c)
        var ans : String = ""
        let up = a * (z1 == 0 ? c : 100)
        let down = b * (z1 == 0 ? 100 : c)
        let x = up % down
        let y = up / down
        let f = Gcd(x, down)
        ans = String(format: "%d(%d/%d)", y , x / f, down / f)
        if x == 0 && y == 0 {
            ans = "0"
        }else if x == 0 {
            ans = String(format: "%d", y)
        }else if y == 0 {
            ans = String(format: "%d/%d", x / f, down / f)
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
