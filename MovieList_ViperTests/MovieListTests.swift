//
//  MovieListTests.swift
//  MovieList_ViperTests
//
//  Created by Sezgin Çiftci on 22.08.2023.
//

import XCTest
@testable import MovieList_Viper

final class MovieList_Test: XCTestCase {
    
    var sut: MovieListPresenter!
    var view: MockMovieListView!
    var interactor: MockMovieListInteractor!
    var router: MockMovieListRouter!
    
    override func setUp() {
        super.setUp()
        
        sut = .init()
        view = .init()
        interactor = .init()
        router = .init()
        
        view.presenter = sut
        interactor.presenter = sut
        sut.view = view
        sut.router = router
        sut.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        router = nil
        sut = nil
    }
    
    func test_viewDidLoad() {
        //Given
        XCTAssertFalse(view.invokedPrepareNavigationBar)
        XCTAssertFalse(view.invokedReloadCollectionView)
        XCTAssertFalse(interactor.invokedSaveSeenMovie)
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 0)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 0)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 0)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertFalse(view.invokedPrepareNavigationBar)
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertFalse(interactor.invokedSaveSeenMovie)
        XCTAssertTrue(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 0)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 1)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 0)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 1)
    }
    
    func test_viewWillAAppear() {
        //Given
        XCTAssertFalse(view.invokedPrepareNavigationBar)
        XCTAssertFalse(view.invokedReloadCollectionView)
        XCTAssertFalse(interactor.invokedSaveSeenMovie)
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 0)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 0)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 0)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewWillAppear()
        
        //Then
        XCTAssertTrue(view.invokedPrepareNavigationBar)
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(interactor.invokedSaveSeenMovie)
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 1)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 0)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 0)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
    }
    
    func test_didFetchTrendingSuccess() {
        //Given
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertNotNil(sut.trendingMovies)
    }
    
    func test_didFetchUpcomingMovies() {
        //Given
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertNotNil(sut.upcomingMovies)
    }
    
    func test_didFetchPopularMovies() {
        //Given
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertNotNil(sut.popularMovies)
    }
    
    func test_didFetchRecommendationsMovies() {
        //Given
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertNotNil(sut.recommendationsMovies)
    }
    
    func test_cellForRowAt() {
        //Given
        XCTAssertFalse(interactor.invokedFetchMainPageMovies)
        XCTAssertEqual(interactor.invokedFetchMainPageMoviesCount, 0)
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertGreaterThan(sut.cellForRow(at: IndexPath(row: 0, section: 0))?.count ?? 0, 0)
    }
    
    func test_didSaveLastSeen() {
        XCTAssertFalse(interactor.invokedSaveSeenMovie)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 0)
        XCTAssertNil(interactor.invokedSaveSeenMovieParameters)
        XCTAssertEqual(interactor.invokedSaveSeenMovieParametersList.count, 0)
        
        sut.didSaveLastSeen(movieId: 11111)
        
        XCTAssertTrue(interactor.invokedSaveSeenMovie)
        XCTAssertEqual(interactor.invokedSaveSeenMovieCount, 1)
        XCTAssertNotNil(interactor.invokedSaveSeenMovieParameters?.movieId)
        XCTAssertEqual(interactor.invokedSaveSeenMovieParameters?.movieId, 11111)
        XCTAssertEqual(interactor.invokedSaveSeenMovieParametersList.count, 1)
    }
    
    func test_didSelectMovie() {
        XCTAssertFalse(router.invokedRouteToDetail)
        XCTAssertEqual(router.invokedRouteToDetailCount, 0)
        XCTAssertNil(router.invokedRouteToDetailParameters)
        XCTAssertEqual(router.invokedRouteToDetailParametersList.count, 0)
        
        sut.didSelectMovie(movieId: 11111)
        
        XCTAssertTrue(router.invokedRouteToDetail)
        XCTAssertEqual(router.invokedRouteToDetailCount, 1)
        XCTAssertNotNil(router.invokedRouteToDetailParameters?.movieId)
        XCTAssertEqual(router.invokedRouteToDetailParameters?.movieId, 11111)
        XCTAssertEqual(router.invokedRouteToDetailParametersList.count, 1)
    }
    
    func test_numberItemsInSection() {
        //TODO: -
    }
    
    func test_numberOfSections() {
        //TODO: -
    }
}
