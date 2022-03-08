//
//  APICaller.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/07.
//

import Foundation
import Alamofire

struct Constants {
    static let baseURL = "https://api.themoviedb.org"
    static let API_KEY = "677ab20fca9e6c8f8d50fa33b77742c9"
    static let YoutubeAPI_KEY = "AIzaSyBWFZTlnh-SpyZM4dncM5gXh49JmMzzyeM"
    static let YoutubeBaseUrl = "https://www.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        let url = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=ko-KR&page=1"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=ko-KR&page=1"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=ko-KR&page=1"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        let url = "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=ok-KR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func search(with query:String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        let url = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)"
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    func getMovie(with query: String, completion: @escaping (Result<[VideoElement], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.YoutubeBaseUrl)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString).responseData { responseData in
            guard let data = responseData.data, responseData.error == nil else {return}
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResults.self, from: data)
                completion(.success(results.items))
            } catch {
                DLog(error.localizedDescription)
            }
        }
    }
}
