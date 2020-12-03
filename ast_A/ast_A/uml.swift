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
    var cls: [String:ClassDeclaration] = [:]
    var Constant : [String:ConstantDeclaration] = [:]
    var deinitializer : [String:DeinitializerDeclaration] = [:]
    var enumd : [String : EnumDeclaration] = [:]
    var extensiond : [String : ExtensionDeclaration] = [:]
    var function : [String : FunctionDeclaration] = [:]
    var importd : [String : ImportDeclaration] = [:]
    var initializer : [String : InitializerDeclaration] = [:]
    var operatord : [String : OperatorDeclaration] = [:]
    var precedenceGroup : [String: PrecedenceGroupDeclaration] = [:]
    var protocold : [String: ProtocolDeclaration] = [:]
    var structd : [String : StructDeclaration] = [:]
    var subscriptd : [String : SubscriptDeclaration] = [:]
    var typealiasd : [String : TypealiasDeclaration] = [:]
    var variable : [String : VariableDeclaration] = [:]
}

extension Uml {
    func add(stmt:Statement ,file:String) {
        let m =  Model(stmt: stmt, file: file)
        if let name = m.name() {
            index[name] = m
        }
        
        switch stmt {
        case let declaration as Declaration:
            switch declaration {
            case let decl as ClassDeclaration:
                cls[decl.name.description] = decl
                break
            case let decl as ConstantDeclaration:
                print("constant:",decl)
                break
            case let decl as DeinitializerDeclaration:
                print("deinitializer:",decl)
                break
            case let decl as EnumDeclaration:
                enumd[decl.name.description] = decl
                break
            case let decl as ExtensionDeclaration:
                extensiond[decl.type.description] = decl
                break
            case let decl as FunctionDeclaration:
                function[decl.name.description] = decl
                break
            case let decl as ImportDeclaration:
                importd[decl.path.description] = decl
                break
            case let decl as InitializerDeclaration:
                print("initializer", decl)
                break
            case let decl as OperatorDeclaration:
                print("operator", decl)
                break
            case let decl as PrecedenceGroupDeclaration:
                precedenceGroup[decl.name.description] = decl
                break
            case let decl as ProtocolDeclaration:
                protocold[decl.name.description] = decl
                break
            case let decl as StructDeclaration:
                structd[decl.name.description] = decl
                break
            case let decl as SubscriptDeclaration:
                print("subscript", decl)
                break
            case let decl as TypealiasDeclaration:
                typealiasd[decl.name.description] = decl
                break
            case let decl as VariableDeclaration:
                print("variable", decl)
                break
            default:
                break
            }
        case let expression as Expression:
            switch expression {
            case let exp as BinaryExpression:
                break
            case let exp as PrefixExpression:
                break
            case let exp as PostfixExpression:
                break
            case let exp as PrimaryExpression:
                break
            default:
                break
            }
        default:
            break
        }
    }
    
    func plantUml(cls:ClassDeclaration) -> String {
        let name = cls.name.description
        let clsuml = "class \"\(name)\" as \(name) "
        var body : [String] = []
        for mem in cls.members {
            switch mem {
            case .declaration(let decl):
                switch decl {
                case let dec as VariableDeclaration:
                    body.append(plantUml(variable: dec))
                    break
                default:
                    break
                }
                break
            case .compilerControl(let ccs):
                break
            }
        }
        
        let bodys = body.joined(separator: "\n")
        var res = clsuml + "{\n" + bodys + "\n}"
        return res
    }
    
    func plantUml(variable:VariableDeclaration) -> String {
        var res = ""
        switch variable.body {
        case .codeBlock(let ide, let type, let blk):
            break
        case .getterSetterBlock(let ide, let type, let blk):
            break
        case .initializerList(let pattern):
            if let patt = pattern.first {
                if let ide = patt.pattern as? IdentifierPattern {
                    res = ide.identifier.description
                }
            }
            break
        case .getterSetterKeywordBlock(let ide, let type, let blk):
            break
        case .willSetDidSetBlock(let ide, let type, let exp, let blk):
            break
        default:
            break
        }
        return res
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
