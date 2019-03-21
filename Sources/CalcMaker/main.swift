import Foundation
import CommandLineKit

@discardableResult
func shell(_ args: String..., to file:String? ) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    if file != nil {
        let pipe: Pipe = Pipe()
        task.standardOutput = pipe
        let pipe_error: Pipe = Pipe()
        task.standardError = pipe_error
        task.launch()
        let out: Data = pipe.fileHandleForReading.readDataToEndOfFile()
        try? out.write(to: URL(fileURLWithPath: file!))
    }else{
        task.launch()
    }
    task.waitUntilExit()
    
    return task.terminationStatus
}

let cli = CommandLineKit.CommandLine()
let level = MultiStringOption(shortFlag: "l", longFlag: "level", required:false, helpMessage: "Question level name")
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
let lvl = level.value ?? ["all"]
let Levels = ["Level1","Level2","Level3","Level4"]
let fn = fnumber.value ?? 1
var lvnames : [String] = []
if lvl.contains("all") {
    lvnames = Levels
}else{
    lvnames = lvl.map({"Level" + $0}).filter({Levels.contains($0)})
}
if lvnames.count == 0 {
    cli.printUsage()
    exit(0)
}
if std.wasSet {
    var q : [Question] = []
    repeat {
        let lvn = lvnames[Int.random(in:0..<lvnames.count)]
        let levelclass = NSClassFromString("CalcMaker.\(lvn)") as! NSObject.Type
        let instance = levelclass.init()
        var qn : Question? = nil
        while qn == nil {
            qn = (instance as! Level).makeQuestion()
        }
        q.append(qn!)
    }while(q.count < num)
    for c in 0..<q.count {
        print("\(c + 1). \(q[c].content)  ->  \(q[c].answer)")
    }
}else{
    let answerFile = "./Answer"
    var answerString : String = ""
    for n in 0 ..< fn {
        var q : [Question] = []
        repeat {
            let lvn = lvnames[Int.random(in:0..<lvnames.count)]
            let levelclass = NSClassFromString("CalcMaker.\(lvn)") as! NSObject.Type
            let instance = levelclass.init()
            var qn : Question? = nil
            while qn == nil {
                qn = (instance as! Level).makeQuestion()
            }
            q.append(qn!)
        }while(q.count < num)
        let questionFile = "Question\(fn == 1 ? "" : "_" + String(n))"
        var questionString : String = ""
        for c in 0..<q.count {
            questionString.append("\(c + 1). \(q[c].content)=\n")
        }
        for c in 0..<q.count {
            answerString.append("\(c + 1). \(q[c].answer)\n")
        }
        answerString.append("------------------------- Answer_\(n)---------------\n")
        try questionString.write(toFile: questionFile + ".txt", atomically: false, encoding: .utf8)
        if fn > 1 {
            shell("textutil", "-fontsize", "15", "-convert", "html", questionFile + ".txt", to: nil)
            shell("cupsfilter", questionFile + ".html", to: questionFile + ".pdf")
            shell("rm", "-rf", questionFile + ".html", to: nil)
            shell("rm", "-rf", questionFile + ".txt", to: nil)
        }
    }
    try answerString.write(toFile: answerFile + ".txt", atomically: false, encoding: .utf8)
    shell("cupsfilter", answerFile + ".txt", to: answerFile + ".pdf")
    shell("rm", "-rf", answerFile + ".txt", to: nil)
}



