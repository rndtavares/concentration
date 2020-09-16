//
//  Concentration.swift
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var score = 0
    private(set) var flipCount = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if cards[index].everSeen{
                        score -= 1
                    }
                    if cards[matchIndex].everSeen {
                        score -= 1
                    }
                    cards[matchIndex].everSeen = true
                    cards[index].everSeen = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        startGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    mutating func startGame(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.startGame(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        score = 0
        flipCount = 0
        cards.removeAll()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //    TODO: Shuffle the cards
        var shuflledCards = [Card]()
        while cards.count > 1 {
            shuflledCards.append(cards.remove(at: cards.count.arc4random))
        }
        cards += shuflledCards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
