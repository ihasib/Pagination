//
//  HttpClient.swift
//  Pagination
//
//  Created by S. M. Hasibur Rahman on 20/5/24.
//

import Foundation

class HttpClient {
    static let shared = HttpClient()
    
    private init() {
        
    }
    
    func fetchUserInfo(with id: Int) {
        print("fetch users called")
        let urlString = "https://reqres.in/api/users/\(id)"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
                if let data = json["data"], let support = json["support"] {
                    print("+data = \(data)")
                    print("+support = \(support)")
                }
                print("-json = \(json)")
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
