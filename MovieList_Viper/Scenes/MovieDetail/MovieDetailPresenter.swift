//
//  MovieDetailPresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    
}

protocol MovieDetailInteractorOutputProcol: AnyObject {
    
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProcol {
    
}
