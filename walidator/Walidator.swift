//
//  File.swift
//  walidator
//
//  Created by Jakub Gac on 02.03.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

class Walidator {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argument = CommandLine.arguments[1] // pobieramy tutaj pierwszy argument
        let (option, value) = consoleIO.getOption(option: argument.substring(from: argument.characters.index(argument.startIndex, offsetBy: 1))) // dopasowujemy go z istniejącymi
        
        switch option {
        case .interactive:
            interactiveMode()
        case .counting:
            print("Cos tam sobie liczę")
        case .help:
            print("Witam w pomocy dla programu Analizator leksykalny")
        case .unknown:
            consoleIO.writeMessage("Błąd. Nie znam takiej opcji wywołania - \(value)", to: .error)
            consoleIO.writeMessage("Kończę działanie")
        default:
            consoleIO.writeMessage("Kończę działanie")
            break
        }
    }
    
    private func interactiveMode() {
        consoleIO.writeMessage("Witaj w trybie interaktywnym. Możesz dowolnie używać następujących opcji:")
        print("a -> tryb liczenia")
        print("q -> zakończenie działania programu")
        
        var shouldQuit = false
        while !shouldQuit {
            let (option, _) = consoleIO.getOption(option: consoleIO.getInput())
            
            switch option {
            case .counting:
                print("Cos tam sobie liczę")
            case .quit:
                shouldQuit = true
                consoleIO.writeMessage("Kończę działanie")
            default:
                consoleIO.writeMessage("Błąd. Nie znam takiej opcji wywołania", to: .error)
                consoleIO.writeMessage("Podaj inna wartosc")
            }
        }
    }
}
