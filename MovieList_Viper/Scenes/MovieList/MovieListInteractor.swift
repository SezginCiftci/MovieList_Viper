//
//  MovieListInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieListInteractorProtocol {
    func fetchMainPageMovies()
    func saveSeenMovie(movieId: Int)
}

final class MovieListInteractor {
    
    weak var presenter: MovieListInteractorOutputProtocol?
    
    private var trendingMovies: MovieListModel?
    private var popularMovies: MovieListModel?
    private var upcomingMovies: MovieListModel?
    private var recommendationsMovies: MovieListModel?
    
    private let defaults = UserDefaults.standard
    
    private func getAllMovies() {
        let group = DispatchGroup()

        group.enter()
        loadTrendingMovies {
            group.leave()
        }

        group.enter()
        loadPopularMovies {
            group.leave()
        }

        group.enter()
        loadUpcomingMovies {
            group.leave()
        }
        
        group.enter()
        loadRecommendations {
            group.leave()
        }

        group.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            self?.presenter?.didFetchTrendingMoviesSucces(movie: self?.trendingMovies)
            self?.presenter?.didFetchPopularMoviesSucces(movie: self?.popularMovies)
            self?.presenter?.didFetchUpcomingMoviesSucces(movie: self?.upcomingMovies)
            self?.presenter?.didFetchRecommendationMoviesSucces(movie: self?.recommendationsMovies)
        }
    }
    
    private func loadTrendingMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getTrendingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.trendingMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    private func loadPopularMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getPopularMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.popularMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    private func loadUpcomingMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getUpcomingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.upcomingMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    private func loadRecommendations(completion: @escaping () -> ()) {
        NetworkManager.shared.getRecomendationsMovies(movieId: readSeenMovie()) { result in
            switch result {
            case .success(let success):
                self.recommendationsMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
}

extension MovieListInteractor: MovieListInteractorProtocol {
    func fetchMainPageMovies() {
        getAllMovies()
    }
    
    func saveSeenMovie(movieId: Int) {
        defaults.setValue(movieId, forKey: "LastSeenMovie")
    }
    
    private func readSeenMovie() -> Int {
        return defaults.integer(forKey: "LastSeenMovie")
    }
}
