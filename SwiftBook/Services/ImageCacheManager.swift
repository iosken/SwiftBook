//
//  ImageCacheManager.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 31.05.2023.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
