//
//  MovieCollectionReusableView.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit

protocol MovieCollectionReusableViewInterface: AnyObject {
    var presenter: MovieCollectionReusablePresenterInterface? { get set }
    
    func configureUI(with headerTitle: String)
}

final class MovieCollectionReusableView: UICollectionReusableView, MovieCollectionReusableViewInterface {
    
    @IBOutlet weak var headerLabel: UILabel!
    var presenter: MovieCollectionReusablePresenterInterface?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presenter?.loadUI()
    }
    
    func configureUI(with headerTitle: String) {
        headerLabel.text = headerTitle
    }
    
    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        presenter?.openSeeMore()
    }
}
