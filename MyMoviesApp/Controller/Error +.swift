//
//  Error +.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import UIKit

extension Error {
    func presentErr(vc: UIViewController) {
        let alert = UIAlertController(title: "error", message: self.localizedDescription, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}
