//
// Copyright (c) 2024 Ivana Rast. All rights reserved.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
@Observable class ViewModel {
    private(set) var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    private(set) var scoreTitle = ""
    private(set) var score = 0
    private(set) var correctAnswer = Int.random(in: 0...2)
    private(set) var numberOfTries = 8
    private(set) var selectedIndex = -1
    
    var showingScore = false
    var showingGameFinished = false
    
    func getCorrectCountry() -> String {
        return countries[correctAnswer]
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        
        if (numberOfTries == 0) {
            showingGameFinished = true
        }
        
        selectedIndex = -1
    }
    
    func resetGame() {
        score = 0
        numberOfTries = 8
        scoreTitle = ""
    }
    
    func flagTapped(_ number: Int) {
        numberOfTries -= 1
        
        if number == correctAnswer {
            increaseScore()
            scoreTitle = "Correct"
        } else {
            reduceScore()
            let selectedCountry = countries[number]
            scoreTitle = "Wrong! That’s the flag of \(selectedCountry)"
        }
        
        selectedIndex = number
        showingScore = true
    }
    
    private func reduceScore() {
        if score > 0 {
            score -= 1
        }
    }
    
    private func increaseScore() {
        score += 1
    }
}

