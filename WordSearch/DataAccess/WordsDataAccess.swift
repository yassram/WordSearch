//
//  WordsDataAccess.swift
//  WordSearch
//
//  Created by Yassir RAMDANI on 5/12/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import Foundation

class WordsDataAccess {
    static func getWords(index _: Int, completion: @escaping ([String]) -> Void) {
        if 1 == 1 {
            completion(["hello", "my", "name", "is", "yassir", "Swift", "Kotlin", "ObjectiveC", "Variable", "Java", "Mobile"])
        }
    }
}
