//
//  MovieCollectionReusableView.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 18.08.2023.
//

import UIKit

final class MovieCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var headerText: String?
    
    func setupCell() {
        if let viewForXib = Bundle.main.loadNibNamed("MovieCollectionReusableView", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            addSubview(viewForXib)
            headerLabel.text = headerText ?? ""
        }
    }
}
