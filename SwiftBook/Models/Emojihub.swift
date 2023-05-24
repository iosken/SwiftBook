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
    
    var emojis: [String] {
        unicodeScalarFromUPlus(unicode: unicode)
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
    func unicodeScalarFromUPlus(unicode: [String]) -> [String] {
        var result: [String] = []
        
        for code in unicode {
            
            var unicodeScalar = "" {
                didSet {
                    unicodeScalar.removeFirst(2)
                }
            }
            
            unicodeScalar = code
            
            let codePoint = Int(unicodeScalar, radix: 16) ?? 0
            
            result.append(String(UnicodeScalar(codePoint) ?? UnicodeScalar(0)))
        }
        
        return result
    }
}


//SOURCE:
// https://emojihub.yurace.pro/api/random

//{"name":"man with chinese cap, type-3",
//    "category":"smileys and people",
//    "group":"person role",
//    "htmlCode":["\u0026#128114;","\u0026#127996;"],
//    "unicode":["U+1F472","U+1F3FC"]}
