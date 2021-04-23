//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jainam Shah  on 10/22/20.
//

import SwiftUI



struct ContentView: View {
    @State private var countries : Array<String> = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing : 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    Button(action:{
                        flagTapped(number)
                    }){
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color: .black, radius:4)
                    }
                }
                Label("Score : \(score)", systemImage: "person.crop.circle")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            score -= 1
            if score <= 0 {
                score = 0
            }
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
