//
//  Movie.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation

struct TrendingMoviesResponse:Codable {
    let results : [Movie]
    let page : Int
    let total_pages : Int
    let total_results : Int
}

struct Movie:Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let overview: String?
    let backdrop_path: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let vote_count: Int
    let vote_average:Double
}
 
