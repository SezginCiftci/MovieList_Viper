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
    func didTapSeeMore(cellType: MainCollectionCellTypes)
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
        view?.configureUI(with: setCellType().cellTypes)
    }
    
    func openSeeMore() {
        delegate.didTapSeeMore(cellType: setCellType())
    }
    
    private func setCellType() -> MainCollectionCellTypes {
        if let cellType = MainCollectionCellTypes(rawValue: indexPath.section) {
            return cellType
        }
        return .trendingCell
    }
}
