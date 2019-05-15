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

    let topView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()

    let topCenterView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.3, alpha: 1)
        return v
    }()

    let newGameButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "update")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()

    let infoButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "info")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        return btn
    }()

    let timerLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.clipsToBounds = true
        lab.textAlignment = .center
        lab.text = "00 : 00"
        lab.textColor = .white
        lab.backgroundColor = UIColor(white: 0.3, alpha: 1)
        return lab
    }()

    let scoreLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.clipsToBounds = true
        lab.textAlignment = .center
        lab.text = "- / -"
        lab.textColor = .white
        lab.backgroundColor = UIColor(white: 0.3, alpha: 1)
        return lab
    }()

    var timer = Timer()
    var sec = 0

    var boardCollectionViewConstraints = [NSLayoutConstraint]()
    var wordsCollectionViewConstraints = [NSLayoutConstraint]()
    var topViewCnstraints = [NSLayoutConstraint]()

    let lettreCellIdentifier = "lettreCellIdentifier"
    let wordCellIdentifier = "wordCellIdentifier"

    @objc func startGame() {
        WordsDataAccess.getWords(index: 0) { wordsList in
            self.logicPositioning = LogicPositioning(numLines: self.lineNumber, numCollumns: self.collumnNumber, wordsList: wordsList)
            self.wordsList = self.logicPositioning.wordsList
            self.wordsCollectionView.reloadData()
            self.boardCollectionView.reloadData()
            self.scoreLabel.text = "\(self.logicPositioning.wordsFound.count) / \(self.wordsList.count)"
            self.sec = 0
            self.updateTime()
            self.sec = 0
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        boardCollectionView.dataSource = self
        boardCollectionView.delegate = self
        boardCollectionView.register(LetterCollectionViewCell.self, forCellWithReuseIdentifier: lettreCellIdentifier)

        wordsCollectionView.delegate = self
        wordsCollectionView.dataSource = self
        wordsCollectionView.register(wordCollectionViewCell.self, forCellWithReuseIdentifier: wordCellIdentifier)

        startGame()
        setupViews()
    }

    func setupViews() {
        view.addSubview(boardCollectionView)
        boardCollectionView.backgroundColor = .white

        view.addSubview(wordsCollectionView)
        wordsCollectionView.backgroundColor = .white

        view.addSubview(topView)
        topView.addSubview(timerLabel)
        timerLabel.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        timerLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        timerLabel.layer.cornerRadius = 12

        topView.addSubview(scoreLabel)
        scoreLabel.rightAnchor.constraint(equalTo: topView.rightAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        scoreLabel.layer.cornerRadius = 12

        topView.addSubview(topCenterView)
        topCenterView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topCenterView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topCenterView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        topCenterView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        topCenterView.layer.cornerRadius = 12

        let separator = UIView()
        separator.backgroundColor = .white
        separator.translatesAutoresizingMaskIntoConstraints = false
        topCenterView.addSubview(separator)
        separator.centerXAnchor.constraint(equalTo: topCenterView.centerXAnchor, constant: 0).isActive = true
        separator.topAnchor.constraint(equalTo: topCenterView.topAnchor, constant: 4).isActive = true
        separator.bottomAnchor.constraint(equalTo: topCenterView.bottomAnchor, constant: -4).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 0.5).isActive = true

        topCenterView.addSubview(newGameButton)
        newGameButton.rightAnchor.constraint(equalTo: topCenterView.rightAnchor, constant: -2).isActive = true
        newGameButton.leftAnchor.constraint(equalTo: separator.rightAnchor, constant: 2).isActive = true
        newGameButton.topAnchor.constraint(equalTo: topCenterView.topAnchor).isActive = true
        newGameButton.bottomAnchor.constraint(equalTo: topCenterView.bottomAnchor).isActive = true
        newGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)

        topCenterView.addSubview(infoButton)
        infoButton.leftAnchor.constraint(equalTo: topCenterView.leftAnchor, constant: 2).isActive = true
        infoButton.rightAnchor.constraint(equalTo: separator.leftAnchor, constant: -2).isActive = true
        infoButton.topAnchor.constraint(equalTo: topCenterView.topAnchor).isActive = true
        infoButton.bottomAnchor.constraint(equalTo: topCenterView.bottomAnchor).isActive = true
        infoButton.addTarget(self, action: #selector(infoSelected), for: .touchUpInside)

        setupConstraints(UIApplication.shared.statusBarOrientation.isLandscape)
    }

    func setupConstraints(_ isLandscape: Bool) {
        NSLayoutConstraint.deactivate(boardCollectionViewConstraints)
        NSLayoutConstraint.deactivate(wordsCollectionViewConstraints)
        NSLayoutConstraint.deactivate(topViewCnstraints)
        view.layoutIfNeeded()
        view.layoutSubviews()
        if isLandscape {
            topViewCnstraints = [
                topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
                topView.leftAnchor.constraint(equalTo: boardCollectionView.rightAnchor, constant: 28),
                topView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -28),
                topView.heightAnchor.constraint(equalToConstant: 40),
            ]

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
                wordsCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 12),
                wordsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            ]
        } else {
            topViewCnstraints = [
                topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
                topView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
                topView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
                topView.heightAnchor.constraint(equalToConstant: 40),
            ]

            boardCollectionViewConstraints = [
                boardCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
                boardCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
                boardCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 12),
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
        NSLayoutConstraint.activate(topViewCnstraints)
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

    @objc func updateTime() {
        let m = sec / 60
        let s = sec % 60
        timerLabel.text = "\(m < 10 ? "0" : "")\(m) : \(s < 10 ? "0" : "")\(s)"
        sec += 1
    }

    @objc func infoSelected() {
        let v = CustomAlertView(parentView: view, vc: self)
        timer.invalidate()
        v.show(title: "Hi!", message: "Shopify mobile developer intern challenge app\n\nby Yassir RAMDANI\n\n(More info in the README)", actionName: "Cool!", action: #selector(resume))
    }

    @objc func resume() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
