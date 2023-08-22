//
//  MockMovieListRouter.swift
//  MovieList_ViperTests
//
//  Created by Sezgin Çiftci on 22.08.2023.
//

import UIKit

final class MockMovieListRouter: MovieListRouterProtocol {

    var view: UIViewController?
    
    var invokedRouteToDetail = false
    var invokedRouteToDetailCount = 0
    var invokedRouteToDetailParameters: (movieId: Int, Void)?
    var invokedRouteToDetailParametersList = [(movieId: Int, Void)]()

    func routeToDetail(movieId: Int) {
        invokedRouteToDetail = true
        invokedRouteToDetailCount += 1
        invokedRouteToDetailParameters = (movieId, ())
        invokedRouteToDetailParametersList.append((movieId, ()))
    }
}
