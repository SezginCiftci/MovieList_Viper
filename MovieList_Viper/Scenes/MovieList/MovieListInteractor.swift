//
//  MovieListInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieListInteractorProtocol {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    
    func loadTrendingMovies()
    func loadPopularMovies()
    func loadUpcomingMovies()
}

final class MovieListInteractor {
    
    weak var presenter: MovieListInteractorOutputProtocol?
    
    func loadTrendingMovies() {
        NetworkManager.shared.getTrendingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.presenter?.didFetchTrendingMoviesSuccess(movie: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func loadPopularMovies() {
        NetworkManager.shared.getPopularMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.presenter?.didFetchPopularMoviesSuccess(movie: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func loadUpcomingMovies() {
        NetworkManager.shared.getUpcomingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.presenter?.didFetchUpcomingMoviesSuccess(movie: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
//    private func loadRecommendations(completion: @escaping () -> ()) {
//        NetworkManager.shared.getRecomendationsMovies(movieId: readSeenMovie()) { result in
//            switch result {
//            case .success(let success):
//                self.recommendationsMovies = success
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//            completion()
//        }
//    }
}

extension MovieListInteractor: MovieListInteractorProtocol {
    
}
