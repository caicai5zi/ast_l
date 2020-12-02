//
//  uml.swift
//  ast_A
//
//  Created by caicai on 2020/12/1.
//

import Foundation
import AST

class Uml {
    var index : [String:Model] = [:]
}

extension Uml {
    func add(_ model:Model) {
        if let name = model.name() {
            index[name] = model
        }
        print(index)
    }
}

extension Uml {
    static let share = Uml()
    
    class Model {
        var stmt : Statement
        var file : String
        
        init(stmt : Statement, file : String) {
            self.stmt = stmt
            self.file = file
        }
        
        func name() -> String? {
            var res : String? = nil
            switch stmt {
            case let declaration as Declaration:
                switch declaration {
                case let decl as ClassDeclaration:
                    res = name(id: decl.name)
                case let decl as ConstantDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as DeinitializerDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as EnumDeclaration:
                    res = name(id: decl.name)
                case let decl as ExtensionDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as FunctionDeclaration:
                    res = name(id: decl.name)
                case let decl as ImportDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as InitializerDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as OperatorDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as PrecedenceGroupDeclaration:
                    res = name(id: decl.name)
                case let decl as ProtocolDeclaration:
                    res = name(id: decl.name)
                case let decl as StructDeclaration:
                    res = name(id: decl.name)
                case let decl as SubscriptDeclaration:
//                    res = name(id: decl.name)
                break
                case let decl as TypealiasDeclaration:
                    res = name(id: decl.name)
                case let decl as VariableDeclaration:
//                    res = name(id: decl.name)
                break
                default:
                    break
                }
            default:
                break
            }
            return res
        }
        
        func name(id:Identifier) -> String? {
            switch id {
            case .backtickedName(let btn):
                return btn
            case .name(let n):
                return n
            case .wildcard:
                return nil
            }
        }
    }
}
