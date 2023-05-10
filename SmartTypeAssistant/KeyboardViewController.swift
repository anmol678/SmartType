//
//  KeyboardViewController.swift
//  SmartTypeAssistant
//
//  Created by Anmol Jain on 5/9/23.
//

import UIKit

class KeyboardViewController: UIInputViewController {
        
    private var collectionView: UICollectionView!
    private var phrases: [Phrase] = []
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch Phrases
        fetchPhrases()

        // Set up UICollectionView
        setupCollectionView()
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
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhraseCell")
        
        view.addSubview(collectionView)
        
        // Set up constraints for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    private func fetchPhrases() {
        let dataManager = DataManager(persistenceController: PersistenceController.shared)
        phrases = dataManager.getAllPhrases()
    }

}

extension KeyboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        textDocumentProxy.insertText(phrases[indexPath.item].content)
    }
}

extension KeyboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phrases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCell", for: indexPath)
        cell.contentView.backgroundColor = .systemGray
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.clipsToBounds = true
        
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = phrases[indexPath.item].content
        label.textAlignment = .center
        label.textColor = .white
        
        cell.contentView.addSubview(label)
        
        return cell
    }
}

extension KeyboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 40) / 3, height: 40)
    }
}
