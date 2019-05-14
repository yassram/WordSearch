//
//  Utils.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0 ... 255) / 255, green: CGFloat.random(in: 0 ... 255) / 255, blue: CGFloat.random(in: 0 ... 255) / 255, alpha: 1)
    }
}

extension UIFont {
    func sizeOfString(string: String, constrainedToHeight height: Double) -> CGSize {
        let attString = NSAttributedString(string: string, attributes: [.font: self])
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0, length: 0), nil, CGSize(width: .greatestFiniteMagnitude, height: height), nil)
    }
}
