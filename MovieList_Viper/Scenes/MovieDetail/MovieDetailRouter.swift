//
//  MovieDetailRouter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import UIKit

protocol MovieDetailRouterProtocol {

}

final class MovieDetailRouter: MovieDetailRouterProtocol {
    
    weak var view: UIViewController?
    
    class func createModule(movieId: Int) -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(movieId: movieId)
        let router = MovieDetailRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
