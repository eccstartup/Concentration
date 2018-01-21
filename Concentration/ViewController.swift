//
//  ViewController.swift
//  Concentration
//
//  Created by Yi Lu on 14/01/2018.
//  Copyright © 2018 Yi Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var matchedNumber = 0
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    @IBOutlet var cardButtons: [UIButton]!

    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)!
        if !game.cards[cardNumber].isMatched {
            flipCount += 1
        }
        game.chooseCard(at: cardNumber)
        for index in game.cards.indices {
            let card = game.cards[index]
            if card.isMatched {
                matchedNumber += 1
            }
        }
        if matchedNumber == game.cards.count {
            flipCountLabel.text = "You win!"
        }
        matchedNumber = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    let emojisAll = ["👻","🎃","😈","👹","👽","😻","🤪","🤓","🌚","🍄","🔥","💧","💯"]
    lazy var emojiChoices = emojisAll

    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    @IBAction func resetGame(_ sender: UIButton) {
        flipCount = 0
        emojiChoices = emojisAll
        emoji = [Int:String]()
        game.resetCards()
        updateViewFromModel()
    }
    
}

