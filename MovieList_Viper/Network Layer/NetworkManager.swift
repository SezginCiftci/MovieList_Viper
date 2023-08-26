//
//  NetworkManager.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 19.08.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getTrendingMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ())
    func getPopularMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ())
    func getUpcomingMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ())
    func getSimilarMovies(movieId: Int, completion: @escaping (Result<MovieListModel, Error>) -> ())
    func getRecomendationsMovies(movieId: Int, completion: @escaping (Result<MovieListModel, Error>) -> ())
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getTrendingMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ()) {
        request(.getTrending(pageIndex: pageIndex), completion: completion)
    }
    
    func getPopularMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ()) {
        request(.getPopular(pageIndex: pageIndex), completion: completion)
    }
    
    func getUpcomingMovies(pageIndex: Int, completion: @escaping (Result<MovieListModel, Error>) -> ()) {
        request(.getUpcoming(pageIndex: pageIndex), completion: completion)
    }
    
    func getSimilarMovies(movieId: Int, completion: @escaping (Result<MovieListModel, Error>) -> ()) {
        request(.getSimilar(movieId: movieId), completion: completion)
    }
    
    func getRecomendationsMovies(movieId: Int, completion: @escaping (Result<MovieListModel, Error>) -> ()) {
        request(.getRecommendations(movieId: movieId), completion: completion)
    }
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetailModel, Error>) -> ()) {
        request(.getDetail(movieId: movieId), completion: completion)
    }
}

extension NetworkManager {
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let error {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
