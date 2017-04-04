//
//  Lexer.swift
//  walidator
//
//  Created by Jakub Gac on 22.03.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

class Lexer {
    private var textToScan = ""
    private var createdTerminalSymbols = Array<(terminalSymbol, String)>()
    
    init(text: String) {
        self.textToScan = text
    }
    
    func scan() {
        tokenize()
    }
    
    func getTerminalSymbols() -> [(terminalSymbol, String)] {
        return createdTerminalSymbols
    }
    
    typealias TokenGenerator = (String) -> terminalSymbol?
    let tokenList: [(String, TokenGenerator)] = [
        ("\n", { _ in nil}),
        ("\t", { _ in nil}),
        (" ", { _ in nil}),
        (grammarOfTerminalSymbols.at, { _ in .at }),
        (grammarOfTerminalSymbols.dot, { _ in .dot }),
        (grammarOfTerminalSymbols.comma, { _ in .comma }),
        (grammarOfTerminalSymbols.openBuckle, { _ in .openBuckle }),
        (grammarOfTerminalSymbols.closeBuckle, { _ in .closeBuckle }),
        (grammarOfTerminalSymbols.semicolon, { _ in .semicolon }),
        (grammarOfTerminalSymbols.color, { _ in .color }),
        (grammarOfTerminalSymbols.percent, { _ in .percent }),
        (grammarOfTerminalSymbols.number, { _ in .number }),
        (grammarOfTerminalSymbols.assign, { _ in .assign }),
        (grammarOfTerminalSymbols.variableName, { _ in .variableName }),
        (grammarOfTerminalSymbols.openBracket, { _ in .openBracket }),
        (grammarOfTerminalSymbols.closeBracket, { _ in .closeBracket }),
        (grammarOfTerminalSymbols.plainComment, { _ in .plainComment }),
        (grammarOfTerminalSymbols.commentBeginning, { _ in .commentBeginning }),
        (grammarOfTerminalSymbols.commentEnding, { _ in .commentEnding }),
        (grammarOfTerminalSymbols.commentContent, { _ in .commentContent })
    ]
    
    private func tokenize() {
        var content = textToScan
        
        while content.characters.count > 0 {
            var matched = false
            
            for (pattern, generator) in tokenList {
                if let m = content.match(regex: pattern) {
                    
                    if let t = generator(m) {
                        createdTerminalSymbols.append(t,m)
                    }
                    
                    content = content.substring(from: content.index(content.startIndex, offsetBy: m.characters.count))
                    matched = true
                    
                    break
                }
            }
            
            if !matched {
                let index = content.index(content.startIndex, offsetBy: 1)
                createdTerminalSymbols.append((.unknown, content.substring(to: index)))
                content = content.substring(from: index)
            }
        }
    }
}
