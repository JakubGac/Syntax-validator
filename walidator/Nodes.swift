//
//  Nodes.swift
//  walidator
//
//  Created by Jakub Gac on 01.04.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

public protocol ExprNode: CustomStringConvertible {
    
}

// nodes from non-terminal symbols

struct VariablesNode: ExprNode {
    let variableNode: ExprNode?
    let semicolonNode: ExprNode?
    let commentNode: ExprNode?
    var description: String {
        if variableNode != nil {
            return "VariablesNode(VariableNode(\(variableNode)), SemicolonNode(\(semicolonNode)))"
        } else {
            return "VariablesNode(CommentNode(\(commentNode)))"
        }
    }
}

struct VariableNode: ExprNode {
    let at: ExprNode
    let firstValue: ExprNode
    let assign: ExprNode
    let secondValue: ExprNode
    var description: String {
        return "VariableNode(At(\(at)), FirstValue(\(firstValue)), Assign(\(assign)), SecondValue(\(secondValue)))"
    }
}

struct ValueNode: ExprNode {
    let value: ExprNode
    var description: String {
        return "ValueNode(Value\(value))"
    }
}

struct CommentNode: ExprNode {
    let plainComment: ExprNode?
    let commentContent: ExprNode
    let commentBeginning: ExprNode?
    let commentEnding: ExprNode?
    var description: String {
        if plainComment != nil {
            return "CommentNode(PlainComment(\(plainComment)), CommentContent(\(commentContent)))"
        } else {
            return "CommentNode(CommentBeginning(\(commentBeginning)), CommentContent(\(commentContent)), CommentEnding(\(commentEnding)))"
        }
    }
}

// nodes from terminal symbols

struct CloseBracketNode: ExprNode {
    let value: String
    var description: String {
        return "CloseBrakcetNode(\(value))"
    }
}

struct OpenBracketNode: ExprNode {
    let value: String
    var description: String {
        return "OpenBracketNode(\(value))"
    }
}

struct PercentNode: ExprNode {
    let value: String
    var description: String {
        return "PercentNode(\(value))"
    }
}

struct CommaNode: ExprNode {
    let value: String
    var description: String {
        return "CommaNode(\(value))"
    }
}

struct DotNode: ExprNode {
    let value: String
    var description: String {
        return "DotNode(\(value))";
    }
}

struct CloseBuckleNode: ExprNode {
    let value: String
    var description: String {
        return "CloseBuckleNode(\(value))"
    }
}

struct OpenBuckleNode: ExprNode {
    let value: String
    var description: String {
        return "OpenBuckleNode(\(value))"
    }
}

struct CommentEndingNode: ExprNode {
    let value: String
    var description: String {
        return "CommentEndingNode(\(value))"
    }
}

struct CommentBeginningNode: ExprNode {
    let value: String
    var description: String {
        return "CommentBeginningNode(\(value))"
    }
}

struct PlainCommentNode: ExprNode {
    let value: String
    var description: String {
        return "PlainCommentNode(\(value))"
    }
}

struct CommentContentNode: ExprNode {
    let value: String
    var description: String {
        return "CommentContentNode(\(value))"
    }
}

struct NumberNode: ExprNode {
    let value: String
    var description: String {
        return "NumberNode(\(value))"
    }
}

struct SemicolonNode: ExprNode {
    let value: String
    var description: String {
        return "SemicolonNode(\(value))"
    }
}

struct AssignNode: ExprNode {
    let value: String
    var description: String {
        return "AssignNode(\(value))"
    }
}

struct ColorNode: ExprNode {
    let value: String
    var description: String {
        return "ColorNode(\(value))"
    }
}

struct VariableNameNode: ExprNode {
    let value: String
    var description: String {
        return "VariableNameNode(\(value))"
    }
}

struct AtNode: ExprNode {
    let value: String
    var description: String {
        return "AtNode(\(value))"
    }
}
