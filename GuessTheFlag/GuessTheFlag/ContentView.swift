//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by mithun srinivasan on 11/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreValue = 0
    @State private var showingScore = false
    @State private var isGameOver = false
    @State private var newVariable = 0
    @State private var scoreTitle = ""
    @State private var gameOver = "Game is over"
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1,green:0.2,blue:0.45), location: 0.3),
                .init(color: Color(red:0.76,green:0.20,blue:0.20), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            whenPressed(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        }
                    }
                    .alert(scoreTitle, isPresented: $showingScore){
                        Button("Continue", action: askQuestion)
                        Button("reset", action: resetting)
                    }message:{
                        Text("your score \(scoreValue)")
                    }
                    
                    .alert(gameOver, isPresented: $isGameOver){
                        Button("reset", action: resetting)
                    }message: {
                        Text("your final score is \(scoreValue)")
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                
                
                Spacer()
                Spacer()
                Text("Score is: \(scoreValue)")
                    .font(.title.bold())
                Spacer()
            }
        }
    }
    
    func whenPressed(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "correct"
            scoreValue += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }else{
            scoreTitle = "wrong, that is the flag of \(countries[number]) lose 1 point"
            scoreValue -= 1
            showingScore = true

        }
        newVariable += 1
        
        if newVariable == 8{
            isGameOver = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetting(){
        newVariable = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scoreValue = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
