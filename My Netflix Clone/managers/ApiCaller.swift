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

enum APIError: Error {
    case failedToGetData
}
class ApiCaller {
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
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
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
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
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
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
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
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
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
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
        let urlString = "\(Constants.BASE_URL)/\(Constants.API_VERSION )/search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)&page=1&include_adult=false"
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
}
