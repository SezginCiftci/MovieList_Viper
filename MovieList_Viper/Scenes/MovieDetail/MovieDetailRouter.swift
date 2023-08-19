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
        let view = MovieDetailViewController(movieId: movieId)
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
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
