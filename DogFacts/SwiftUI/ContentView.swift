//
//  ContentView.swift
//  Shared
//
//  Created by Patrick McGonigle on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = DogFactsViewModel(service: DogFactsServiceFetched())
    
    var body: some View {
        VStack {
            Text("Dog Facts®")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.brown)
                .padding(.top, 16.0)
            Spacer()
            Button {
                Task {
                    await self.viewModel.fetch()
                }
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
            switch self.viewModel.state {
            case .loaded(let dogFact):
                Text(dogFact)
                    .font(.callout)
                    .foregroundColor(Color.brown)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    .frame(height: 200.0, alignment: Alignment.top)
            case .failed(let error):
                Text(error.localizedDescription)
                    .font(.callout)
                    .foregroundColor(Color.red)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    .frame(height: 200.0, alignment: Alignment.top)
            case .loading, .idle:
                Text("")
                    .frame(height: 200.0, alignment: Alignment.top)
            }
            Spacer()
            Text("Brought to you by Dog Facts®")
                .font(.footnote)
                .foregroundColor(.brown)
                .padding(.bottom, 16.0)
        }
        .onAppear {
            Task {
                await self.viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
