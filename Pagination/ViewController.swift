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
        
        HttpClient.shared.statusDelegate = self
        HttpClient.shared.statusDelegateStruct = self
        HttpClient.shared.fetchUserInfo(with: 3)
    }
}

extension ViewController: StatusUpdaterDict {
    func didFetchFailed(error: Error?=nil) {
        print("didFetchFailed called")
        if let error = error {
            print(error.localizedDescription)
        }
        
    }
    
    func didFetchSucceeded(userInfo: [String : Any]) {
        print("disFetchSucceeded called")
        if let data = userInfo["data"], let support = userInfo["support"] {
            print("+data = \(data)")
            print("+support = \(support)")
        }
    }
}



extension ViewController: StatusUpdaterStruct {
    
    func didFetchSucceeded(userInfo: Any) {
        print("disFetchSucceeded called")
        let user = try? JSONDecoder().decode(User.self, from: userInfo as! Data)
        print(user)
    }
}

struct User: Decodable {
    let data: Dataa
    let support: Support
}

struct Dataa: Decodable {
    let id: Int
    let avatar: String
    let email: String
    let first_name: String
    let last_name: String
}

struct Support: Decodable {
    let url: String
    let text: String
}
