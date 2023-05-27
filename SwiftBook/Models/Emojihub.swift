//
//  Emojihub.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Emojihub: Decodable {
    
    let name: String
    let category: String
    let group: String
    let htmlCode: [String]
    let unicode: [String]
    
}

extension Emojihub {
    
    var description: String {
        """
    Current emoji name is \(name)

    from category \(category)

    of group \(group)

    HTML code is \(allHtmlCode)
"""
    }
    
    var emojis: String {
        let emojisParts = scalarFromUnicode(unicode: unicode)
        
        var emojis = ""
        for emoji in emojisParts {
            emojis.append(" " + emoji)
        }
        
        return emojis
    }
    
    
    var allHtmlCode: String {
        var result = ""
        
        htmlCode.forEach { htmlCode in
            result += " " + htmlCode
        }
        
        return result
    }
    
    var allUnicode: String {
        var result = ""
        
        unicode.forEach { unicode in
            result += " " + unicode
        }
        
        return result
    }
    
}

extension Emojihub {
    
    func scalarFromUnicode(unicode: [String]) -> [String] {
        var result: [String] = []
        
        for code in unicode {
            var scalar = ""
            scalar = code
            scalar.removeFirst(2)
            
            let codePoint = Int(scalar, radix: 16) ?? 0
            
            result.append(String(UnicodeScalar(codePoint) ?? UnicodeScalar(0)))
        }
        
        return result
    }
    
}
