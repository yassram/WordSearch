//
//  GameVC.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    let collumnNumber = 12
    let lineNumber = 12
    var wordsList = [String]()
    var logicPositioning: LogicPositioning!
    var startSelected: Int = -1
    var endSelected: Int = -1
    var wordColor = [String: UIColor]()
    let selection = UISelectionFeedbackGenerator()

    let boardCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = false

        collectionView.layer.cornerRadius = 8
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView.layer.shadowRadius = 4.0
        collectionView.layer.shadowOpacity = 0.4
        collectionView.layer.masksToBounds = false
        return collectionView
    }()

    let wordsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()

    var boardCollectionViewConstraints = [NSLayoutConstraint]()
    var wordsCollectionViewConstraints = [NSLayoutConstraint]()

    let lettreCellIdentifier = "lettreCellIdentifier"
    let wordCellIdentifier = "wordCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        WordsDataAccess.getWords(index: 0) { wordsList in
            self.wordsList = wordsList
            self.logicPositioning = LogicPositioning(numLines: self.lineNumber, numCollumns: self.collumnNumber, wordsList: self.wordsList)
        }
        boardCollectionView.dataSource = self
        boardCollectionView.delegate = self
        boardCollectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: lettreCellIdentifier)

        wordsCollectionView.delegate = self
        wordsCollectionView.dataSource = self
        wordsCollectionView.register(wordCollectionViewCell.self, forCellWithReuseIdentifier: wordCellIdentifier)
        setupViews()
    }

    func setupViews() {
        view.addSubview(boardCollectionView)
        boardCollectionView.backgroundColor = .white

        view.addSubview(wordsCollectionView)
        wordsCollectionView.backgroundColor = .white

        setupConstraints(UIApplication.shared.statusBarOrientation.isLandscape)
    }

    func setupConstraints(_ isLandscape: Bool) {
        NSLayoutConstraint.deactivate(boardCollectionViewConstraints)
        NSLayoutConstraint.deactivate(wordsCollectionViewConstraints)
        view.layoutIfNeeded()
        view.layoutSubviews()
        if isLandscape {
            boardCollectionViewConstraints = [
                boardCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
                boardCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
                boardCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
                boardCollectionView.heightAnchor.constraint(equalTo: boardCollectionView.widthAnchor),
            ]
            boardCollectionViewConstraints.forEach { const in
                const.priority = UILayoutPriority(rawValue: 10)
            }
            boardCollectionViewConstraints.last?.priority = UILayoutPriority(rawValue: 2)

            wordsCollectionViewConstraints = [
                wordsCollectionView.leftAnchor.constraint(equalTo: boardCollectionView.rightAnchor, constant: 28),
                wordsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -28),
                wordsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
                wordsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            ]
        } else {
            boardCollectionViewConstraints = [
                boardCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
                boardCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
                boardCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                boardCollectionView.heightAnchor.constraint(equalTo: boardCollectionView.widthAnchor),
            ]
            wordsCollectionViewConstraints = [
                wordsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 28),
                wordsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -28),
                wordsCollectionView.topAnchor.constraint(equalTo: boardCollectionView.bottomAnchor, constant: 12),
                wordsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            ]
            wordsCollectionViewConstraints.forEach { const in
                const.priority = UILayoutPriority(rawValue: 10)
            }
            wordsCollectionViewConstraints.last?.priority = UILayoutPriority(rawValue: 2)
        }

        NSLayoutConstraint.activate(boardCollectionViewConstraints)
        NSLayoutConstraint.activate(wordsCollectionViewConstraints)
        view.layoutIfNeeded()
        view.layoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let spacingX = boardCollectionView.bounds.width - floor(boardCollectionView.bounds.width / CGFloat(collumnNumber)) * CGFloat(collumnNumber)
        let spacingY = boardCollectionView.bounds.height - floor(boardCollectionView.bounds.height / CGFloat(lineNumber)) * CGFloat(lineNumber)
        boardCollectionView.contentInset = UIEdgeInsets(top: spacingY / 2, left: spacingX / 2, bottom: spacingY / 2, right: spacingX / 2)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupConstraints(UIDevice.current.orientation.isLandscape)
    }
}
