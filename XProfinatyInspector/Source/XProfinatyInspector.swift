//
//  XprofinatyInspector.swift
//  XProfinatyInspector
//
//  Created by Vinicius Mangueira on 15/11/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

class ProfanityResources {
    
    class func profanityFileURL() -> URL? {
        return Bundle(for: ProfanityResources.self).url(forResource: "profanity", withExtension: "json")
    }
}

struct ProfanityDictionary {
    
    static let profaneWords: [String] = {
        
        guard let fileURL = ProfanityResources.profanityFileURL() else {
            return []
        }
    
        do {
            let fileData = try Data(contentsOf: fileURL, options: NSData.ReadingOptions.uncached)
            
            guard let words = try JSONSerialization.jsonObject(with: fileData, options: []) as? [String] else {
                return []
            }
            
            return words
            
        } catch {
            return []
        }
    }()
}

public extension String {
    
 
    func containsProfanity() -> Bool {
        
        var hasBadWords = false
        
        var delimiterSet = CharacterSet()
         delimiterSet.formUnion(CharacterSet.punctuationCharacters)
         delimiterSet.formUnion(CharacterSet.whitespacesAndNewlines)
         
         let words = Set(self.lowercased().components(separatedBy: delimiterSet))
        
        ProfanityDictionary.profaneWords.forEach { (badWord) in
            if words.contains(badWord) {
                hasBadWords = true
            } else {
                hasBadWords = false
            }
        }
        
        return hasBadWords
    }
}

