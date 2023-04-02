//
//  URLRequestViewController.swift
//  Swiftxy_Example
//
//  Created by n.lyapustin on 02.04.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

final class URLRequestViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!


    @IBAction func clearButtonDidTapped(_ sender: Any) {
        dataLabel.text = ""
    }

    @IBAction func sendRequestButtonDidTapped(_ sender: Any) {
        var components = URLComponents(string: "https://d3mj1.mocklab.io/json")!
        components.queryItems = [
            URLQueryItem(name: "example", value: "urlrequest")
        ]

        let requestDto = RequestExample(id: 1, type: "Original")

        var request = URLRequest(url: components.url!)
        request.httpBody = try! JSONEncoder().encode(requestDto)
        request.httpMethod = "POST"
        request.addValue("Original", forHTTPHeaderField: "type")

        URLSession.proxied.dataTask(with: request) { data, response, error in
            guard let responseData = String(data: data!, encoding: .utf8) else { return }
            DispatchQueue.main.async {
                self.dataLabel.text = responseData
            }
        } completionDataTask: { task in
            task?.resume()
        }
    }
}
