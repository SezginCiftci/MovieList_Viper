//
//  UIViewController+.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import UIKit.UIViewController

extension UIViewController {
    func showAlert(_ errorMessage: String, completion: @escaping ()->()) {
        let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion()
        }
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
