//
//  AFNetworkManager.swift
//  BankAccounts
//
//  Created by Dmitry Makarevich on 05.11.2020.
//

import Foundation
import Alamofire

class AFNetworkManager {
    static func load(path: Urls,
                     successHandler: @escaping (Data?) -> Void) {
        let fullPath = Urls.baseURL.rawValue + path.rawValue

        AF.request(fullPath)
          .responseJSON { (response) in
            if let error = response.error {
                debugPrint(error)
                return
            } else if let data = response.data, response.response?.statusCode == 200 {
                successHandler(data)
            } else {
                debugPrint("smth went wrong!")
            }
        }
    }

    static func insert(path: Urls,
                       parameters: [String: String],
                       withCompletion successHandler: @escaping () -> ()) {
        let url = Urls.baseURL.rawValue + path.rawValue

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
          .response { response in
            if let error = response.error {
                debugPrint(error)
                return
            } else if let httpResponse = response.response, httpResponse.statusCode == 200 {
                successHandler()
            } else {
                debugPrint("smth went wrong!")
            }
        }
    }

    static func delete(path: Urls,
                       id: Int,
                       successHandler: @escaping () -> ()) {
        let fullPath = Urls.baseURL.rawValue + path.rawValue
        let params = ["id": id]

        AF.request(fullPath,
                     method: .delete,
                     parameters: params)
          .responseJSON { (response) in
            if let error = response.error {
                debugPrint(error)
                return
            } else if let httpResponse = response.response, httpResponse.statusCode == 200 {
                successHandler()
            } else {
                debugPrint("smth went wrong!")
            }
        }
    }
}
