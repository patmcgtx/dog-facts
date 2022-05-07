//
//  ViewController.swift
//  DogFacts
//
//  Created by Patrick McGonigle on 5/5/22.
//

import Cocoa

class ViewController: NSViewController {

    private let service = DogFactsService(dataFetcher: DogFactsLiveDataFetcher())
    
    @IBOutlet weak var dogFactLabel: NSTextFieldCell!
    @IBOutlet weak var fetchButton: NSButton!
    @IBOutlet weak var spinner: NSProgressIndicator!    
    @IBAction func fetchButtonPressed(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.fetchButton.isEnabled = false
            self.spinner.isHidden = false
            self.spinner.startAnimation(self)
        }
        
        Task {
            do {
                self.update(dogFact: try await self.service.dogFact)
            } catch {
                self.update(dogFact: error.localizedDescription)
            }
         }
    }
    
    private func update(dogFact: String) {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimation(self)
            self.fetchButton.isEnabled = true
            self.dogFactLabel.stringValue = dogFact
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dogFactLabel.stringValue = "In 1957, Laika became the first living being in space via an earth satellite and JFK’s terrier, Charlie, fathered 4 puppies with Laika’s daughter."
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
