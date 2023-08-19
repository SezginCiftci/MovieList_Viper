//
//  VerticalCollectionCell.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit
import Kingfisher

protocol VerticalCollectionCellDelegate {
    func didSelectMovie(with movieId: Int)
}

final class VerticalCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    var delegate: VerticalCollectionCellDelegate?
    
    var movieResult: [Movie]? {
        didSet {
            horizontalCollectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareCollectionView()
    }
    
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(nib: UINib(nibName: String(describing: HorizontalTrendingCell.self), bundle: nil), forCellWithClass: HorizontalTrendingCell.self)
    }
}

extension VerticalCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20)/2, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HorizontalTrendingCell.self, for: indexPath)
        
        cell.movieTitleLabel.text = movieResult?[indexPath.row].title
        cell.movieReleaseDateLabel.text = movieResult?[indexPath.row].releaseDate
        cell.movieImageView.kf.setImage(with: movieResult?[indexPath.row].posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = movieResult?[indexPath.row].id {
            delegate?.didSelectMovie(with: movieId)
        }
    }
}

