//
//  VerticalCollectionCell.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit
import Kingfisher

protocol VerticalCollectionCellInterface: AnyObject {
    func prepareCollectionView()
    func reloadCollectionView()
}

final class VerticalCollectionCell: UICollectionViewCell, VerticalCollectionCellInterface {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    var presenter: VerticalCollectionCellPresenterInterface?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presenter?.layoutSubviews()
    }
    
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(cellType: HorizontalTrendingCell.self)
    }
    
    func reloadCollectionView() {
        horizontalCollectionView.reloadData()
    }
}

extension VerticalCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: HorizontalTrendingCell.self, indexPath: indexPath)
        
        cell.movieTitleLabel.text = presenter?.cellForRow(at: indexPath)?.title
        cell.movieReleaseDateLabel.text = presenter?.cellForRow(at: indexPath)?.releaseDate
        cell.movieImageView.kf.setImage(with: presenter?.cellForRow(at: indexPath)?.posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = presenter?.cellForRow(at: indexPath)?.id {
            presenter?.selectedMovie(with: movieId)
        }
    }
}

