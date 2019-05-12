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

    let collectionView: UICollectionView = {
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

    let lettreCellIdentifier = "lettreCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        collectionView.layoutIfNeeded()
        let spacingX = collectionView.bounds.width - floor(collectionView.bounds.width / CGFloat(collumnNumber)) * CGFloat(collumnNumber)
        let spacingY = collectionView.bounds.height - floor(collectionView.bounds.height / CGFloat(lineNumber)) * CGFloat(lineNumber)
        collectionView.contentInset = UIEdgeInsets(top: spacingY / 2, left: spacingX / 2, bottom: spacingY / 2, right: spacingX / 2)
        collectionView.reloadData()
        print(spacingX, spacingY)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let location = touches.first?.location(in: collectionView) else {
            return
        }
        if let indexPath = collectionView.indexPathForItem(at: location) {
            startSelected = indexPath.item
            endSelected = indexPath.item
            collectionView.reloadData()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let location = touches.first?.location(in: collectionView) else {
            return
        }
        if let indexPath = collectionView.indexPathForItem(at: location) {
            endSelected = indexPath.item
            if let word = logicPositioning.wordsListRanges.first(where: { (_, value) -> Bool in
                value.0 == startSelected && value.1 == endSelected
            }) {
                print("✅ word found :", word.key)
                logicPositioning.wordsFound[word.key] = word.value
                logicPositioning.wordsListRanges.removeValue(forKey: word.key)
                wordColor[word.key] = UIColor.random()
                if logicPositioning.wordsListRanges.count == 0 {
                    print("Well done !")
                }
            }
            collectionView.reloadData()
        }
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        startSelected = -1
        endSelected = -1
        collectionView.reloadData()
    }
}
