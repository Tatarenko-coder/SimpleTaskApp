//
//  APIModel.swift
//  SimpleTaskApp
//
//  Created by TD on 04.03.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let source: NewsSource?
    let author: String?
    let title: String
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date?
    let content: String?
}

struct NewsSource: Decodable {
    let id: String?
    let name: String
}

extension Article {
    static let new =
    Article(source: NewsSource(id: nil, name: "Biztoc.com"), author: "latimes.com", title: "San Francisco Isn't Coming Back, Simply Because It Never Left", description: "Elon Musk chose to locate Tesla’s “global engineering headquarters” in Hewlett Packard’s former headquarters — not in Austin but in Palo Alto. He announced his decision in 2023 at a joint event with Gov. Gavin Newsom. Michael Suswal’s first eye-opening encoun…", url: URL(string: "https://biztoc.com/x/ea1379d832596192")!, urlToImage: URL(string: "https://c.biztoc.com/p/ea1379d832596192/og.webp")!, publishedAt: Date(), content: "Elon Musk chose to locate Teslas global engineering headquarters in Hewlett Packards former headquarters not in Austin but in Palo Alto. He announced his decision in 2023 at a joint event with Gov. G… [+286 chars]")
    
}
