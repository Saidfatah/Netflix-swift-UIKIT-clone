//
//  ApiCaller.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation

struct Constants{
    static let API_KEY = "3335003b7f793023ad34efe7408e6771"
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_VERSION = 3
}

enum EpiError: Error {
    case failedToGetData
}
class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion : @escaping (Result<[Movie],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(jsonRes.results ))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }
}
