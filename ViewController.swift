//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	 
    private lazy var game: Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
	
	private(set) var flipCount = 0 {
		didSet {
            updateFlipCountLabel()
		}
	}
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
	
	@IBOutlet private var cardButtons: [UIButton]!
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			}
		}
		
	}
	
	private var emojiChoicesArray = ["🦇😱🙀😈🎃👻🍭🍬🍎", "😀☺️😍😭🤓😔😡😱🤯🤭😴", "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵", "⚽️🏀🏈⚾️🎾🏐🏉🎱🏆🥇", "🚗🚔🚍🚲🛴🚒🚁✈️🛳🚊", "🇦🇷🇧🇷🇨🇦🇯🇵🇿🇦🇩🇪🇺🇸🇪🇸🇬🇷🇮🇱"]
    private var actualGameEmojiChoices = ""
	
	private var emoji = [Card: String]()
	
	private func emoji(for card: Card) -> String {
        if actualGameEmojiChoices == "" {
            selectTheme()
        }
		if emoji[card] == nil, actualGameEmojiChoices.count > 0 {
            let randomStringIndex = actualGameEmojiChoices.index(actualGameEmojiChoices.startIndex, offsetBy: actualGameEmojiChoices.count.arc4random)
			emoji[card] = String(actualGameEmojiChoices.remove(at: randomStringIndex))
		}
		return emoji[card] ?? "?"
	}
    
    private func selectTheme(){
        let randomStringIndex = emojiChoicesArray.index(emojiChoicesArray.startIndex, offsetBy: emojiChoicesArray.count.arc4random)
        actualGameEmojiChoices = String(emojiChoicesArray[randomStringIndex])
    }
    
    @IBAction func newGame(_ sender: Any) {
        game.startGame(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        selectTheme()
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















