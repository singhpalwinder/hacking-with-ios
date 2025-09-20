//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Paul on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var tries = 1
    @State private var showingScore = false
    @State private var choseFlag = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(userScore) Tries: \(tries)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
    }

    func flagTapped(_ number: Int) {
        
        
        
        if number == correctAnswer {
            choseFlag = true
            scoreTitle = "Correct"
            if tries == 1 || tries == 0{
                userScore += 5
            }
            else if tries == 2{
                userScore += 2
            }
            else if tries == 3 {
                userScore += 1
            }
            
          
        } else {
            scoreTitle = "Wrong"
            tries += 1
            
            if tries > 3 {
                choseFlag = true
            }
        }

        showingScore = true
    }

    func askQuestion() {
        if choseFlag{
            countries.shuffle()
            tries = 1
            choseFlag = false
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

#Preview {
    ContentView()
}
