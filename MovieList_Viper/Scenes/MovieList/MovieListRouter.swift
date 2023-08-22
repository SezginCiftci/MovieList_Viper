//
//  MovieListRouter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import UIKit

protocol MovieListRouterProtocol {
    var view: UIViewController? { get set }
    
    func routeToDetail(movieId: Int)
}

final class MovieListRouter: MovieListRouterProtocol {
    
    weak var view: UIViewController?
    
    class func createModule() -> MovieListViewController {
        let view = MovieListViewController()
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
    
    func routeToDetail(movieId: Int) {
        let movieDetail = MovieDetailRouter.createModule(movieId: movieId)
        view?.navigationController?.pushViewController(movieDetail, animated: true)
    }
}

