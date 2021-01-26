//
//  ContentView.swift
//  BetterRest
//
//  Created by Krystyna Waniova on 26/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime

    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    
    
    var body: some View {
        NavigationView{
            Form{
                
                Section(header: Text("When do you like to wake up? ").font(.headline)){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired amount of sleep").font(.headline)){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section(header:  Text("Daily cofee intake").font(.headline)){
                    Stepper(value: $coffeeAmount, in: 1...20){
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        }else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
//
//                VStack(alignment: .leading, spacing: 0){
//                    Text("When do you like to wake up? ").font(.headline)
//
//                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
//                }
//                VStack(alignment: .leading, spacing: 0){
//                    Text("Desired amount of sleep").font(.headline)
//                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
//                        Text("\(sleepAmount, specifier: "%g") hours")
//                    }
//
//                }
                
//                VStack(alignment: .leading, spacing: 0){
//                    Text("Daily cofee intake").font(.headline)
//
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        }else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
//                }
                
                
               
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }.navigationTitle("BetterRest")
        .navigationBarItems(trailing:
                                Button(action: calculateBedTime){
                                    Text("Calculate")
                                }
        )

       
    }
}
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime(){
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleeptime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleeptime)
            alertTitle = "Your ideal bedtime is…"
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there is some problem."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
