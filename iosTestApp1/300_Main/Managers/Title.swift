//
//  Movie.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/07.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results:[Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let vote_count: Int
    let vote_average: Double
    let release_date: String?
}
