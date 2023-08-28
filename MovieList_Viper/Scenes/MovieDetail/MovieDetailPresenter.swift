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
    func viewDidDisappear()
    func cellForRow(at index: IndexPath) -> Movie?
    func numberOfRows(in section: Int) -> Int
    func numberOfSection() -> Int
    func getHomepageUrl() -> URL
}

protocol MovieDetailInteractorOutputProcol: AnyObject {
    func didFetchMovieDetailSuccess(movie: MovieDetailModel?)
    func didFetchSimilarMoviesSuccess(movie: MovieListModel?)
    func didFetchRecommendationsMoviesSuccess(movie: MovieListModel?)
    func didFetchMovieDetailFailure(errorMessage: String)
    func didFetchSimilarMoviesFailure(errorMessage: String)
    func didFetchRecommendationsMoviesFailure(errorMessage: String)
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
    
    private var movieDetail: MovieDetailModel?
    private var similarMovies: MovieListModel?
    private var recommendationMovies: MovieListModel?
    var movieId: Int
    var serviceResponseCounter: Int = 0 {
        didSet {
            if serviceResponseCounter >= DetailCollectionCellTypes.allCases.count {
                view?.reloadCollectionView()
            }
        }
    }
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        interactor?.loadDetail(movieId: movieId)
        interactor?.loadSimilarMovies(movieId: movieId)
        interactor?.loadRecommendations(movieId: movieId)
    }
    
    func viewWillAppear() {
        view?.prepareCollectionView()
        view?.prepareNavigationBar()
    }
    
    func viewDidDisappear() {
        serviceResponseCounter = 0
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
    func didFetchMovieDetailSuccess(movie: MovieDetailModel?) {
        movieDetail = movie
        serviceResponseCounter += 1
        view?.updateUI(backdropUrl: (movieDetail?.backdropURL ?? URL(string: "https://en.wikipedia.org/wiki/HTTP_404"))!,
                       movieTitle: movie?.originalTitle ?? "",
                       dateText: movieDetail?.releaseDate ?? "",
                       overviewText: movieDetail?.overview ?? "")
    }
    
    func didFetchSimilarMoviesSuccess(movie: MovieListModel?) {
        similarMovies = movie
        serviceResponseCounter += 1
    }
    
    func didFetchRecommendationsMoviesSuccess(movie: MovieListModel?) {
        recommendationMovies = movie
        serviceResponseCounter += 1
    }
    
    func didFetchMovieDetailFailure(errorMessage: String) {
        view?.showAlert("Detail \(errorMessage)", completion: {})
    }
    
    func didFetchSimilarMoviesFailure(errorMessage: String) {
        view?.showAlert("Similar \(errorMessage)", completion: {})
    }
    
    func didFetchRecommendationsMoviesFailure(errorMessage: String) {
        view?.showAlert("Recommendation \(errorMessage)", completion: {})
    }
}

enum DetailCollectionCellTypes: Int, CaseIterable {
    case detail = 0
    case similar
    case recommendations
    
    var cellTypes: String {
        switch self {
        case .detail:
            return "Detail Movies"
        case .similar:
            return "Similar Movies"
        case .recommendations:
            return "Recommendation Movies"
        }
    }
}
