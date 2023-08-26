//
//  MovieCollectionReusableView.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit

protocol MovieCollectionReusableViewDelegate {
    func didTapSeeMore(indexPath: IndexPath)
}

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
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.setTitle("See More", for: .normal)
        return button
    }()
    
    var delegate: MovieCollectionReusableViewDelegate?
    
    private var indexPath: IndexPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
    }
    
    private func configureCell() {
        addSubviewsFromExt(headerLabel, seeMoreButton)
        headerLabel.anchor(top: self.topAnchor,
                           left: self.leftAnchor,
                           bottom: self.bottomAnchor,
                           paddingLeft: 20)
        
        seeMoreButton.anchor(top: self.topAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingRight: 20)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonAct), for: .touchUpInside)
    }
    
    @objc func seeMoreButtonAct() {
        delegate?.didTapSeeMore(indexPath: indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setupCell(at index: IndexPath) {
        indexPath = index
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
