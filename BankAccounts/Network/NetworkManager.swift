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

    static func insert(path: Urls, parameters: String, withCompletion completion: @escaping (Data?) -> ()) {
        let url = URL(string: Urls.baseURL.rawValue + path.rawValue)
        guard let requestUrl = url else {
            fatalError()
        }
        var request = URLRequest(url: requestUrl, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")

        request.httpMethod = HTTPMethods.post.rawValue
        request.httpBody = parameters.data(using: .utf8)
        
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }

            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            completion(data)
        }
        task.resume()
    }

    static func delete(path: Urls, id: Int, withCompletion completion: @escaping (Data?) -> ()) {
        let parameters = "id=\(id)"
        guard let url = URL(string: (Urls.baseURL.rawValue + path.rawValue)) else {
            return
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")

        request.httpMethod = HTTPMethods.delete.rawValue
        request.httpBody = parameters.data(using: .utf8)
        
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }

            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            completion(data)
        }
        task.resume()
    }
}
