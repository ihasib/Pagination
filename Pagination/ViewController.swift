//
//  ViewController.swift
//  Pagination
//
//  Created by S. M. Hasibur Rahman on 18/5/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchUsers()
    }

    func fetchUsers() {
        print("fetch users called")
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}

