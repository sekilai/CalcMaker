import Foundation
import CommandLineKit

let cli = CommandLineKit.CommandLine()
let level = StringOption(shortFlag: "l", longFlag: "level", required:false, helpMessage: "Question level name")
let count = IntOption(shortFlag: "c", longFlag: "count", required:false, helpMessage: "How many Questions")
let file = StringOption(shortFlag: "f", longFlag: "outputfile", required:false, helpMessage: "Output file path")
let std = BoolOption(shortFlag: "s", longFlag: "outputstdout", required:false, helpMessage: "Output to console")
let fnumber = IntOption(shortFlag: "n", longFlag: "filenumber", required:false, helpMessage: "Count of output files")
let help = BoolOption(shortFlag: "h", longFlag: "help", required:false, helpMessage: "help")
cli.addOptions([level,count,file,std,fnumber,help])
do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(0)
}
if help.value {
    cli.printUsage()
    exit(0)
}
let num = count.value ?? 1
var q : [Question] = []
let lvl = level.value ?? "all"
let Levels = ["Level1","Level2"]
let fn = fnumber.value ?? 1
repeat {
    var lvname = lvl
    if lvl == "all" {
        lvname = Levels[Int.random(in:0..<Levels.count)]
    }
    let levelclass = NSClassFromString("CalcMaker.\(lvname)") as! NSObject.Type
    let instance = levelclass.init()
    let qn = (instance as! Level).makeQuestion()
    if qn != nil {
        q.append(qn!)
    }
}while(q.count < num)

if std.wasSet {
    for c in 0..<q.count {
        print("\(c + 1). \(q[c].content)  ->  \(q[c].answer)")
    }
}else{
    for n in 0 ..< fn {
        let questionFile = "./Question\(fn == 1 ? "" : "_" + String(n)).txt"
        let answerFile = "./Answer\(fn == 1 ? "" : "_" + String(n)).txt"
        var questionString : String = ""
        var answerString : String = ""
        for c in 0..<q.count {
            questionString.append("\(c + 1). \(q[c].content)=\n")
        }
        for c in 0..<q.count {
            answerString.append("\(c + 1). \(q[c].answer)\n")
        }
        try questionString.write(toFile: questionFile, atomically: false, encoding: .utf8)
        try answerString.write(toFile: answerFile, atomically: false, encoding: .utf8)
    }
}


