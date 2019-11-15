//
//  XprofinatyInspector.swift
//  XProfinatyInspector
//
//  Created by Vinicius Mangueira on 15/11/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

class XProfinatyResource {
    static func fileURL() -> URL? {
        return Bundle(for: XProfinatyResource.self).url(forResource: "Profanity", withExtension: "json")
    }
}

struct XProfanityWords {
    
    static let profaneWords: Set<String> = {
        
        guard let fileURL = XProfinatyResource.fileURL() else {
            return Set<String>()
        }
        
        do {
            let fileData = try Data(contentsOf: fileURL, options: NSData.ReadingOptions.uncached)
            
            guard let words = try JSONSerialization.jsonObject(with: fileData, options: []) as? [String] else {
                return Set<String>()
            }
            
            return Set(words)
            
        } catch {
            return Set<String>()
        }
    }()
}

public struct ProfanityFilter {
    
    static func censorString(_ string: String) -> String {
        var cleanString = string
        
        for word in string.profaneWords() {
            
            let cleanWord = "".padding(toLength: word.count, withPad: "*", startingAt: 0)
            
            cleanString = cleanString.replacingOccurrences(of: word, with: cleanWord, options: [.caseInsensitive], range: nil)
        }
        
        return cleanString
    }
}

public extension String {
    
    func profaneWords() -> Set<String> {
        
        var delimiterSet = CharacterSet()
        delimiterSet.formUnion(CharacterSet.punctuationCharacters)
        delimiterSet.formUnion(CharacterSet.whitespacesAndNewlines)
        
        let words = Set(self.lowercased().components(separatedBy: delimiterSet))
        
        return words.intersection(XProfanityWords.profaneWords)
    }
    
    func containsProfanity() -> Bool {
        return !profaneWords().isEmpty
    }
    
    func censored() -> String {
        return ProfanityFilter.censorString(self)
    }
    
    mutating func censor() {
        self = censored()
    }
}

public extension NSString {
    
    func censored() -> NSString {
        return ProfanityFilter.censorString(self as String) as NSString
    }
}

public extension NSMutableString {
    
    func censor() {
        setString(ProfanityFilter.censorString(self as String))
    }
}

public extension NSAttributedString {
    
    func censored() -> NSAttributedString {
        
        let profaneWords = string.profaneWords()
        
        if profaneWords.isEmpty {
            return self
        }
        
        let cleanString = NSMutableAttributedString(attributedString: self)
        
        for word in profaneWords {
            
            let cleanWord = "".padding(toLength: word.count, withPad: "*", startingAt: 0)
            
            var range = (cleanString.string as NSString).range(of: word, options: .caseInsensitive)
            while range.location != NSNotFound {
                let attributes = cleanString.attributes(at: range.location, effectiveRange: nil)
                let cleanAttributedString = NSAttributedString(string: cleanWord, attributes: attributes)
                cleanString.replaceCharacters(in: range, with: cleanAttributedString)
                
                range = (cleanString.string as NSString).range(of: word, options: .caseInsensitive)
            }
        }
        
        return cleanString
    }
}

