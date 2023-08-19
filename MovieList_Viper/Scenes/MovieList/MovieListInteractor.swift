//
//  MovieListInteractor.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import Foundation

protocol MovieListInteractorProtocol {
    
}

final class MovieListInteractor {
    
    weak var presenter: MovieListInteractorOutputProtocol?
}

extension MovieListInteractor: MovieListInteractorProtocol {
    
}
