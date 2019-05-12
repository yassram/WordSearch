//
//  GameVC+CollectionView.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return collumnNumber * lineNumber
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lettreCellIdentifier, for: indexPath) as! LetterCollectionViewCell

        cell.backgroundColor = .white
        if logicPositioning.isInRange(index: indexPath.item, start: startSelected, end: endSelected) {
            cell.backgroundColor = .orange
        }
        for word in logicPositioning.wordsFound {
            if logicPositioning.isInRange(index: indexPath.item, start: word.value.0, end: word.value.1) {
                cell.backgroundColor = wordColor[word.key]
            }
        }
        cell.letterLabel.text = logicPositioning.wordsGrid[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let w = collectionView.bounds.width / CGFloat(collumnNumber)
        let h = collectionView.bounds.height / CGFloat(lineNumber)
        return CGSize(width: w, height: h)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
