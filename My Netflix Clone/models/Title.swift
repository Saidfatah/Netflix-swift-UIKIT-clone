//
//  Title.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation


struct TitleResponse:Codable {
    let results : [Title]
}

struct Title:Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let overview: String?
    let backdrop_path: String?
    let popularity: Double?
    let poster_path: String?
    let name: String?
    let title: String?
    let vote_count: Int
    let vote_average:Double
}
