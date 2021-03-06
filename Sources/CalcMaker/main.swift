import Foundation

@discardableResult
func shell(_ args: String..., to file:String? ) -> Int32 {
    return shell(args as [String], to: file)
}
@discardableResult
func shell(_ args: [String], to file:String? ) -> Int32 {
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
let cli = CommandLine()
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
let Levels = ["Level1","Level2","Level3","Level4","Level5","Level6","Level7","Level8","Level9"]
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
    for n in 1 ... fn {
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
            questionString.append("\(c + 1). \(q[c].content)=\n\n")
        }
        answerString.append("------------------------- Answer_\(n)---------------\n")
        for c in 0..<q.count {
            answerString.append("\(c + 1). \(q[c].answer)\n")
        }
        if fn > 1 {
            questionString = "Question \(n)\n\n" + questionString
        }
        try questionString.write(toFile: questionFile + ".txt", atomically: false, encoding: .utf8)
        if fn > 1 {
            //https://stuff.mit.edu/afs/athena/astaff/project/opssrc/cups/cups-1.4.4/doc/help/options.html
            //shell("textutil", "-fontsize", "16", "-convert", "html", questionFile + ".txt", to: nil)
            shell("cupsfilter", "-o","lpi=4", "-o","cpi=8", "-o","columns=2", questionFile + ".txt", to: questionFile + ".pdf")
            //shell("rm", "-rf", questionFile + ".html", to: nil)
            shell("rm", "-rf", questionFile + ".txt", to: nil)
        }
    }
    if fn > 1 {
        var fileoption : [String] = []
        try splitPDF.write(toFile: "splitPDF.py", atomically: false, encoding: .utf8)
        shell("chmod", "775",  "splitPDF.py", to: nil)
        for n in 1...fn {
            let questionFile = "Question\(fn == 1 ? "" : "_" + String(n))"
            shell("./splitPDF.py", questionFile + ".pdf", "1", to: nil)
            fileoption.append(questionFile + ".part1.1_1.pdf")
            shell("rm", "-rf", questionFile + ".part2.2_2.pdf", to: nil)
            shell("rm", "-rf", questionFile + ".pdf", to: nil)
        }
        shell(["/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py", "-o","Question.pdf"] + fileoption, to: nil)
        shell(["rm", "-rf"] + fileoption, to: nil)
        shell("rm", "-rf", "splitPDF.py", to: nil)
    }
    try answerString.write(toFile: answerFile + ".txt", atomically: false, encoding: .utf8)
    shell("cupsfilter", answerFile + ".txt", to: answerFile + ".pdf")
    shell("rm", "-rf", answerFile + ".txt", to: nil)
}



