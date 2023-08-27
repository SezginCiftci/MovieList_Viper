//
//  MovieMoreViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import UIKit
import Kingfisher

protocol MovieMoreViewProtocol: AnyObject {
    var presenter: MovieMorePresenterProtocol? { get set }
    
    func prepareCollectionView()
    func prepareSearchBar()
    func prepareSearchBarAccessoryView()
    func reloadCollectionView()
    func updateTitleLabel(with text: String)
    func showAlert(_ errorMessage: String, completion: @escaping ()->())
}

final class MovieMoreViewController: UIViewController, MovieMoreViewProtocol {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeMoreCollectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var presenter: MovieMorePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func prepareCollectionView() {
        seeMoreCollectionView.delegate = self
        seeMoreCollectionView.dataSource = self
        seeMoreCollectionView.register(cellType: HorizontalTrendingCell.self)
    }
    
    func prepareSearchBar() {
        searchBar.delegate = self
    }
    
    func prepareSearchBarAccessoryView() {
        let toolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        
        let flexsibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressDoneButton))
        toolBar.items = [flexsibleSpace, doneButton]
        
        searchBar.inputAccessoryView = toolBar
    }

    @objc private func didPressDoneButton() {
        searchBar.resignFirstResponder()
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.seeMoreCollectionView.reloadData()
        }
    }
    
    func updateTitleLabel(with text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = text
        }
    }
    
}

//MARK: - CollectionView Delegate
extension MovieMoreViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: HorizontalTrendingCell.self, indexPath: indexPath)
        
        cell.movieTitleLabel.text = presenter?.cellForRow(at: indexPath)?.title
        cell.movieReleaseDateLabel.text = presenter?.cellForRow(at: indexPath)?.releaseDate
        cell.movieImageView.kf.setImage(with: presenter?.cellForRow(at: indexPath)?.posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 30)/2, height: (collectionView.frame.height - 20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayNextPageIfNeeded(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectMovie(presenter?.cellForRow(at: indexPath)?.id)
    }
}

//MARK: - SearchBar Delegate
extension MovieMoreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTextDidChange(searchText)
    }
}
