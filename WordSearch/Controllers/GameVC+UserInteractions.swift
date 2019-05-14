//
//  GameVC+UserInteractions.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/14/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

extension GameVC {
    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let location = touches.first?.location(in: boardCollectionView) else {
            return
        }
        if let indexPath = boardCollectionView.indexPathForItem(at: location) {
            startSelected = indexPath.item
            endSelected = indexPath.item
            boardCollectionView.reloadData()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let location = touches.first?.location(in: boardCollectionView) else {
            return
        }
        if let indexPath = boardCollectionView.indexPathForItem(at: location) {
            endSelected = indexPath.item
            if let word = logicPositioning.wordsListRanges.first(where: { (_, value) -> Bool in
                value.0 == startSelected && value.1 == endSelected
            }) {
                print("✅ word found :", word.key)
                logicPositioning.wordsFound[word.key] = word.value
                logicPositioning.wordsListRanges.removeValue(forKey: word.key)
                selection.selectionChanged()
                wordsCollectionView.reloadData()
                wordColor[word.key] = UIColor.random()
                if logicPositioning.wordsListRanges.count == 0 {
                    print("Well done !")
                }
            }
            boardCollectionView.reloadData()
        }
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        startSelected = -1
        endSelected = -1
        boardCollectionView.reloadData()
    }
}
