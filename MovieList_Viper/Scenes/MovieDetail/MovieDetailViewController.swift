//
//  MovieDetailViewController.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 20.08.2023.
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    
}

final class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenterProtocol?
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
}
