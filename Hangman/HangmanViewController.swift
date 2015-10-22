//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var word: String!
    
    @IBOutlet var wordtoGuess: UILabel!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var newGameButton: UIButton!
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var guessedLabel: UILabel!
    
    var game: Hangman!
    var wrongGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGame() {
        self.game = Hangman()
        self.game.start()
        self.wordtoGuess.text = self.game.knownString
        self.guessedLabel.text = self.game.guesses()
        self.wrongGuesses = 0
        displayImage(wrongGuesses)
    }
    
    @IBAction func guess() {
        let flag = self.game.guessLetter(textField.text!)
        game.guessLetter(textField.text!)
        self.guessedLabel.text = self.game.guesses()
        self.wordtoGuess.text = self.game.knownString
        print(self.game.answer)
        print("wrongGuesses ", wrongGuesses)
        if (!flag) {
            self.wrongGuesses += 1
        }
        displayImage(wrongGuesses)
        let newGameHandler = { (action: UIAlertAction!) -> Void in
            self.newGame()
        }
        let defaultAction = UIAlertAction(title: "New Game", style: .Default, handler: newGameHandler)
        if (wrongGuesses > 6) {
            let lost = UIAlertController(title: "Hanged Man!", message: "You lost! Try again!", preferredStyle: UIAlertControllerStyle.Alert)
            lost.addAction(defaultAction)
            presentViewController(lost, animated: true, completion: nil)
        }
        if (self.game.guessedAll()) {
            let win = UIAlertController(title: "Man Not Hanged!", message: "You won! Play another game?", preferredStyle: UIAlertControllerStyle.Alert)
            win.addAction(defaultAction)
            presentViewController(win, animated: true, completion: nil)
        }
    }
    
    func displayImage(incorrect: Int) {
        if (incorrect == 0) {
            image.image = UIImage(named: ("basic-hangman-img/hangman1.gif"))
        } else if (incorrect == 1) {
            image.image = UIImage(named: ("basic-hangman-img/hangman2.gif"))
        } else if (incorrect == 2) {
            image.image = UIImage(named: ("basic-hangman-img/hangman3.gif"))
        } else if (incorrect == 3) {
            image.image = UIImage(named: ("basic-hangman-img/hangman4.gif"))
        } else if (incorrect == 4) {
            image.image = UIImage(named: ("basic-hangman-img/hangman5.gif"))
        } else if (incorrect == 5) {
            image.image = UIImage(named: ("basic-hangman-img/hangman6.gif"))
        } else if (incorrect == 6) {
            image.image = UIImage(named: ("basic-hangman-img/hangman7.gif"))
        }
    }
}

