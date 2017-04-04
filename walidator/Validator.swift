//
//  Walidator.swift
//  walidator
//
//  Created by Jakub Gac on 20.03.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

class Validator {
    private var textToCheck = ""
    
    init(readedText: String) {
        self.textToCheck = readedText
    }
    
    func startValidation() {
        // lexer
        let lexer = Lexer(text: textToCheck)
        lexer.scan()
        
        //for item in lexer.getTerminalSymbols() {
        //    print("\(item.0) - \(item.1)")
        //}
        
        // parser
        let parser = Parser(createdTerminalSymbols: lexer.getTerminalSymbols())
        var nodes = [Any]()
        do {
            nodes = try parser.parseExpression()
        }
        catch {
            print(error)
        }
        for item in nodes {
            print(item)
            print()
        }
    }
}
