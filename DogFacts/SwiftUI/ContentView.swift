//
//  ContentView.swift
//  Shared
//
//  Created by Patrick McGonigle on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DogFactsViewModel(service: DogFactsServiceFetched())
    
    private let textColor = GlobalStyling.textColor
    
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            Button {
                Task {
                    await self.viewModel.fetch()
                }
            } label: {
                FetchButtonLabel()
            }
            switch self.viewModel.state {
            case .loaded(let dogFact):
                DogFactView(text: dogFact)
            case .failed(let error):
                DogFactView(text: error.localizedDescription, color: Color.red)
            case .loading, .idle:
                ProgressView()
                    .padding([.top, .leading, .trailing])
                    .frame(height: 200.0, alignment: Alignment.top)
            }
            Spacer()
            FooterView()
        }
        .onAppear {
            Task {
                await self.viewModel.fetch()
            }
        }
    }
    
    struct DogFactView: View {
        
        let text: String
        let color: Color
        
        init(text: String? = nil, color: Color? = nil) {
            self.text = text ?? ""
            self.color = color ?? GlobalStyling.textColor
        }

        var body: some View {
            Text(self.text)
                .font(.callout)
                .foregroundColor(self.color)
                .bold()
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
                .frame(height: 200.0, alignment: Alignment.top)
        }
    }

    struct FetchButtonLabel: View {
        var body: some View {
            Text("Fetch 🐶")
                .fontWeight(.heavy)
                .padding()
                .foregroundColor(GlobalStyling.textColor)
                .border(GlobalStyling.textColor)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(GlobalStyling.textColor, lineWidth: 3)
                )
        }
    }

    struct HeaderView: View {
        var body: some View {
            Text("Dog Facts®")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(GlobalStyling.textColor)
                .padding(.top, 16.0)
        }
    }

    struct FooterView: View {
        var body: some View {
            Text("Brought to you by Dog Facts®")
                .font(.footnote)
                .foregroundColor(GlobalStyling.textColor)
                .padding(.bottom, 16.0)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
