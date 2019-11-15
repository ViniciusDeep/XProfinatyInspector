//
//  XprofinatyInspector.swift
//  XProfinatyInspector
//
//  Created by Vinicius Mangueira on 15/11/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

class XProfinatyR {
    
    static func profanityFileURL() -> URL? {
        return Bundle(for: XProfinatyR.self).url(forResource: "profanity", withExtension: "json")
    }
}

struct XProfinatyWords {
        static let profaneWords: [String] = {
        
        guard let fileURL = XProfinatyR.profanityFileURL() else {return []}
    
        do {
            let fileData = try Data(contentsOf: fileURL, options: NSData.ReadingOptions.uncached)
            
            guard let words = try JSONSerialization.jsonObject(with: fileData, options: []) as? [String] else {
                return []
            }
            return words
        } catch {return []}
    }()
}

public extension String {
    func containsProfanity() -> Bool {
        var hasBadWords = false
        
         var charactherSet = CharacterSet()
         charactherSet.formUnion(CharacterSet.punctuationCharacters)
         charactherSet.formUnion(CharacterSet.whitespacesAndNewlines)
         
         let words = Set(self.lowercased().components(separatedBy: charactherSet))
        
        XProfinatyWords.profaneWords.forEach { (badWord) in
            if words.contains(badWord) {hasBadWords = true}
        }
        
        return hasBadWords
    }
}

