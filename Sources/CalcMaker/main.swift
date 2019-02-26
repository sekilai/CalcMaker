import Foundation
import CommandLineKit

let cli = CommandLineKit.CommandLine()
let level = StringOption(shortFlag: "l", longFlag: "level", required:false, helpMessage: "Question level name")
let count = IntOption(shortFlag: "c", longFlag: "count", required:false, helpMessage: "How many Questions")
let file = StringOption(shortFlag: "f", longFlag: "outputfile", required:false, helpMessage: "Output file path")
let std = BoolOption(shortFlag: "s", longFlag: "outputstdout", required:false, helpMessage: "Output to console")
cli.addOptions([level,count,file,std])
do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(0)
}
let num = count.value ?? 1
var q : [Question] = []
let lvl = level.value ?? "Level1"
let Levels = ["Level1","Level2"]
Levels.forEach { (lvname) in
    if lvname == lvl || lvl == "all" {
        var qe : [Question] = []
        repeat {
            let levelclass = NSClassFromString("CalcMaker.\(lvname)") as! NSObject.Type
            let instance = levelclass.init()
            let qn = (instance as! Level).makeQuestion()
            if qn != nil {
                qe.append(qn!)
            }
        }while(qe.count < num)
        q += qe
    }
}

if std.wasSet {
    for c in 0..<q.count {
        print("\(c + 1). \(q[c].content)  ->  \(q[c].answer)")
    }
}else{
    let questionFile = "./Question.txt"
    let answerFile = "./Answer.txt"
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


