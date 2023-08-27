//
//  MovieMoreInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import Foundation

protocol MovieMoreInteractorProtocol {
    var presenter: MovieMoreInteractorOutputProtocol? { get set }
    
    func fetchMoreMovies(cellType: MainCollectionCellTypes, pageIndex: Int)
}


final class MovieMoreInteractor: MovieMoreInteractorProtocol {
    weak var presenter: MovieMoreInteractorOutputProtocol?
    
    func fetchMoreMovies(cellType: MainCollectionCellTypes, pageIndex: Int) {
        switch cellType {
        case .trendingCell:
            loadTrendingMovies(with: pageIndex)
        case .popular:
            loadPopularMovies(with: pageIndex)
        case .upcoming:
            loadUpcomingMovies(with: pageIndex)
        }
    }
    
    func loadTrendingMovies(with pageIndex: Int) {
        NetworkManager.shared.getTrendingMovies(pageIndex: pageIndex) { result in
            switch result {
            case .success(let success):
                self.presenter?.handleMoviesWithSuccess(success)
            case .failure(let failure):
                self.presenter?.handleMoviesWithFailure(failure.localizedDescription)
            }
        }
    }
    
    func loadPopularMovies(with pageIndex: Int) {
        NetworkManager.shared.getPopularMovies(pageIndex: pageIndex) { result in
            switch result {
            case .success(let success):
                self.presenter?.handleMoviesWithSuccess(success)
            case .failure(let failure):
                self.presenter?.handleMoviesWithFailure(failure.localizedDescription)
            }
        }
    }
    
    func loadUpcomingMovies(with pageIndex: Int) {
        NetworkManager.shared.getUpcomingMovies(pageIndex: pageIndex) { result in
            switch result {
            case .success(let success):
                self.presenter?.handleMoviesWithSuccess(success)
            case .failure(let failure):
                self.presenter?.handleMoviesWithFailure(failure.localizedDescription)
            }
        }
    }
}
