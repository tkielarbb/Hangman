//
//  Core Functions.swift
//  Hangman
//
//  Created by Tomasz Kielar on 07/06/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

extension SoloGameVC {
    func checkIfContains() {
        
            
        if theWord.contains(checkCharacter) {
            let temporaryIndexes = createIndexes(contains: checkCharacter)
            let counter = temporaryIndexes.count * 2
            points += counter
            print(temporaryIndexes)
            for element in temporaryIndexes {
                if element < 6 {
                   let labelInStack = lineOneHorizontalStack.arrangedSubviews[element] as! UILabel
                    labelInStack.text = checkCharacter
                }
                else if element >= 6 && element < 12 {
                    let labelInStack = lineTwoHorizontalStack.arrangedSubviews[element-6] as! UILabel
                    labelInStack.text = checkCharacter
                }
                else if element >= 12 && element <= 18 {
                    let labelInStack = lineThreeHorizontalStack.arrangedSubviews[element-12] as! UILabel
                    labelInStack.text = checkCharacter
                }
            }
            updatePoints()
        }
        else {
            addMistake()
            points -= 1
            updatePoints()
        }
        let checkIfLostAfterPlay = winOrLoose.ifLost(mistakePoints: mistakeCounter)
        let checkIfWonAfterPlay = winOrLoose.ifWon(firstStack: lineOneHorizontalStack, secondStack: lineTwoHorizontalStack, thirdStack: lineThreeHorizontalStack, wordCharacters: separatedWord)
        if checkIfWonAfterPlay == true {
            print("won")
            winOrLoose.executeWin(imagesField: gameImagesField, textField: wordField, endStack: endGameStack, view: view)
            winOrLoose.configureEndScreenWon(titleLabel: winLooseLabel, scoreLabel: scoreLabel, submitButton: submitButton, nextButton: nextRoundButton, points: points)
            }
        if checkIfLostAfterPlay == true {
            print("lost")
            winOrLoose.executeLost(imagesField: gameImagesField, textField: wordField, endStack: endGameStack, view: view)
            winOrLoose.configureEndScreenLost(titleLabel: winLooseLabel, scoreLabel: scoreLabel, submitButton: submitButton, nextButton: nextRoundButton, points: points)
            }
    }
    
    func createIndexes(contains: String)->[Int] {
        var array : [Int] = []
        for number in 0..<separatedWord.count {
            if separatedWord[number] == checkCharacter {
                array.append(number)
                print("dodano pozycje \(number)")
            }
        }
        return array
    }
    func addMistake() {
        let checkTheme = defaults.string(forKey: "theme")
        mistakeCounter += 1
        gameImagesField.image = UIImage(named: imagesNames[mistakeCounter])
        if checkTheme == "Dark" || checkTheme == "Ciemny" {
            gameImagesField.setImageColor(color: .white)
        }
        
    }
    
    func updatePoints() {
        let getLanguage = defaults.string(forKey: "Language")
        if getLanguage == "Polski" || getLanguage == "Polish" {
            pointsLbl.text = "Punkty:\(points)"
        }
        else {
            pointsLbl.text = "Points:\(points)"
        }
    }
    
    func won() {
        hideThings()
    }
    
    func loose() {
        hideThings()
    }
    func hideThings() {
        wordField.isHidden = true
    }
    
}

