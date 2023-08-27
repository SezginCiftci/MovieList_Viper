//
//  MovieMoreRouter.swift
//  MovieMore_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import UIKit

protocol MovieMoreRouterProtocol {
    var view: UIViewController? { get set }
    
    func routeDetail(movieId: Int)
}

final class MovieMoreRouter: MovieMoreRouterProtocol {
    
    weak var view: UIViewController?
    
    class func createModule(with cellType: MainCollectionCellTypes) -> MovieMoreViewController {
        let view = MovieMoreViewController()
        let interactor = MovieMoreInteractor()
        let presenter = MovieMorePresenter(cellType: cellType)
        let router = MovieMoreRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func routeDetail(movieId: Int) {
        let vc = MovieDetailRouter.createModule(movieId: movieId)
        view?.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
