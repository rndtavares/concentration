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
	
    private var gameThemeArray = ["🦇😱🙀😈🎃👻🍭🍬🍎" : [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],
                                     "😀☺️😍😭🤓😔😡😱🤯🤭😴" : [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)],
                                     "🐶🐱🐭🦊🐼🐨🦁🐮🐷🐸🐵" : [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)],
                                     "⚽️🏀🏈⚾️🎾🏐🏉🎱🏆🥇" : [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                                     "🚗🚔🚍🚲🛴🚒🚁✈️🛳🚊" : [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)],
                                     "🇦🇷🇧🇷🇨🇦🇯🇵🇿🇦🇩🇪🇺🇸🇪🇸🇬🇷🇮🇱" : [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]]
    private var seenCards = ""
    private var actualGameEmojiChoices = ""
    private var actualColorThemes = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]
	
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
        let randomStringIndex = gameThemeArray.index(gameThemeArray.startIndex, offsetBy: gameThemeArray.count.arc4random)
        actualGameEmojiChoices = gameThemeArray[randomStringIndex].key
        actualColorThemes = gameThemeArray[randomStringIndex].value
    }
    
    @IBAction func newGame(_ sender: Any) {
        game.startGame(numberOfPairsOfCards: numberOfPairsOfCards)
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















