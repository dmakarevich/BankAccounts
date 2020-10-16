//
//  NetworkManager.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 11.10.2020.
//

import Foundation

class NetworkManager {

    static func load(path: Urls, withCompletion completion: @escaping (Data?) -> ()) {
        guard let requestUrl = URL(string: (Urls.baseURL.rawValue + path.rawValue)) else {
            return
        }
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        
        let task = session.dataTask(with: requestUrl, completionHandler: { (data: Data?,
                                                                            response: URLResponse?,
                                                                            error: Error?) -> Void in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            switch statusCode {
            case 200...300:
                completion(data)
            default:
                print("Request error! Status code: \(statusCode)")
            }
        })
        task.resume()
    }
}
