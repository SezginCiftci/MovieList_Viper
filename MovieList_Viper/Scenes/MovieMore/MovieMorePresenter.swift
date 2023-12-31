//
//  MovieMorePresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import Foundation

protocol MovieMorePresenterProtocol {
    var view: MovieMoreViewProtocol? { get set }
    var router: MovieMoreRouterProtocol? { get set }
    var interactor: MovieMoreInteractorProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func cellForRow(at indexPath: IndexPath) -> Movie?
    func numberOfRows(in section: Int) -> Int?
    func willDisplayNextPageIfNeeded(at indexPath: IndexPath)
    func searchTextDidChange(_ searchText: String)
    func didSelectMovie(_ movieId: Int?)
}

protocol MovieMoreInteractorOutputProtocol: AnyObject {
    func handleMoviesWithSuccess(_ movies: MovieListModel?)
    func handleMoviesWithFailure(_ errorMessage: String)
}

final class MovieMorePresenter: MovieMorePresenterProtocol {
    weak var view: MovieMoreViewProtocol?
    var router: MovieMoreRouterProtocol?
    var interactor: MovieMoreInteractorProtocol?
    
    var cellType: MainCollectionCellTypes
    var movies: [Movie] = []
    var pageCounter: Int = 1
    var searchText: String?
    
    init(cellType: MainCollectionCellTypes) {
        self.cellType = cellType
    }
    
    func viewDidLoad() {
        view?.prepareSearchBar()
        view?.prepareCollectionView()
        view?.prepareSearchBarAccessoryView()
        interactor?.fetchMoreMovies(cellType: cellType, pageIndex: 1)
    }
    
    func viewWillAppear() {
        //TODO: 
    }
    
    func cellForRow(at indexPath: IndexPath) -> Movie? {
        configureMovies()[indexPath.row]
    }
    
    func numberOfRows(in section: Int) -> Int? {
        configureMovies().count
    }
    
    func willDisplayNextPageIfNeeded(at indexPath: IndexPath) {
        pageCounter += 1
        if let numberOfRows = numberOfRows(in: indexPath.section), (indexPath.row == numberOfRows - 1 ) {
            interactor?.fetchMoreMovies(cellType: cellType, pageIndex: pageCounter)
        }
    }
    
    func searchTextDidChange(_ searchText: String) {
        self.searchText = searchText
        view?.reloadCollectionView()
    }
    
    func configureMovies() -> [Movie] {
        if !searchText.isNilOrEmpty {
            return movies.filter { $0.originalTitle?.contains(searchText!) ?? false }
        }
        return movies
    }
    
    func didSelectMovie(_ movieId: Int?) {
        guard let movieId else { return }
        router?.routeDetail(movieId: movieId)
    }
}

extension MovieMorePresenter: MovieMoreInteractorOutputProtocol {
    func handleMoviesWithSuccess(_ movies: MovieListModel?) {
        self.movies.append(contentsOf: movies?.results ?? [])
        view?.reloadCollectionView()
        view?.updateTitleLabel(with: cellType.cellTypes)
    }
    
    func handleMoviesWithFailure(_ errorMessage: String) {
        view?.showAlert(errorMessage, completion: { [weak self] in
            guard let self else { return }
            interactor?.fetchMoreMovies(cellType: cellType, pageIndex: pageCounter)
        })
    }
}
