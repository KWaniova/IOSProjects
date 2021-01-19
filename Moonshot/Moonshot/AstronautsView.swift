//
//  AstronautsView.swift
//  Moonshot
//
//  Created by Krystyna Waniova on 19/01/2021.
//
import SwiftUI
import Foundation

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    
                    Text(self.astronaut.name)
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .padding()
                    
                    Text(self.astronaut.description)
                        .foregroundColor(.white)
                        .padding()
                }.background(Image("XXX")
                             .resizable().frame(width: 7000, height: 7000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
