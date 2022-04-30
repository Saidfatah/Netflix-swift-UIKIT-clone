//
//  YoutubeResponse.swift
//  My Netflix Clone
//
//  Created by said fatah on 30/4/2022.
//

import Foundation

//{
//etag = bgLZ5r6ekosmQlj9vFJFBDmdS1g;
//id =             {
//kind = "youtube#video";
//videoId = r69FqXQUQW4;
//};
//kind = "youtube#searchResult";
//}


struct VideoElementId:Codable {
    let kind : String
    let videoId : String
}
struct VideoElement:Codable {
    let id : VideoElementId
}

struct YoutubeSearchResponse:Codable {
    let items :[VideoElement]
}
