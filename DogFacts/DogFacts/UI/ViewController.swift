//
//  ViewController.swift
//  DogFacts
//
//  Created by Patrick McGonigle on 5/5/22.
//

import Cocoa
import Combine

class ViewController: NSViewController {

    private let viewModel = DogFactsViewModel(service: LiveDogFactsService(dataFetcher: DogFactsLiveDataFetcher()))
    
    @IBOutlet weak var dogFactLabel: NSTextFieldCell!
    @IBOutlet weak var fetchButton: NSButton!
    @IBOutlet weak var spinner: NSProgressIndicator!

    private var subscription: AnyCancellable?
    
    @IBAction func fetchButtonPressed(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.fetchButton.isEnabled = false
            self.spinner.isHidden = false
            self.spinner.startAnimation(self)
        }
        
        Task {
            await self.viewModel.fetch()
            self.updateUI()
         }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription = self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                self.updateUI()
            }
    }

    private func updateUI() {
        switch self.viewModel.state {
        case .loading:
            self.spinner.isHidden = false
            self.spinner.startAnimation(self)
            self.fetchButton.isEnabled = false
            self.dogFactLabel.stringValue = "Loading"
        case .loaded(let dogFact):
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
            self.fetchButton.isEnabled = true
            self.dogFactLabel.stringValue = dogFact
        case .failed(let error):
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
            self.fetchButton.isEnabled = true
            self.dogFactLabel.stringValue = error.localizedDescription
        case .idle:
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
            self.fetchButton.isEnabled = true
        }
    }
    
}
