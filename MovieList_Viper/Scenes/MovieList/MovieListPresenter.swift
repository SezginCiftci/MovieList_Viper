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
    func cellForRow(at index: IndexPath) -> [Movie]?
    func numberOfSections() -> Int
    func numberItems(in section: Int) -> Int
    func didSaveLastSeen(movieId: Int)
    func didSelectMovie(movieId: Int)
    func didTappedSeeMore(cellType: MainCollectionCellTypes)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    func didFetchTrendingMoviesSucces(movie: MovieListModel?)
    func didFetchPopularMoviesSucces(movie: MovieListModel?)
    func didFetchUpcomingMoviesSucces(movie: MovieListModel?)
    func didFetchMoviesError()
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    var trendingMovies: MovieListModel?
    var popularMovies: MovieListModel?
    var upcomingMovies: MovieListModel?
    
    func viewDidLoad() {
        interactor?.fetchMainPageMovies()
        view?.prepareCollectionView()
    }
    
    func viewWillAppear() {
        view?.prepareNavigationBar()
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
        return 1 //TODO:
    }
    
    func numberOfSections() -> Int {
        return 3 //TODO:
    }
    
    func didSaveLastSeen(movieId: Int) {
        interactor?.saveSeenMovie(movieId: movieId)
    }
    
    func didSelectMovie(movieId: Int) {
        router?.routeToDetail(movieId: movieId)
    }
    
    func didTappedSeeMore(cellType: MainCollectionCellTypes) {
        router?.routeToSeeMore(cellType: cellType)
    }
    
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func didFetchTrendingMoviesSucces(movie: MovieListModel?) {
        trendingMovies = movie
        view?.reloadCollectionView()
    }
    
    func didFetchPopularMoviesSucces(movie: MovieListModel?) {
        popularMovies = movie
    }
    
    func didFetchUpcomingMoviesSucces(movie: MovieListModel?) {
        upcomingMovies = movie
    }
    
    func didFetchMoviesError() {
        //TODO:
    }
}
