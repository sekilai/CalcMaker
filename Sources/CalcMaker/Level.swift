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

protocol Level {
    func makeQuestion() -> Question
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
    class func calcSign(_ a:Int,_ b:Int,_ sign : Int) -> Int {
        switch sign {
        case 0:
            return a+b
        case 1:
            return a-b
        case 2:
            return a*b
        case 3:
            return a/b
        default:
            return 0
        }
    }
}
