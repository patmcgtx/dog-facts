//
//  ViewController.swift
//  DogFacts
//
//  Created by Patrick McGonigle on 5/5/22.
//

import Cocoa
import Combine

/// Storyboard-based view for the dog facts
class ViewController: NSViewController {

    private let viewModel = DogFactsViewModel(service: DogFactsServiceFetched())
    
    @IBOutlet weak var dogFactLabel: NSTextFieldCell!
    @IBOutlet weak var fetchButton: NSButton!
    @IBOutlet weak var spinner: NSProgressIndicator!

    private var subscription: AnyCancellable?
    
    @IBAction func fetchButtonPressed(_ sender: Any) {        
        Task {
            // Trigger a reload on the view model
            await self.viewModel.fetch()
         }
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // React and update when the view model's state changes
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
            self.dogFactLabel.stringValue = "Loading..."
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
