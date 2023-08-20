//
//  MovieDetailViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import UIKit
import Kingfisher

protocol MovieDetailViewProtocol: AnyObject {
    func prepareNavigationBar()
    func prepareCollectionView()
    func updateUI(backdropUrl: URL, movieTitle: String, dateText: String, overviewText: String)
    func reloadCollectionView()
}

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var presenter: MovieDetailPresenterProtocol?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open((presenter?.getHomepageUrl())!)
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func updateUI(backdropUrl: URL, movieTitle: String, dateText: String, overviewText: String) {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundImageView.kf.setImage(with: backdropUrl)
            self?.title = movieTitle
            self?.dateLabel.text = dateText
            self?.overviewLabel.text = overviewText
            
            if (self?.overviewLabel.bounds.size.height)! > 100 {
                self?.contentViewHeight.constant = (self?.view.frame.size.height)! + ((self?.overviewLabel.bounds.size.height)! - 100)
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func prepareCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(nib: UINib(nibName: String(describing: HorizontalTrendingCell.self), bundle: nil), forCellWithClass: HorizontalTrendingCell.self)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.recommendationCollectionView.reloadData()
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: 0) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HorizontalTrendingCell.self, for: indexPath)
        
        cell.movieTitleLabel.text = presenter?.cellForRow(at: indexPath)?.title
        cell.movieReleaseDateLabel.text = presenter?.cellForRow(at: indexPath)?.releaseDate
        cell.movieImageView.kf.setImage(with: presenter?.cellForRow(at: indexPath)?.posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = presenter?.cellForRow(at: indexPath)?.id ?? 742536
        let movieDetail = MovieDetailRouter.createModule(movieId: movieId)
        present(movieDetail, animated: true)
    }
}
