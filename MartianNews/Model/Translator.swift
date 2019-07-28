//
//  Translator.swift
//  MartianNews
//
//  Created by Bryan Gula on 10/25/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import Foundation

struct Translator {
    
    //  Converts words of greater than 3 characers into 'boinga'
    //  takes in the string to convert and returns conversion string
    //  keeps punctuation and capitalization
    //
    static func toMartian(from stringArray: String) -> String {
        
        var newString: [String]
        
        newString = stringArray.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        let convertedString = newString.map { stringVal -> String in
            
            //  removing any punctuation to check first alphanumeric character
            //  and if the string is greater than 3 characters
            //
            if let firstCharacter = stringVal.components(separatedBy: .punctuationCharacters).reduce("", +).first,
                stringVal.count > 3
            {
                return stringVal.replacingOccurrences( of:"\\w*[A-Za-z0-9.]\\w*", with: firstCharacter.isUppercase ? "Boinga" : "boinga", options: .regularExpression)
            }
            
            return stringVal
        }
        
        return convertedString.joined(separator: " ")
    }
}
