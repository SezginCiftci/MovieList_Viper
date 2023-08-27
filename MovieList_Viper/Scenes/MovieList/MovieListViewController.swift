//
//  MovieListViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func prepareNavigationBar()
    func prepareCollectionView()
    func reloadCollectionView()
}

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var presenter: MovieListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

//MARK: - MovieListViewProtocol
extension MovieListViewController: MovieListViewProtocol {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movie List"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "textColor")!]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func prepareCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(nib: UINib(nibName: String(describing: VerticalCollectionCell.self), bundle: nil), forCellWithClass: VerticalCollectionCell.self)
        mainCollectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: MovieCollectionReusableView.self)
    }
}

//MARK: - VerticalCollectionCellDelegate
extension MovieListViewController: VerticalCollectionCellDelegate {
    func didSelectMovie(with movieId: Int) {
        presenter?.didSaveLastSeen(movieId: movieId)
        presenter?.didSelectMovie(movieId: movieId)
    }
}

//MARK: - UICollectionView Delegate Methods
extension MovieListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20), height: (collectionView.frame.height - 20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberItems(in: section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: VerticalCollectionCell.self, for: indexPath)
        
        let presenter = VerticalCollectionCellPresenter(view: cell,
                                                        movies: presenter?.cellForRow(at: indexPath) ?? [],
                                                        delegate: self)
        cell.presenter = presenter
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: MovieCollectionReusableView.self, for: indexPath)
        header.setupCell(at: indexPath)
        header.delegate = self
        
        return header
    }
}

//MARK: - Header Delegate Methods
extension MovieListViewController: MovieCollectionReusableViewDelegate {
    func didTapSeeMore(indexPath: IndexPath) {
        presenter?.didTappedSeeMore(indexPath: indexPath)
    }
}
