//
//  GameVC.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    let collumnNumber = 10
    let lineNumber = 10
    var wordsList = [String]()
    var logicPositioning: LogicPositioning!

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 8
        return collectionView
    }()

    let lettreCellIdentifier = "lettreCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        WordsDataAccess.getWords(index: 0) { wordsList in
            self.wordsList = wordsList
            self.logicPositioning = LogicPositioning(numLines: self.lineNumber, numCollumns: self.collumnNumber, wordsList: self.wordsList)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: lettreCellIdentifier)
        setupViews()
    }

    func setupViews() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
