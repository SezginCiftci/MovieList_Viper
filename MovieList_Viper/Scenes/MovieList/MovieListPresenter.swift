//
//  MovieListPresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation


protocol MovieListPresenterProtocol {
    var view: MovieListViewProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
    func cellForRow(at index: IndexPath) -> [Movie]?
    func numberOfSections() -> Int
    func numberItems(in section: Int) -> Int
    func didSelectMovie(movieId: Int)
    func didTappedSeeMore(cellType: MainCollectionCellTypes)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    func didFetchTrendingMoviesSuccess(movie: MovieListModel?)
    func didFetchPopularMoviesSuccess(movie: MovieListModel?)
    func didFetchUpcomingMoviesSuccess(movie: MovieListModel?)
    func didFetchTrendingMoviesFailure(errorMessage: String)
    func didFetchPopularMoviesFailure(errorMessage: String)
    func didFetchUpcomingMoviesFailure(errorMessage: String)
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    var trendingMovies: MovieListModel?
    var popularMovies: MovieListModel?
    var upcomingMovies: MovieListModel?
    var serviceResponseCounter: Int = 0 {
        didSet {
            if serviceResponseCounter >= MainCollectionCellTypes.allCases.count {
                view?.reloadCollectionView()
                view?.loadingEnded()
            }
        }
    }
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.loadingStarted()
        interactor?.loadTrendingMovies()
        interactor?.loadPopularMovies()
        interactor?.loadUpcomingMovies()
    }
    
    func viewWillAppear() {
        view?.prepareNavigationBar()
    }
    
    func viewDidDisappear() {
        serviceResponseCounter = 0
    }
    
    func cellForRow(at index: IndexPath) -> [Movie]? {
        switch index.section {
        case 0: return trendingMovies?.results
        case 1: return popularMovies?.results
        case 2: return upcomingMovies?.results
        default:
            return nil
        }
    }
    
    func numberItems(in section: Int) -> Int {
        return 1
    }
    
    func numberOfSections() -> Int {
        return MainCollectionCellTypes.allCases.count
    }
    
    func didSelectMovie(movieId: Int) {
        router?.routeToDetail(movieId: movieId)
    }
    
    func didTappedSeeMore(cellType: MainCollectionCellTypes) {
        router?.routeToSeeMore(cellType: cellType)
    }
    
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func didFetchTrendingMoviesSuccess(movie: MovieListModel?) {
        trendingMovies = movie
        serviceResponseCounter += 1
    }
    
    func didFetchPopularMoviesSuccess(movie: MovieListModel?) {
        popularMovies = movie
        serviceResponseCounter += 1
    }
    
    func didFetchUpcomingMoviesSuccess(movie: MovieListModel?) {
        upcomingMovies = movie
        serviceResponseCounter += 1
    }
    
    func didFetchTrendingMoviesFailure(errorMessage: String) {
        view?.showAlert("Trending Movies Error: \(errorMessage)", completion: {})
    }
    
    func didFetchPopularMoviesFailure(errorMessage: String) {
        view?.showAlert("Popular Movies Error: \(errorMessage)", completion: {})
    }
    
    func didFetchUpcomingMoviesFailure(errorMessage: String) {
        view?.showAlert("Popular Movies Error: \(errorMessage)", completion: {})
    }
    
}

enum MainCollectionCellTypes: Int, CaseIterable {
    case trendingCell = 0
    case popular
    case upcoming
    
    var cellTypes: String {
        switch self {
        case .trendingCell:
            return "Trending Movies"
        case .popular:
            return "Popular Movies"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
}
