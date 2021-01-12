//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Krystyna Waniova on 22/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            //        ZStack {
            //            Color(red: 0.7, green: 0.7, blue: 0.6).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //
            //            Color.green.frame(width: 200, height: 200)
            //
            //
            //            Text("Hello world worlllllllllld")
            //
            //            Text("Hello worlllllllllld").background(Color.yellow)
            //            Text("Hello World").background(Color.red)
            //
            //
            //        }.background(Color.green)
            Button(action: {
                print("Edit button was tapped")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
        }
        
        
        
    }
}

struct MainView: View {
    @State private var showingAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white).font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white).font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original).clipShape(Capsule())
                            .shadow(color: .black, radius: 2)
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))

                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            
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
        MainView()
    }
}
