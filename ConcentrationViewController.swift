//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
	 
    private lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        guard cardButtons != nil else { return 0 }
        return (cardButtons.count + 1) / 2
    }
	 
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        newGame("")
    }
    
    @IBOutlet var concentrationView: UIView!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
	
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	func updateViewFromModel() {
        guard cardButtons != nil else { return }
        updateFlipCountLabel()
        updateScoreLabel()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : actualColorThemes[0]
            }
        }
        concentrationView.backgroundColor = actualColorThemes[1]
	}
    
    var theme: String? {
        didSet {
            actualGameEmojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var seenCards = ""
    private var actualGameEmojiChoices = ""
    var actualColorThemes = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
	
	private var emoji = [Card: String]()
	
	private func emoji(for card: Card) -> String {
//        if actualGameEmojiChoices == "" {
//            selectTheme()
//        }
		if emoji[card] == nil, actualGameEmojiChoices.count > 0 {
            let randomStringIndex = actualGameEmojiChoices.index(actualGameEmojiChoices.startIndex, offsetBy: actualGameEmojiChoices.count.arc4random)
			emoji[card] = String(actualGameEmojiChoices.remove(at: randomStringIndex))
		}
		return emoji[card] ?? "?"
	}
    
//    private func selectTheme(){
//        let randomStringIndex = gameThemeArray.index(gameThemeArray.startIndex, offsetBy: gameThemeArray.count.arc4random)
//        actualGameEmojiChoices = gameThemeArray[randomStringIndex].key
//        actualColorThemes = gameThemeArray[randomStringIndex].value
//    }
    
    @IBAction func newGame(_ sender: Any) {
        game.startGame(numberOfPairsOfCards: numberOfPairsOfCards)
//        selectTheme()
        updateViewFromModel()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
