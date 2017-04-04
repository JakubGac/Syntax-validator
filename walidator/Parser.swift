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
    
    init(createdTerminalSymbols: [(terminalSymbol, String)]) {
        self.tokens = createdTerminalSymbols
    }
    
    var tokensAvailable: Bool {
        return index < tokens.count
    }
    
    func parseExpression() throws -> [Any] {
        index = 0
        var nodes = [Any]()
        
        while index < tokens.count {
            let node = try parseVariables()
            nodes.append(node)
        }
        
        return nodes
    }
    
    enum ParseError: Error {
        case ExpectedAt
        case ExpectedAssign
        case ExpectedSemicolon
        case ExpectedValue
        case ExpectedCommentContent
        case ExpectedPlainComment
        case ExpectedCommentBeginning
        case ExpecterCommentEnding
        case ExpectedVariables
        case ExpectedComment
    }
    
    // parsing non-terminal symbols
    
    private func parseVariables() throws -> ExprNode {
        let node = peekCurrentToken()
        switch node.0 {
        case terminalSymbol.at:
            let variable = try parseVariable()
            let semicolon = try parseSemicolon()
            return VariablesNode(variableNode: variable, semicolonNode: semicolon, commentNode: nil)
        case terminalSymbol.plainComment:
            let comment = try parseComment()
            return VariablesNode(variableNode: nil, semicolonNode: nil, commentNode: comment)
        case terminalSymbol.commentBeginning:
            let comment = try parseComment()
            return VariablesNode(variableNode: nil, semicolonNode: nil, commentNode: comment)
        default:
            print("Nieoczekiwana wartosc -> \(node.1)")
            throw ParseError.ExpectedVariables
        }
    }
    
    private func parseVariable() throws -> ExprNode {
        let at = try parseAt()
        let firstValue = try parseValue()
        let assign = try parseAssign()
        let secondValue = try parseValue()
        return VariableNode(at: at, firstValue: firstValue, assign: assign, secondValue: secondValue)
    }
    
    // parsing semicolon, assing symbol, at symbol
    
    private func parseSemicolon() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.semicolon = node.0 else {
            print("Oczekiwana wartosc -> ';', znaleziono -> \(node.1)")
            throw ParseError.ExpectedSemicolon
        }
        return SemicolonNode(value: node.1)
    }
    
    private func parseAssign() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.assign = node.0 else {
            print("Oczekiwana wartosc -> ':', znaleziono -> \(node.1)")
            throw ParseError.ExpectedAssign
        }
        return AssignNode(value: node.1)
    }
    
    private func parseAt() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.at = node.0 else {
            print("Oczekiwana wartosc -> '@', znaleziono -> \(node.1)")
            throw ParseError.ExpectedAt
        }
        return AtNode(value: node.1)
    }

    // parsing values
    
    private func parseValue() throws -> ExprNode {
        let node = popCurrentToken()
        switch node.0 {
        case terminalSymbol.variableName:
            return VariableNameNode(value: node.1)
        case terminalSymbol.color:
            return ColorNode(value: node.1)
        case terminalSymbol.number:
            return NumberNode(value: node.1)
        default:
            print("Oczekiwana wartosc -> nazwa zmiennej, kolor lub liczba, znaleziono -> \(node.1)")
            throw ParseError.ExpectedValue
        }
    }
    
    
    // parsing comments

    private func parseComment() throws -> ExprNode {
        let node = peekCurrentToken()
        switch node.0 {
        case terminalSymbol.plainComment:
            let plainComment = try! parsePlainComment()
            let commentContent = try! parseCommentContent()
            return CommentNode(plainComment: plainComment, commentContent: commentContent, commentBeginning: nil, commentEnding: nil)
        case terminalSymbol.commentBeginning:
            let commentBeginning = try parseCommentBeginning()
            let commentContent = try parseCommentContent()
            let commentEnding = try parseCommentEnding()
            return CommentNode(plainComment: nil, commentContent: commentContent, commentBeginning: commentBeginning, commentEnding: commentEnding)
        default:
            print("Nieoczekiwana wartosc -> \(node.0)")
            throw ParseError.ExpectedComment
        }
    }
    
    private func parseCommentEnding() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.commentEnding = node.0 else {
            print("Oczekiwana wartosc -> '*/', znaleziono -> \(node.1)")
            throw ParseError.ExpecterCommentEnding
        }
        return CommentEndingNode(value: node.1)
    }
    
    private func parseCommentBeginning() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.commentBeginning = node.0 else {
            print("Oczekiwana wartosc -> '/*', znaleziono -> \(node.1)")
            throw ParseError.ExpectedCommentBeginning
        }
        return CommentBeginningNode(value: node.1)
    }
    
    private func parsePlainComment() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.plainComment = node.0 else {
            print("Oczekiwana wartosc -> '//', znaleziono -> \(node.1)")
            throw ParseError.ExpectedPlainComment
        }
        return PlainCommentNode(value: node.1)
    }
    
    private func parseCommentContent() throws -> ExprNode {
        let node = popCurrentToken()
        guard case terminalSymbol.commentContent = node.0 else {
            print("Oczekiwana wartosc -> 'tresc komentarza', znaleziono -> \(node.1)")
            throw ParseError.ExpectedCommentContent
        }
        return CommentContentNode(value: node.1)
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
}
