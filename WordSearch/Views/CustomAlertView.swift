//
//  CustomAlertView.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/15/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {
    let parentView: UIView
    let vc: GameVC
    var action: Selector?

    func createWinParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: parentView.center.x, y: -50)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: parentView.frame.size.width, height: 1)

        let redT = makeEmitterCell(color: UIColor(red: 1.00, green: 0.10, blue: 0.37, alpha: 1.00), image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
        let greenT = makeEmitterCell(color: UIColor(red: 0.29, green: 0.95, blue: 0.63, alpha: 1.00), image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
        let blueT = makeEmitterCell(color: UIColor(red: 0.00, green: 0.54, blue: 1.00, alpha: 1.00), image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))

        let redP = makeEmitterCell(color: UIColor(red: 1.00, green: 0.10, blue: 0.37, alpha: 1.00), image: UIImage(named: "polygon")?.withRenderingMode(.alwaysTemplate))
        let greenP = makeEmitterCell(color: UIColor(red: 0.29, green: 0.95, blue: 0.63, alpha: 1.00), image: UIImage(named: "polygon")?.withRenderingMode(.alwaysTemplate))
        let blueP = makeEmitterCell(color: UIColor(red: 0.00, green: 0.54, blue: 1.00, alpha: 1.00), image: UIImage(named: "polygon")?.withRenderingMode(.alwaysTemplate))

        let redS = makeEmitterCell(color: UIColor(red: 1.00, green: 0.10, blue: 0.37, alpha: 1.00), image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate))
        let greenS = makeEmitterCell(color: UIColor(red: 0.29, green: 0.95, blue: 0.63, alpha: 1.00), image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate))
        let blueS = makeEmitterCell(color: UIColor(red: 0.00, green: 0.54, blue: 1.00, alpha: 1.00), image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate))

        particleEmitter.emitterCells = [redS, greenS, blueS, redT, greenT, blueT, redP, greenP, blueP]
        layer.insertSublayer(particleEmitter, below: messageView.layer)
    }

    func makeEmitterCell(color: UIColor, image: UIImage?) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.7
        cell.scaleSpeed = -0.05
        cell.contents = image?.cgImage
        cell.color = color.cgColor
        return cell
    }

    init(parentView: UIView, vc: GameVC) {
        self.parentView = parentView
        self.vc = vc
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white: 0.1, alpha: 0.8)
    }

    let messageView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 18
        return v
    }()

    let titleLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 72)
        lab.text = ""
        return lab
    }()

    let messageLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 20)
        lab.text = ""
        lab.numberOfLines = -1
        return lab
    }()

    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 22
        btn.backgroundColor = UIColor(red: 1.00, green: 0.21, blue: 0.41, alpha: 1.00)
        btn.setTitle("", for: .normal)
        return btn
    }()

    func showSucess(action: Selector? = nil) {
        if let action = action {
            self.action = action
        }
        show(title: "🎉", message: "Well done!", actionName: "Play again!", action: nil)
        createWinParticles()
    }

    func show(title: String, message: String, actionName: String, action: Selector?) {
        if let action = action {
            self.action = action
        }
        let window = UIApplication.shared.keyWindow!
        window.addSubview(self)
        topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true

        titleLabel.text = title
        messageLabel.text = message
        button.setTitle(actionName, for: .normal)
        button.addTarget(self, action: #selector(hide), for: .touchUpInside)

        addSubview(messageView)
        messageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        messageView.widthAnchor.constraint(equalToConstant: 260).isActive = true

        messageView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 18).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: messageView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true

        messageView.addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: messageView.widthAnchor).isActive = true
        messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 52).isActive = true

        messageView.addSubview(button)
        button.centerXAnchor.constraint(equalTo: messageView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 22).isActive = true
        button.widthAnchor.constraint(equalTo: messageView.widthAnchor, constant: -18).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -12).isActive = true

        messageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.3, animations: {
            self.messageView.transform = CGAffineTransform(scaleX: 1, y: 1)

        })

        layoutIfNeeded()
    }

    @objc func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.messageView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height / 2)
        }) { _ in
            self.vc.perform(self.action)
            self.removeFromSuperview()
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        hide()
    }
}
