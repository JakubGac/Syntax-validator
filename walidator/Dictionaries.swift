//
//  Dictionary.swift
//  walidator
//
//  Created by Jakub Gac on 20.03.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

struct grammarOfTerminalSymbols {
    static let semicolon = ";"
    static let at = "@"
    static let assign = ":"
    static let variableName = "[a-z-]+"
    static let color = "#[a-z0-9]+"
    static let number = "[0-9.]+"
    static let string = "[a-z]+"
    static let percent = "[0-9]+%"
    static let openBracket = "\\("
    static let closeBracket = "\\)"
    static let comma = ","
    static let dot = "\\."
    static let openBuckle = "\\{"
    static let closeBuckle = "\\}"
    static let commentContent = "[a-zA-Z0-9`% !]+"
    static let plainComment = "//"
    static let commentBeginning = "\\/\\*"
    static let commentEnding = "\\*."
    static let test = ""
}

enum terminalSymbol {
    case semicolon
    case at
    case assign
    case variableName
    case color
    case number
    case string
    case percent
    case openBracket
    case closeBracket
    case comma
    case dot
    case openBuckle
    case closeBuckle
    case commentContent
    case commentBeginning
    case commentEnding
    case plainComment
    case unknown
    case indefinite
    case test
}
