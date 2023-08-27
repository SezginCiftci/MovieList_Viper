//
//  VerticalCollectionCellPresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 27.08.2023.
//

import Foundation

protocol VerticalCollectionCellPresenterInterface {
    var view: VerticalCollectionCellInterface? { get set }
    
    func layoutSubviews()
    func cellForRow(at indexPath: IndexPath) -> Movie?
    func numberOfItems(in section: Int) -> Int?
    func selectedMovie(with movieId: Int)
}

protocol VerticalCollectionCellDelegate {
    func didSelectMovie(with movieId: Int)
}

final class VerticalCollectionCellPresenter: VerticalCollectionCellPresenterInterface {
    
    weak var view: VerticalCollectionCellInterface?
    var delegate: VerticalCollectionCellDelegate
    var movies: [Movie]
    
    init(view: VerticalCollectionCellInterface? = nil,
         movies: [Movie],
         delegate: VerticalCollectionCellDelegate) {
        self.view = view
        self.movies = movies
        self.delegate = delegate
        !movies.isEmpty ? reloadCollectionView() : nil
    }
    
    func layoutSubviews() {
        view?.prepareCollectionView()
    }
    
    func reloadCollectionView() {
        view?.reloadCollectionView()
    }
    
    func cellForRow(at indexPath: IndexPath) -> Movie? {
        movies[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int? {
        movies.count
    }
    
    func selectedMovie(with movieId: Int) {
        delegate.didSelectMovie(with: movieId)
    }
    
}
