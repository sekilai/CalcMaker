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
    case out_of_syllabus
    case unknow
}
protocol Level : NSObjectProtocol {
    func makeQuestion() -> Question?
}
extension String {
    var level: Int {
        get {
            if self == "+" || self == "-" {
                return 1
            }
            if self == "x" || self == "÷" {
                return 2
            }
            return 0
        }
        set {
        
        }
    }
    static var randomSign: String {
        get {
            return ["+","-","x","÷",][Int.random(in: 0...3)]
        }
        set {
            
        }
    }
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
    class func calcSign64(_ a:Int64,_ b:Int64,_ sign : String) throws -> Int64 {
        switch sign {
        case "+":
            return a+b
        case "-":
            return a-b
        case "x":
            if a*b > 1000000000 || a*b < -1000000000 {
                throw CalcError.out_of_syllabus
            }
            return a*b
        case "÷":
            if b == 0 {throw CalcError.divide_zero}
            if Double(a) / Double(b) != Double(a/b) {throw CalcError.no_int}
            return a/b
        default:
            throw CalcError.unknow
        }
    }
    class func calcSign(_ a:Int,_ b:Int,_ sign : String) throws -> Int {
        return Int(try calcSign64(Int64(a), Int64(b), sign))
    }
}
func stringClassFromString(_ className: String) -> AnyClass! {
    
    /// get namespace
    let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    
    /// get 'anyClass' with classname and namespace
    let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!
    
    // return AnyClass!
    return cls
}
