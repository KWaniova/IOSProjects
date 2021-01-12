//
//  ContentView.swift
//  iExpense
//
//  Created by Krystyna Waniova on 12/01/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable,Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
    
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:Button(action: {
                self.showingAddExpense = true
            }) {
                Image(systemName: "plus")
            }
            )
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}



struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

        var name: String

           var body: some View {
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }           }    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






//
//struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    var body: some View {
//        NavigationView{
//        VStack {
//            List {
//                ForEach(numbers, id: \.self) {
//                    Text("\($0)")
//                }
//                .onDelete(perform: removeRows)
//            }
//
//            Button("Add Number") {
//                self.numbers.append(self.currentNumber)
//                self.currentNumber += 1
//            }
//        }.navigationBarItems(leading: EditButton())
//        }
//
//    }
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//}

//class User: ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//struct ContentView: View {
//    @ObservedObject var user = User()
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//    }
//}
