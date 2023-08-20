//
//  MovieDetailViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import UIKit
import Kingfisher

protocol MovieDetailViewProtocol: AnyObject {
    
}

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    
    var presenter: MovieDetailPresenterProtocol?
    
    var movieDetail: MovieDetailModel?
    var movieRecommendations: MovieListModel?
    
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
        
    required convenience init?(coder: NSCoder) {
        self.init(movieId: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        getAllMovies()
        prepareNavigationBar()
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func updateUI() {
        backgroundImageView.kf.setImage(with: movieDetail?.backdropURL)
        title = movieDetail?.originalTitle
        dateLabel.text = movieDetail?.releaseDate
        overviewLabel.text = movieDetail?.overview
        
        if self.overviewLabel.bounds.size.height > 100 {
            self.contentViewHeight.constant = view.frame.size.height + (overviewLabel.bounds.size.height - 100)
            self.view.layoutIfNeeded()
        }
    }
    
    func getAllMovies() {
        let group = DispatchGroup()

        group.enter()
        loadDetail {
            group.leave()
        }

        group.enter()
        loadRecommendations {
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.recommendationCollectionView.reloadData()
            self?.updateUI()
        }
    }
    
    func loadDetail(completion: @escaping () -> ()) {
        NetworkManager.shared.getMovieDetail(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.movieDetail = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    func loadRecommendations(completion: @escaping () -> ()) {
        NetworkManager.shared.getRecomendationsMovies(movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.movieRecommendations = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion()
        }
    }
    
    func prepareCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(nib: UINib(nibName: String(describing: HorizontalTrendingCell.self), bundle: nil), forCellWithClass: HorizontalTrendingCell.self)
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        if let url = URL(string: movieDetail?.homepage ?? "https://en.wikipedia.org/wiki/HTTP_404") {
            UIApplication.shared.open(url)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieRecommendations?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HorizontalTrendingCell.self, for: indexPath)
        
        cell.movieTitleLabel.text = movieRecommendations?.results[indexPath.row].title
        cell.movieReleaseDateLabel.text = movieRecommendations?.results[indexPath.row].releaseDate
        cell.movieImageView.kf.setImage(with: movieRecommendations?.results[indexPath.row].posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = movieRecommendations?.results[indexPath.row].id ?? movieId
        let movieDetail = MovieDetailRouter.createModule(movieId: id)
        present(movieDetail, animated: true)
    }
}
