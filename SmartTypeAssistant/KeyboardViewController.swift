//
//  KeyboardViewController.swift
//  SmartTypeAssistant
//
//  Created by Anmol Jain on 5/9/23.
//

import UIKit
import SwiftUI

struct PhraseView: View {
    var phrases: [Phrase]
    var onTap: (Phrase) -> Void
    
    var body: some View {
        FlexibleTagView(data: phrases, onTap: onTap)
    }
}

class KeyboardViewController: UIInputViewController {
        
    private var phrases: [Phrase] = []
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhrases()
        setupPhraseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let heightContraint = NSLayoutConstraint(
            item: view!,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 216.0)
        view.addConstraint(heightContraint)
    }
    
    private func fetchPhrases() {
        let dataManager = DataManager(persistenceController: PersistenceController.shared)
        phrases = dataManager.getAllPhrases()
    }
    
    private func setupPhraseView() {
        let phraseView = PhraseView(phrases: phrases, onTap: { phrase in
            self.textDocumentProxy.insertText(phrase.content)
        })
        
        let controller = UIHostingController(rootView: phraseView)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        controller.view.backgroundColor = .clear
        
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        controller.didMove(toParent: self)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

}
