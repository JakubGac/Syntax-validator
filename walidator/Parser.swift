//
//  Parser.swift
//  walidator
//
//  Created by Jakub Gac on 01.04.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

class Parser {
    private var tokens = Array<(terminalSymbol, String)>()
    private var index = 0
    private var nodes = [ExprNode]()
    
    init(createdTerminalSymbols: [(terminalSymbol, String)]) {
        self.tokens = createdTerminalSymbols
    }
    
    var tokensAvailable: Bool {
        return index < tokens.count
    }
    
    func parseExpression() {
        index = 0
        while index < tokens.count {
            if parseVariables() == nil {
                printError()
                break
            }
        }
    }
    
    // parsing variables
    private func parseVariables() -> ExprNode? {
        // first of all we check if our line is a comment
        if let comment = parseComments() {
            // yes, we have a comment
            return VariablesNode(variableNode: nil, semicolonNode: nil, commentNode: comment)
        } else {
            // no, that's definetly not a comment, so let's check if these is a variable
            if let variable = parseVariable() {
                // yes it is, last check, if the next symbol is a semicolon
                if let semicolon = parseSemicolon() {
                    return VariablesNode(variableNode: variable, semicolonNode: semicolon, commentNode: nil)
                } else {
                    return VariablesNode(variableNode: variable, semicolonNode: nil, commentNode: nil)
                }
            } else {
                return nil
            }
        }
    }
    
