//
//  UIImageView +.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import UIKit

extension UIImageView {
   
    func loadImage(with url: String?) {
        let baseString = Constants.Connection.imageBaseString
        if let url = URL(string: "\(baseString)\(url ?? "")") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //TODO: handle error not print
                    print(error!)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: safeData)
                    }
                }
            }
            task.resume()
        }
    }
}
