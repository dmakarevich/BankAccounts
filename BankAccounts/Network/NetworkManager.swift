//
//  NetworkManager.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 11.10.2020.
//

import Foundation

class NetworkManager {
    static func load(path: Urls, withCompletion completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: (Urls.baseURL.rawValue + path.rawValue)) else {
            return
        }
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?,
                                                                     response: URLResponse?,
                                                                     error: Error?) -> Void in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            switch statusCode {
            case 200...300:
                completion(data)
            case 400...499:
                print("Request error! Status code: \(statusCode) Description: \(String(describing: error))")
            default:
                print("Server error! Status code: \(statusCode) Description: \(String(describing: error))")
            }
        })
        task.resume()
    }

    static func insert(path: Urls, parameters: String, withCompletion completion: @escaping () -> ()) {
        let postData =  parameters.data(using: .utf8)
        let url = URL(string: Urls.baseURL.rawValue + path.rawValue)
        guard let requestUrl = url else {
            fatalError()
        }
        debugPrint(parameters)
        var request = URLRequest(url: requestUrl, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = HTTPMethods.post.rawValue
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            switch statusCode {
            case 200...300:
                completion()
            case 400...499:
                print("Request error! Status code: \(statusCode) Description: \(String(describing: error))")
            default:
                print("Server error! Status code: \(statusCode) Description: \(String(describing: error))")
            }
        }

        task.resume()
    }

    static func delete(path: Urls, id: Int, withCompletion completion: @escaping () -> ()) {
        let parameters = "id=\(id)"
        guard let url = URL(string: (Urls.baseURL.rawValue + path.rawValue)) else {
            return
        }

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")

        request.httpMethod = HTTPMethods.delete.rawValue
        request.httpBody = parameters.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            switch statusCode {
            case 200...300:
                completion()
            case 400...499:
                print("Request error! Status code: \(statusCode) Description: \(String(describing: error))")
            default:
                print("Server error! Status code: \(statusCode) Description: \(String(describing: error))")
            }
        }
        task.resume()
    }
}