    // parsing variable
    private func parseVariable() -> ExprNode? {
        // check for dot
        if let dot = parseDot() {
            if let value = parseValue() {
                if let openBuckle = parseOpenBuckle() {
                    if let variables = parseVariables() {
                        while peekCurrentToken().0 != terminalSymbol.closeBuckle {
                            if parseVariables() == nil {
                                return nil
                            }
                        }
                        if let closeBuckle = parseCloseBuckle() {
                            return VariableNode(at: nil, firstValue: value, assign: nil, secondValue: nil, function: nil, dot: dot, openBuckle: openBuckle, variables: variables, closeBuckle: closeBuckle)
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            if let at = parseAt() {
                if let firstValue = parseValue() {
                    if let assign = parseAssign() {
                        if let secondValue = parseValue() {
                            return VariableNode(at: at, firstValue: firstValue, assign: assign, secondValue: secondValue, function: nil, dot: nil, openBuckle: nil, variables: nil, closeBuckle: nil)
                        } else {
                            return nil
                        }
                    } else {
                        return VariableNode(at: at, firstValue: firstValue, assign: nil, secondValue: nil, function: nil, dot: nil, openBuckle: nil, variables: nil, closeBuckle: nil)
                    }
                } else {
                    return nil
                }
            } else {
                if let value = parseValue() {
                    if let assign = parseAssign() {
                        if let function = parseFunction() {
                            return VariableNode(at: nil, firstValue: value, assign: assign, secondValue: nil, function: function, dot: nil, openBuckle: nil, variables: nil, closeBuckle: nil)
                        } else {
                            return nil
                        }
                    } else {
                        return VariableNode(at: nil, firstValue: value, assign: nil, secondValue: nil, function: nil, dot: nil, openBuckle: nil, variables: nil, closeBuckle: nil)
                    }
                } else {
                    return nil
                }
            }
        }
    }
    
    // parse function
    private func parseFunction() -> ExprNode? {
        if let value = parseValue() {
            if let openBracket = parseOpenBracket() {
                if let values = parseValues() {
                    if let closeBracket = parseCloseBracket() {
                        return FunctionNode(value: value, openBracket: openBracket, values: values, closeBracket: closeBracket)
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func parseValues() -> ExprNode? {
        if let function = parseFunction() {
            if let valuesContinuation = parseValuesContinuation() {
                return ValuesNode(variable: nil, valuesContinuation: valuesContinuation, function: function)
            } else {
                return ValuesNode(variable: nil, valuesContinuation: nil, function: function)
            }
        } else {
            if let variable = parseVariable() {
                if let valuesContinuation = parseValuesContinuation() {
                    return ValuesNode(variable: variable, valuesContinuation: valuesContinuation, function: nil)
                } else {
                    return ValuesNode(variable: variable, valuesContinuation: nil, function: nil)
                }
            } else {
                return nil
            }
        }
    }
    
    private func parseValuesContinuation() -> ExprNode? {
        if let comma = parseComma() {
            if let values = parseValues() {
                return ValuesContinuationNode(comma: comma, values: values)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    // parsing semicolon, assign symbol, at symbol, dot, open and close bracket, open and close buckle, comma
    
    private func parseCloseBuckle() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.closeBuckle {
            _ = popCurrentToken()
            return CloseBuckleNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseOpenBuckle() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.openBuckle {
            _ = popCurrentToken()
            return OpenBuckleNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseCloseBracket() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.closeBracket {
            _ = popCurrentToken()
            return CloseBracketNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseOpenBracket() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.openBracket {
            _ = popCurrentToken()
            return OpenBracketNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseDot() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.dot {
            _ = popCurrentToken()
            return DotNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseSemicolon() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.semicolon {
            _ = popCurrentToken()
            return SemicolonNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseAssign() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.assign {
            _ = popCurrentToken()
            return AssignNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseAt() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.at {
            _ = popCurrentToken()
            return AtNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseComma() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.comma {
            _ = popCurrentToken()
            return CommaNode(value: node.1)
        } else {
            return nil
        }
    }

    // parsing values
    private func parseValue() -> ExprNode? {
        let node = peekCurrentToken()
        switch node.0 {
        case terminalSymbol.variableName:
            _ = popCurrentToken()
            return VariableNameNode(value: node.1)
        case terminalSymbol.color:
            _ = popCurrentToken()
            return ColorNode(value: node.1)
        case terminalSymbol.number:
            _ = popCurrentToken()
            return NumberNode(value: node.1)
        case terminalSymbol.percent:
            _ = popCurrentToken()
            return PercentNode(value: node.1)
        default:
            return nil
        }
    }
    
    // parsing comments
    private func parseComments() -> ExprNode? {
        if let plainComment = parsePlainComment() {
            // checking plain comments, like these one
            return plainComment
        } else {
            // checking traditional comments
            if let commentBeginning = parseCommentBeginning() {
                if let commentContent = parseCommentContent() {
                    if let commentEnding = parseCommentEnding() {
                        return CommentNode(plainComment: nil, commentContent: commentContent, commentBeginning: commentBeginning, commentEnding: commentEnding)
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    
    private func parsePlainComment() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.plainComment {
            let plainCommentNode = PlainCommentNode(value: popCurrentToken().1)
            if let commentContent = parseCommentContent() {
                return CommentNode(plainComment: plainCommentNode, commentContent: commentContent, commentBeginning: nil, commentEnding: nil)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func parseCommentContent() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.commentContent {
            _ = popCurrentToken()
            return CommentContentNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseCommentBeginning() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.commentBeginning {
            _ = popCurrentToken()
            return CommentBeginningNode(value: node.1)
        } else {
            return nil
        }
    }
    
    private func parseCommentEnding() -> ExprNode? {
        let node = peekCurrentToken()
        if node.0 == terminalSymbol.commentEnding {
            _ = popCurrentToken()
            return CommentEndingNode(value: node.1)
        } else {
            return nil
        }
    }
    
    // functions for reading next tokens
    private func peekCurrentToken() -> (terminalSymbol, String) {
        return tokens[index]
    }
    
    private func popCurrentToken() -> (terminalSymbol, String) {
        let tmp = index
        index += 1
        return tokens[tmp]
    }
    
    private func printError() {
        let tmp = index
        print("Nieoczekiwany ostatni symbol: \(tokens[tmp].1)")
        print("\(tokens[tmp - 3].1)\(tokens[tmp - 2].1)\(tokens[tmp - 1].1)\(tokens[tmp].1)")
    }
}
