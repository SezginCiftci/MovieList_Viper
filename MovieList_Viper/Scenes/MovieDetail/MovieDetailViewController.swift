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
    func reloadCollectionView()
    func showAlert(_ errorMessage: String, completion: @escaping ()->())
}

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    
    var presenter: MovieDetailPresenterProtocol?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
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
    
    func prepareCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(cellType: HorizontalTrendingCell.self)
        recommendationCollectionView.registerView(cellType: DetailCollectionHeaderView.self)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: 0) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: HorizontalTrendingCell.self, indexPath: indexPath)
        
        cell.movieTitleLabel.text = presenter?.cellForRow(at: indexPath)?.title
        cell.movieReleaseDateLabel.text = presenter?.cellForRow(at: indexPath)?.releaseDate
        cell.movieImageView.kf.setImage(with: presenter?.cellForRow(at: indexPath)?.posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeView(cellType: DetailCollectionHeaderView.self, indexPath: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = presenter?.cellForRow(at: indexPath)?.id ?? 742536
        let movieDetail = MovieDetailRouter.createModule(movieId: movieId)
        present(movieDetail, animated: true)
    }
}
