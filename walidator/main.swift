//
//  main.swift
//  walidator
//
//  Created by Jakub Gac on 02.03.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

let walidator = Walidator()

if CommandLine.argc < 2 {
    ConsoleIO.printInfo()
} else {
    walidator.staticMode()
}
