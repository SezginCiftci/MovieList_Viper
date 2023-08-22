//
//  MockMovieListView.swift
//  MovieList_ViperTests
//
//  Created by Sezgin Çiftci on 22.08.2023.
//

import Foundation

final class MockMovieListView: MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol?

    var invokedPrepareNavigationBar = false
    var invokedPrepareNavigationBarCount = 0

    func prepareNavigationBar() {
        invokedPrepareNavigationBar = true
        invokedPrepareNavigationBarCount += 1
    }

    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0

    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }

    var invokedReloadCollectionView = false
    var invokedReloadCollectionViewCount = 0

    func reloadCollectionView() {
        invokedReloadCollectionView = true
        invokedReloadCollectionViewCount += 1
    }
}
