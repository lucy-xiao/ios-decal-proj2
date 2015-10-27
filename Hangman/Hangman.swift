//
//  Hangman.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import Foundation

class Hangman {
    var words: HangmanWords!
    var answer: String?
    var knownString: String?
    var startString: String?
    var guessedLetters: NSMutableArray?
    var guessedCorrectly = 0
    var letterCount = 0
    
    init() {
        words = HangmanWords()
    }
    
    func start() {
        let word = words.getRandomWord()
        answer = word
        knownString = ""
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if (word as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                knownString = knownString! + " "
            } else {
                knownString = knownString! + "_"
                letterCount += 1
            }
        }
        startString = knownString
        guessedLetters = NSMutableArray()
    }
    
    func guessLetter(letter: String) -> Bool {
        var result = false
        if guessedLetters!.containsObject(letter.uppercaseString) {
            return true
        }
        guessedLetters!.addObject(letter.uppercaseString)
        var chars = Array(answer!.characters)
        
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if String(chars[i]) == letter.uppercaseString {
                result = true
                knownString = "\((knownString! as NSString).substringToIndex(i))" + "\(letter.uppercaseString)"
                            + "\((knownString! as NSString).substringFromIndex(i+1))"
                guessedCorrectly += 1
            }
        }
        return result
    }
    
    func guesses() -> String {
        var added = false
        if guessedLetters!.count == 0 {
            return ""
        }
        var result = ""
        for (var i = 0; i < guessedLetters!.count; i += 1) {
            let letter: String = guessedLetters!.objectAtIndex(i) as! String
            var chars = Array(answer!.characters)
            result = result + letter + " "
            
        }
        return result
    }
    
    func guessedAll() -> Bool {
        var result = false
        if (guessedCorrectly == letterCount) {
            result = true
        }
        return result
    }
    
    func startOver() {
        knownString = startString
        guessedLetters = NSMutableArray()
        guessedCorrectly = 0
        letterCount = 0
    }

}