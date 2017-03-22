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
        
        
        
    }
}

/* 
 porównywanie
 let typePattern = "@[a-z]+"
 if let typeRange = textToCheck.range(of: typePattern, options: .regularExpression) {
 print("First type: \(textToCheck[typeRange])")
 }
 */
