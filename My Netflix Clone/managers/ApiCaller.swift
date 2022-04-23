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
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(jsonRes.results ))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }
    func getTrendingTv(completion : @escaping (Result<[Tv],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }

    func getUpcomingMovies(completion : @escaping (Result<[Movie],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }
    func getPopularMovies(completion : @escaping (Result<[Movie],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }

    func getTopRatedMovies(completion : @escaping (Result<[Movie],Error>) -> Void){
        guard let url =  URL(string: "\(Constants.BASE_URL)/\(Constants.API_VERSION )/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }

            do {
                let jsonRes = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(jsonRes.results))
                
            }catch {
                completion(.failure(error) )
            }
            
        }
        task.resume()
    }
}
