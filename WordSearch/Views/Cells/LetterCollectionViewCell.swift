//
//  LetterCollectionViewCell.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
    let letterLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(letterLabel)
        letterLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        letterLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        letterLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        letterLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
}
