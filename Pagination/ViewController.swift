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
        
        HttpClient.shared.fetchUserInfo(with: 3)
    }
}

