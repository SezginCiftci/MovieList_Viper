//
//  MovieListPresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieListPresenterProtocol {
    var view: MovieListViewProtocol? { get set }
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    
}
