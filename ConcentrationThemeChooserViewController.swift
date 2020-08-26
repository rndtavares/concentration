//
//  ConcentrationThemeChooserViewController.swift
//  Lecture 1 - Concentration
//
//  Created by Ronaldo Tavares da Silva on 25/08/2020.
//  Copyright © 2020 Michel Deiman. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let gameThemeArray = ["Halloween":"🦇😱🙀😈🎃👻🍭🍬🍎",
                                  "Emojis":"😀☺️😍😭🤓😔😡😱🤯🤭😴",
                                  "Animals":"🐶🐱🐭🦊🐼🐨🦁🐮🐷🐸🐵",
                                  "Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🏆🥇",
                                  "Vehicles":"🚗🚔🚍🚲🛴🚒🚁✈️🛳🚊",
                                  "Flags":"🇦🇷🇧🇷🇨🇦🇯🇵🇿🇦🇩🇪🇺🇸🇪🇸🇬🇷🇮🇱"]
    
    let gameColorArray = ["Halloween" : [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],
                                  "Emojis" : [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)],
                                  "Animals" : [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)],
                                  "Sports" : [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                                  "Vehicles" : [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)],
                                  "Flags" : [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = gameThemeArray[themeName], let colors = gameColorArray[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.actualColorThemes = colors
                    cvc.theme = theme
                }
            }
        }
    }
}
