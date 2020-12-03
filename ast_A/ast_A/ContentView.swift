//
//  ContentView.swift
//  ast_A
//
//  Created by app on 2020/12/1.
//

import SwiftUI
import Source
import Parser
import AST

struct ContentView: View {
    let uml = Uml.share
    
    @State var classes : [String] = []
    @State var message:String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button("add dir") {
                    let openpa = NSOpenPanel()
                    openpa.directoryURL = URL(fileURLWithPath: NSHomeDirectory())
                    openpa.canChooseDirectories = true
                    openpa.begin { (res) in
                        if res == .OK , let url = openpa.url {
                            load(path: url.path)
                        }
                    }
                }
                
                Button("class") {
                    for (n,c) in uml.cls {
                        let cls = uml.plantUml(cls: c)
                        print(cls)
                    }
                }
                Spacer()
            }
            Spacer()
            HStack {
                Text(message)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    func load(path:String) {
        message = "loading"
        var isDir : ObjCBool = false
        guard FileManager.default.fileExists(atPath: path ,isDirectory: &isDir) && isDir.boolValue else {
            message = "不能制定文件"
            return
        }
        guard let enu = FileManager.default.enumerator(atPath: path) else {
            message = "创建枚举失败"
            return
        }
        guard var name = enu.nextObject() as? String else {
            message = "枚举无内容"
            return
        }
        var n = true
        while n {
            autoreleasepool {
                let file = path + "/" + name
                if file.hasSuffix(".swift") {
                    loadFile(file: file)
                }
                if let nex = enu.nextObject() as? String {
                    name = nex
                }else{
                    n = false
                }
            }
        }
    }
    
    func loadFile(file:String) {
        do {
            let sourceFile = try SourceReader.read(at: file)
            let parser = Parser(source: sourceFile)
            let topLevelDecl = try parser.parse()
            
            for stmt in topLevelDecl.statements {
                uml.add(stmt: stmt, file: file)
            }
            
        }catch {
            message = error.localizedDescription
        }
    }
}

extension ContentView {
    func load(stmt:ClassDeclaration,file:String) {
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
