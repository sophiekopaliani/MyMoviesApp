//
//  ConnectionManager.swift
//  MyMoviesApp
//
//  Created by Sophie Kopaliani on 6/27/21.
//

import Foundation

class ConnectoinManager {
    
    func fetchData<T>(urlString: String, successCallback: ((T) -> Void)?, errorCallback: ((Error) -> Void)?) where T: Codable {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    errorCallback?(error!)
                    return
                }
                if let safeData = data {
                    if let response: T = self.parseJSON(data: safeData, errorCallback: errorCallback) {
                        successCallback?(response)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON<T>(data: Data, errorCallback: ((Error) -> Void)? ) -> T? where T: Codable {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch  {
            errorCallback?(error)
        }
        return nil
    }
}
