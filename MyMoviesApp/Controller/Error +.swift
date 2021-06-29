//
//  Error +.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import UIKit

extension Error {
    func presentErr(vc: UIViewController, retryAction: @escaping ()->Void) {
        let alert = UIAlertController(title: "error", message: self.localizedDescription, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default))
        alert.addAction(.init(title: "retry", style: .default, handler: {(alert: UIAlertAction!) in retryAction()
        }))
        
        vc.present(alert, animated: true)
    
    }
}
