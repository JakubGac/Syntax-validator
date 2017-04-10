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
        if let commentNode = commentNode {
            return ("\(commentNode)")
        } else {
            if let variableNode = variableNode {
                if let semicolonNode = semicolonNode {
                    return ("\(variableNode)\(semicolonNode)")
                } else {
                    return ("\(variableNode)")
                }
            } else {
                return ("Nieoczekiwany symbol)")
            }
        }
    }
}

struct VariableNode: ExprNode {
    let at: ExprNode?
    let firstValue: ExprNode?
    let assign: ExprNode?
    let secondValue: ExprNode?
    let function: ExprNode?
    let dot: ExprNode?
    let openBuckle: ExprNode?
    let variables: ExprNode?
    let closeBuckle: ExprNode?
    var description: String {
        if let at = at {
            if let firstValue = firstValue {
                if let assign = assign {
                    return ("\(at)\(firstValue)\(assign)\(secondValue!)")
                } else {
                    return ("\(at)\(firstValue)")
                }
            } else {
                return ("Nieoczekiwany symbol)")
            }
        } else {
            if let dot = dot {
                return ("\(dot)\(firstValue!)\(openBuckle!)\(variables!)\(closeBuckle!)")
            } else {
                if let firstValue = firstValue {
                    if let assign = assign {
                        return ("\(firstValue)\(assign)\(function!)")
                    } else {
                        return ("\(firstValue)")
                    }
                } else {
                    return ("Nieoczekiwany symbol)")
                }
            }
        }
    }
}

struct ValueNode: ExprNode {
    let value: ExprNode
    var description: String {
        return "\(value)"
    }
}

struct CommentNode: ExprNode {
    let plainComment: ExprNode?
    let commentContent: ExprNode
    let commentBeginning: ExprNode?
    let commentEnding: ExprNode?
    var description: String {
        if let plainComment = plainComment {
            return ("\(plainComment)\(commentContent)")
        } else {
            if let commentBeginning = commentBeginning {
                return ("\(commentBeginning)\(commentContent)\(commentEnding!)")
            } else {
                return ("Nieoczekiwany symbol)")
            }
        }
    }
}

struct FunctionNode: ExprNode {
    let value: ExprNode
    let openBracket: ExprNode
    let values: ExprNode
    let closeBracket: ExprNode
    var description: String {
        return "\(value)\(openBracket)\(values)\(closeBracket)"
    }
}

struct ValuesNode: ExprNode {
    let variable: ExprNode?
    let valuesContinuation: ExprNode?
    let function: ExprNode?
    var description: String {
        if let variable = variable {
            return "\(variable)\(String(describing: valuesContinuation))"
        } else if let function = function {
            return "\(function)\(String(describing: valuesContinuation))"
        } else {
            return "nic"
        }
    }
}

struct ValuesContinuationNode: ExprNode {
    let comma: ExprNode
    let values: ExprNode
    var description: String {
        return "\(comma))\(values)"
    }
}

// nodes from terminal symbols

struct CloseBracketNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct OpenBracketNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct PercentNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct CommaNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct DotNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)";
    }
}

struct CloseBuckleNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct OpenBuckleNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct CommentEndingNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct CommentBeginningNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct PlainCommentNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct CommentContentNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct NumberNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct SemicolonNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct AssignNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct ColorNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct VariableNameNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}

struct AtNode: ExprNode {
    let value: String
    var description: String {
        return "\(value)"
    }
}
