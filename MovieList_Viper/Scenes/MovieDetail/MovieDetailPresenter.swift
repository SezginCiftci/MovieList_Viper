//
//  MovieDetailPresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func cellForRow(at index: IndexPath) -> Movie?
    func numberOfRows(in section: Int) -> Int
    func numberOfSection() -> Int
    func getHomepageUrl() -> URL
}

protocol MovieDetailInteractorOutputProcol: AnyObject {
    func didFetchMovieDetail(movie: MovieDetailModel?)
    func didFetchSimilarMovies(movie: MovieListModel?)
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
    
    private var movieDetail: MovieDetailModel?
    private var similarMovies: MovieListModel?
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        interactor?.fetchMovieDetails(movieId: movieId)
    }
    
    func viewWillAppear() {
        view?.prepareCollectionView()
        view?.prepareNavigationBar()
    }
    
    func cellForRow(at index: IndexPath) -> Movie? {
        return similarMovies?.results[index.row]
    }
    
    func numberOfRows(in section: Int) -> Int {
        return similarMovies?.results.count ?? 0
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func getHomepageUrl() -> URL {
        return URL(string: movieDetail?.homepage ?? "https://en.wikipedia.org/wiki/HTTP_404")!
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProcol {
    func didFetchMovieDetail(movie: MovieDetailModel?) {
        movieDetail = movie
        view?.updateUI(backdropUrl: (movieDetail?.backdropURL ?? URL(string: "https://en.wikipedia.org/wiki/HTTP_404"))!,
                       movieTitle: movie?.originalTitle ?? "",
                       dateText: movieDetail?.releaseDate ?? "",
                       overviewText: movieDetail?.overview ?? "")
    }
    func didFetchSimilarMovies(movie: MovieListModel?) {
        similarMovies = movie
        view?.reloadCollectionView()
    }
}
