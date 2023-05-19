//
//  Emojihub.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 19.05.2023.
//

import Foundation

struct Emojihub: Decodable {
    let name: String?
    let category: String?
    let group: String?
    let htmlCode: [String?]
    let unicode: [String?]
}

//SOURCE:
// https://emojihub.yurace.pro/api/random

//{"name":"man with chinese cap, type-3",
//    "category":"smileys and people",
//    "group":"person role",
//    "htmlCode":["\u0026#128114;","\u0026#127996;"],
//    "unicode":["U+1F472","U+1F3FC"]}
