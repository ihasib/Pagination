//
//  HttpClient.swift
//  Pagination
//
//  Created by S. M. Hasibur Rahman on 20/5/24.
//

import Foundation

protocol StatusUpdaterDict {
    func didFetchFailed(error: Error?)
    func didFetchSucceeded(userInfo: [String: Any])
}

protocol StatusUpdaterStruct {
    func didFetchSucceeded(userInfo: Any)
}

class HttpClient {
    static let shared = HttpClient()
    var statusDelegate: StatusUpdaterDict?
    var statusDelegateStruct: StatusUpdaterStruct?
    
    private init() {
        
    }
    
    func fetchUserInfo(with id: Int) {
        print("fetch users called")
        let urlString = "https://reqres.in/api/users/\(id)"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            self?.statusDelegateStruct?.didFetchSucceeded(userInfo: data)
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    self?.statusDelegate?.didFetchFailed(error: nil)
                    return
                }
                self?.statusDelegate?.didFetchSucceeded(userInfo: json)
            } catch {
                self?.statusDelegate?.didFetchFailed(error: error)
            }
        }
        task.resume()
    }
}
