//
//  UICollectionView+.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 19.08.2023.
//

import UIKit.UICollectionView

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func dequeView<T: UICollectionReusableView>(cellType: T.Type, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return reusableView
    }
    
    func registerView(cellType: UICollectionReusableView.Type, kind: String = UICollectionView.elementKindSectionHeader) {
        register(cellType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.identifier)
    }
}
