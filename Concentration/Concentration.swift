//
//  Concentration.swift
//  Concentration
//
//  Created by Yi Lu on 14/01/2018.
//  Copyright © 2018 Yi Lu. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var numberOfPairs = 0
    
    init(numberOfPairsOfCards: Int) {
        numberOfPairs = numberOfPairsOfCards
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetCards() {
//        for index in cards.indices {
//            cards[index].isFaceUp = false
//            cards[index].isMatched = false
//        }
        cards = [Card]()
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        var last = cards.count - 1
        
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, rand)
            last -= 1
        }
    }
}

