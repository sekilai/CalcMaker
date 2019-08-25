//
//  Level7.swift
//  pdfmaker
//
//  Created by fsi-mac5d-11 on 2019/02/15.
//

import Cocoa

class Level7: NSObject, Level {
    func makeQuestion() -> Question? {
        let a = Int.random(in: -10...10)
        let b = Int.random(in: -10...10)
        let c = 1//Int.random(in: 1...10)
        let d = 1//Int.random(in: 1...10)
        let m = (c * b) + (d * a)
        let n = (a * b)
        var q = String(format: "%@x²", c*d == 1 ? "" : String(format: "%d", c*d))
        if m > 0 {
            q = q + String(format: " + %@x", m == 1 ? "" : String(format: "%d", m))
        }else if m < 0 {
            q = q + String(format: " - %@x", m == -1 ? "" : String(format: "%d", -m))
        }
        if n > 0 {
            q = q + String(format: " + %d", n)
        }else if n < 0 {
            q = q + String(format: " - %d", -1 * n)
        }
        q = q + " = 0"
        let g = Gcd(a, c)
        let h = Gcd(b, d)

        let ans = String(format: "x = %d%@%@,x = %d%@%@", -1 * (a / g) , g==c ? "":"/",g==c ? "":String(format:"%d", c/g), -1 * (b / h) , h==d ? "":"/",h==d ? "":String(format:"%d", d/h))

        return Question(content: q,answer: ans)
    }
    func Gcd(_ a : Int,_ b : Int) -> Int {
        if b == 0 {
            return a;
        }
        return Gcd(b, a % b);
    }
}
