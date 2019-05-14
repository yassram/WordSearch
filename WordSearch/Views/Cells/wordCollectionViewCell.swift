//
//  wordCollectionViewCell.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/13/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class wordCollectionViewCell: UICollectionViewCell {
    var wasFound = false {
        didSet {
            if wasFound {
                wordLabel.textColor = .lightGray
                line.isHidden = false
            } else {
                wordLabel.textColor = .black
                line.isHidden = true
            }
        }
    }

    let line: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let wordLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
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
        addSubview(wordLabel)
        wordLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        wordLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true

        addSubview(line)
        line.heightAnchor.constraint(equalToConstant: 1.4).isActive = true
        line.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        line.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
