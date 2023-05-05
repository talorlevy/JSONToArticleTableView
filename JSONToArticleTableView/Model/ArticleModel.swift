//
//  ArticleModel.swift
//  Lokesh - Task 5
//
//  Created by Talor Levy on 2/12/23.
//

import Foundation

struct ArticleModel: Codable {
    var source: SourceModel?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
