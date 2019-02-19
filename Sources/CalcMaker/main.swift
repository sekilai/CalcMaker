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
repeat {
    let qn = Level1().makeQuestion()
    if qn != nil {
        q.append(qn!)
    }
}while(q.count < num)

if std.wasSet {
    for c in 1...num {
        print("\(c). \(q[c - 1].content)  ->  \(q[c - 1].answer)")
    }
}else{
    let questionFile = "./Question.txt"
    let answerFile = "./Answer.txt"
    var questionString : String = ""
    var answerString : String = ""
    for c in 1...num {
        questionString.append("\(c). \(q[c - 1].content)=\n")
    }
    for c in 1...num {
        answerString.append("\(c). \(q[c - 1].answer)\n")
    }
    try questionString.write(toFile: questionFile, atomically: false, encoding: .utf8)
    try answerString.write(toFile: answerFile, atomically: false, encoding: .utf8)
}


