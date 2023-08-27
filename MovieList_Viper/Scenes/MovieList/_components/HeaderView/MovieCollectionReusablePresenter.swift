//
//  MovieCollectionReusablePresenter.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 27.08.2023.
//

import Foundation

enum MainCollectionCellTypes: Int {
    case trendingCell = 0
    case popular
    case upcoming
    
    var cellTypes: String {
        switch self {
        case .trendingCell:
            return "Trending Movies"
        case .popular:
            return "Popular Movies"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
}

protocol MovieCollectionReusablePresenterInterface {
    var view: MovieCollectionReusableViewInterface? { get set }
    
    func openSeeMore()
    func loadUI()
}

protocol MovieCollectionReusableViewDelegate {
    func didTapSeeMore(indexPath: IndexPath)
}

final class MovieCollectionReusablePresenter: MovieCollectionReusablePresenterInterface {
    
    weak var view: MovieCollectionReusableViewInterface?
    var delegate: MovieCollectionReusableViewDelegate
    var indexPath: IndexPath
    
    init(view: MovieCollectionReusableViewInterface? = nil, delegate: MovieCollectionReusableViewDelegate, indexPath: IndexPath) {
        self.view = view
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    func loadUI() {
        view?.configureUI(with: setCellType()?.cellTypes ?? "Movies")
    }
    
    func openSeeMore() {
        delegate.didTapSeeMore(indexPath: indexPath)
    }
    
    private func setCellType() -> MainCollectionCellTypes? {
        if let cellType = MainCollectionCellTypes(rawValue: indexPath.section) {
            return cellType
        }
        return nil
    }
}
