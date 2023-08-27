//
//  UICollectionReusableView.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 27.08.2023.
//

import UIKit.UICollectionView

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
