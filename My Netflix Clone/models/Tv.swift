//
//  Tv.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation


struct TrendingTvResponse:Codable {
    let results : [Tv]
    let page : Int
    let total_pages : Int
    let total_results : Int
}

struct Tv:Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let overview: String?
    let backdrop_path: String?
    let popularity: Double?
    let poster_path: String?
    let first_air_date: String?
    let name: String?
    let vote_count: Int
    let vote_average:Double
}
