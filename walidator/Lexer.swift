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
    private var createdTerminalSymbols = Array<(terminalSymbols, String)>()
    
    init(text: String) {
        self.textToScan = text
    }
    
    func scan() {
        // moving each element from string to array of tuples (terminalSymbol, String)
        moveToArray()
        
        //test()
        // potem zaczynamy przeszukiwania od symboli specjalnych
        // potem przeszukujemy słowa i dopasowujemy do gramatyk
        // na koniec usuwamy znaki \t \n \r ""
        for item in createdTerminalSymbols {
            print(item)
        }
    }
    
    private func moveToArray() {
        for character in textToScan.characters {
            createdTerminalSymbols.append((.unknown, "\(character)"))
        }
    }
    
    
    
    private func test() {
        let digitSet = CharacterSet.decimalDigits
        for item in createdTerminalSymbols {
            for character in item.1.unicodeScalars {
                if digitSet.contains(character) {
                    print("\(item.1) to liczba")
                } else {
                    print("\(item.1) to nie liczba")
                }
            }
        }
    }
    
    private func cleanText() {
        for character in textToScan.characters {
            if character.description == "\t" || character.description == "\n" || character.description == "\r" || character.description == " " {
                textToScan.characters.remove(at: textToScan.characters.index(of: character)!)
            }
        }
    }
    
    private func findSpecialSymbols() {
        // special symbols are: @ : ; . , { } /* *\ // ( )
        for index in textToScan.characters.indices {
            switch textToScan[index] {
            case grammarOfTerminalSymbols.semicolon.characters.first!:
                createdTerminalSymbols.append((.semicolon, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.at.characters.first!:
                createdTerminalSymbols.append((.at, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.assign.characters.first!:
                createdTerminalSymbols.append((.assign, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.openBracket.characters.first!:
                createdTerminalSymbols.append((.openBracket, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.closeBracket.characters.first!:
                createdTerminalSymbols.append((.closeBracket, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.dot.characters.first!:
                let nextCharacter = textToScan[textToScan.characters.index(of: textToScan[textToScan.characters.index(after: index)])!]
                if !(nextCharacter >= "0" && nextCharacter <= "9") {
                    createdTerminalSymbols.append((.dot, "\(textToScan[index])"))
                } else {
                    createdTerminalSymbols.append((.unknown, "\(textToScan[index])"))
                }
            case grammarOfTerminalSymbols.comma.characters.first!:
                createdTerminalSymbols.append((.comma, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.openBuckle.characters.first!:
                createdTerminalSymbols.append((.openBuckle, "\(textToScan[index])"))
            case grammarOfTerminalSymbols.closeBuckle.characters.first!:
                createdTerminalSymbols.append((.closeBuckle, "\(textToScan[index])"))
            default:
                createdTerminalSymbols.append((.unknown, "\(textToScan[index])"))
            }
        }
    }
}
