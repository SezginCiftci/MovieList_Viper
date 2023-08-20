//
//  MovieCollectionReusableView.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit

final class MovieCollectionReusableView: UICollectionReusableView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "textColor")!
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.text = "Movies"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
    }
    
    private func configureCell() {
        self.addSubview(headerLabel)
        headerLabel.anchor(top: self.topAnchor,
                           left: self.leftAnchor,
                           bottom: self.bottomAnchor,
                           paddingLeft: 20,
                           paddingRight: 20)
    }
    
    func setupCell(at index: IndexPath) {
        switch index.section {
        case 0:
            headerLabel.text = "Trending Movies "
         case 1:
            headerLabel.text = "Popular Movies"
        case 2:
            headerLabel.text = "Upcoming Movies"
        case 3:
            headerLabel.text = "Recommended Movies"
        default:
            break
        }
    }
}
