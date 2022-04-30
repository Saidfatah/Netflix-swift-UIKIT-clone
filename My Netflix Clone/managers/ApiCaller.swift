//
//  ApiCaller.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation

struct Constants{
    static let API_KEY = "3335003b7f793023ad34efe7408e6771"
    static let YOUTUBE_API_KEY = "AIzaSyCiTl6WVG8s172Aq3M0Cp_FtAqFJM8oLU8"
    static let BASE_YOUTUBE_URL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let API_VERSION = 3
}

enum APIError: Error {
    case failedToGetData
}
class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results ))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }
    func getTrendingTv(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }

    func getUpcomingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(APIError.failedToGetData) )
            }
            
        }
        task.resume()
    }
    func getPopularMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(APIError.failedToGetData) )
            }
            
        }
        task.resume()
    }

    func getTopRatedMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(APIError.failedToGetData) )
            }
            
        }
        task.resume()
    }
    
    func getSearchedMovies(searchFor query:String ,completion : @escaping (Result<[Title],Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let urlString = "\(Constants.BASE_URL)/search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)&page=1&include_adult=false"
        guard let url =  URL(string:urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(APIError.failedToGetData) )
            }
            
        }
        task.resume()
    }
    func getYoutubeTrailer(searchFor query:String,completion : @escaping (Result<VideoElement,Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let urlString = "\(Constants.BASE_YOUTUBE_URL)q=\(query)&key=\(Constants.YOUTUBE_API_KEY)"
        guard let url =  URL(string:urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(jsonRes.items[0]))
                
            }catch {
//                completion(.failure(APIError.failedToGetData) )
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
