//
//  Level.swift
//  pdfmaker
//
//  Created by fsi-mac5d-11 on 2019/02/15.
//

import Cocoa

public struct Question {
    let content : String
    let answer : String
}
enum CalcError: Error {
    case divide_zero
    case no_int
    case more_big
}
protocol Level {
    func makeQuestion() -> Question?
}

class LevelTool {
    class func makeSign(sign : Int) -> String {
        switch sign {
        case 0:
            return "+"
        case 1:
            return "-"
        case 2:
            return "x"
        case 3:
            return "÷"
        default:
            return ""
        }
    }
    class func calcSign(_ a:Int,_ b:Int,_ sign : Int) throws -> Int {
        switch sign {
        case 0:
            return a+b
        case 1:
            return a-b
        case 2:
            return a*b
        case 3:
            if b == 0 {throw CalcError.divide_zero}
            if Double(a) / Double(b) != Double(a/b) {throw CalcError.no_int}
            return a/b
        default:
            return 0
        }
    }
}
