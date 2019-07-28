//
//  ArticleModels.swift
//  MartianNews
//
//  Created by Bryan Gula on 10/22/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import Foundation

struct Article: Codable {
    var body: String
    var images: [Image]
    var title: String
}

struct Image: Codable {
    
    var height: Int
    var topImage: Bool
    var url: String
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case height, url, width
        case topImage = "top_image"
    }
}
