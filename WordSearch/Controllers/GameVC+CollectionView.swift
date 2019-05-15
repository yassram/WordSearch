//
//  GameVC+CollectionView.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if collectionView == boardCollectionView {
            return wordsList.count > 0 ? collumnNumber * lineNumber : 0
        } else if collectionView == wordsCollectionView {
            return wordsList.count
        }
        return 0
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == boardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lettreCellIdentifier, for: indexPath) as! LetterCollectionViewCell
            cell.backgroundColor = .clear
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

        if collectionView == wordsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: wordCellIdentifier, for: indexPath) as! wordCollectionViewCell
            cell.backgroundColor = .clear
            cell.wordLabel.text = wordsList[indexPath.item].uppercased()
            cell.wasFound = logicPositioning.wordsFound.keys.contains(wordsList[indexPath.item])
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == boardCollectionView {
            let w = floor(collectionView.bounds.width / CGFloat(collumnNumber))
            let h = floor(collectionView.bounds.height / CGFloat(lineNumber))
            return CGSize(width: w, height: h)
        }
        var size = UIFont.systemFont(ofSize: UIFont.systemFontSize).sizeOfString(string: wordsList[indexPath.item].uppercased(), constrainedToHeight: 30)
        size.width += 8
        size.height = 30
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        if collectionView == boardCollectionView {
            return 0
        }
        if collectionView == wordsCollectionView {
            return 4
        }
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
