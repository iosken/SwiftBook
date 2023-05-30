//
//  Emojihub.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Emoji: Decodable {
    
    let name: String
    let category: String
    let group: String
    let htmlCode: [String]
    let unicodes: [String]
    
}

extension Emoji: Parsing {
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        category = data["category"] as? String ?? ""
        group = data["group"] as? String ?? ""
        htmlCode = data["htmlCode"] as? [String] ?? [""]
        unicodes = data["unicode"] as? [String] ?? [""]
    }
    
    static func getData(from value: Any) -> Emoji {
        guard let emojiData = value as? [String: Any] else { return Emoji(data: [:]) }
        
        return Emoji(data: emojiData)
    }
    
}

extension Emoji {
    
    var description: String {
        """
    Current emoji name is \(name)

    from category \(category)

    of group \(group)

    HTML code is \(allHtmlCode)
"""
    }
    
    var emojis: String {
        let emojisParts = scalarsFromUnicodes(unicodes: unicodes)
        
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
        
        unicodes.forEach { unicode in
            result += " " + unicode
        }
        
        return result
    }
    
}

extension Emoji {
    
    func scalarsFromUnicodes(unicodes: [String]) -> [String] {
        var result: [String] = []
        
        for code in unicodes {
            var scalar = ""
            scalar = code
            scalar.removeFirst(2)
            
            let codePoint = Int(scalar, radix: 16) ?? 0
            
            result.append(String(UnicodeScalar(codePoint) ?? UnicodeScalar(0)))
        }
        
        return result
    }
    
}
