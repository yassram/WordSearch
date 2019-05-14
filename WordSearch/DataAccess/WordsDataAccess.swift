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
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let words = try decoder.decode([String].self, from: data)
                completion(words)
            } catch {
                print("Error reading Json input data")
            }
        }
    }
}
