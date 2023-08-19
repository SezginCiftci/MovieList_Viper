//
//  MovieListViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit


final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var trendingMovies: MovieListModel?
    var popularMovies: MovieListModel?
    var upcomingMovies: MovieListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareNavigationBar()
        
        getAllMovies()
    }
    
    func getAllMovies() {
        let group = DispatchGroup()

        group.enter()
        loadTrendingMovies {
            group.leave()
        }

        group.enter()
        loadPopularMovies {
            group.leave()
        }

        group.enter()
        loadUpcomingMovies {
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    func loadTrendingMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getTrendingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.trendingMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    func loadPopularMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getPopularMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.popularMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    func loadUpcomingMovies(completion: @escaping () -> ()) {
        NetworkManager.shared.getUpcomingMovies(pageIndex: 1) { [weak self] result in
            switch result {
            case .success(let success):
                self?.upcomingMovies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movie List"
    }
    
    func prepareCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(nib: UINib(nibName: "VerticalCollectionCell", bundle: nil), forCellWithClass: VerticalCollectionCell.self)
        mainCollectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: MovieCollectionReusableView.self)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20), height: (collectionView.frame.height - 20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: VerticalCollectionCell.self, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.movieResult = trendingMovies?.results ?? []
        case 1:
            cell.movieResult = popularMovies?.results ?? []
        case 2:
            cell.movieResult = upcomingMovies?.results ?? []
        default:
            break
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: MovieCollectionReusableView.self, for: indexPath)
        
        header.setupCell()
        
        switch indexPath.section {
        case 0:
            header.headerText = "Trending Movies"
        case 1:
            header.headerText = "Popular Movies"
        case 2:
            header.headerText = "Upcoming Movies"
        default:
            break
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
