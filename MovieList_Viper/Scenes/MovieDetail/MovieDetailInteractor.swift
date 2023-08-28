//
//  MovieDetailInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    func loadDetail(movieId: Int)
    func loadSimilarMovies(movieId: Int)
    func loadRecommendations(movieId: Int)
}

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    weak var presenter: MovieDetailInteractorOutputProcol?
    
    func loadDetail(movieId: Int) {
        NetworkManager.shared.getMovieDetail(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.presenter?.didFetchMovieDetailSuccess(movie: success)
            case .failure(let failure):
                self.presenter?.didFetchMovieDetailFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
    
    func loadSimilarMovies(movieId: Int) {
        NetworkManager.shared.getSimilarMovies(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.presenter?.didFetchSimilarMoviesSuccess(movie: success)
            case .failure(let failure):
                self.presenter?.didFetchSimilarMoviesFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
    
    func loadRecommendations(movieId: Int) {
        NetworkManager.shared.getRecomendationsMovies(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.presenter?.didFetchRecommendationsMoviesSuccess(movie: success)
            case .failure(let failure):
                self.presenter?.didFetchRecommendationsMoviesFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
}
