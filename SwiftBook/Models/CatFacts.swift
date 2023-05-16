//
//  CatFacts.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 15.05.2023.
//

import Foundation

struct CatFacts: Decodable {
    let name: String
    let description: String
    let main: String
    let authors: [String]
    let license: String
    let directory: String
    let ignore: [String]
    let dependencies: Dependencies
}

struct Dependencies: Decodable {
    let angular_timer: String?
    let ngclipboard: String
}


//SOURCE:
//https://github.com/alexwohlbruck/cat-facts/blob/master/bower.json
//{
//  "name": "cat-facts",
//  "description": "A chat example to showcase how to use `socket.io` with a static `express` server with `async` for control flow.",
//  "main": "server.js",
//  "authors": [
//    "Mostafa Eweda <mo.eweda@gmail.com>"
//  ],
//  "license": "MIT",
//  "homepage": "",
//  "directory": "public/components/",
//  "ignore": [
//    "**/.*",
//    "node_modules",
//    "bower_components",
//    "test",
//    "tests"
//  ],
//  "dependencies": {
//    "angular-timer": "^1.3.4",
//    "ngclipboard": "^1.1.1"
//  }
//}
