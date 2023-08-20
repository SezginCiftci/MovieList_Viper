//
//  MovieDetailInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    func fetchMovieDetails(movieId: Int)
}

final class MovieDetailInteractor {
    
    weak var presenter: MovieDetailInteractorOutputProcol?
    
    private var movieDetail: MovieDetailModel?
    private var similarMovies: MovieListModel?
    
    private func getAllMovies(movieId: Int) {
        let group = DispatchGroup()

        group.enter()
        loadDetail(movieId: movieId) {
            group.leave()
        }
        
        group.enter()
        loadSimilarMovies(movieId: movieId) {
            group.leave()
        }

        group.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            self?.presenter?.didFetchMovieDetail(movie: self?.movieDetail)
            self?.presenter?.didFetchSimilarMovies(movie: self?.similarMovies)
        }
    }
    
    private func loadDetail(movieId: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.getMovieDetail(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.movieDetail = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    private func loadSimilarMovies(movieId: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.getSimilarMovies(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.similarMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    func fetchMovieDetails(movieId: Int) {
        getAllMovies(movieId: movieId)
    }
}
