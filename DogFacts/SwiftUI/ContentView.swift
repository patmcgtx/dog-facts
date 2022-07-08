//
//  ContentView.swift
//  Shared
//
//  Created by Patrick McGonigle on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    
//    @EnvironmentObject var dogFactsService: DogFactsServiceLive
    
    var body: some View {
        VStack {
            VStack {
                Text("Dog Facts®")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.brown)
                    .padding(.top, 16.0)
                Spacer()
                Button {
//                    Task {
//                        try await self.dogFactsService.fetch()
//                    }
                } label: {
                    Text("Fetch 🐶")
                        .fontWeight(.heavy)
                        .padding()
                        .foregroundColor(.brown)
                        .border(.brown)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.brown, lineWidth: 3)
                        )
                }
//                Text(self.dogFactsService.dogFact)
                Text("Dog fact")
                    .font(.callout)
                    .foregroundColor(Color.brown)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                Spacer()
                Text("Brought to you by Dog Facts®")
                    .font(.footnote)
                    .foregroundColor(.brown)
                    .padding(.bottom, 16.0)
            }
        }
//        .onAppear {
//            Task {
//                try await self.dogFactsService.fetch()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
