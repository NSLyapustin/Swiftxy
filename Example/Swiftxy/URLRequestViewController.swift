//
//  URLRequestViewController.swift
//  Swiftxy_Example
//
//  Created by n.lyapustin on 02.04.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Swiftxy

struct Demo: Codable {
    let demo: String
}

import UIKit

final class URLRequestViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!


    @IBAction func clearButtonDidTapped(_ sender: Any) {
        dataLabel.text = ""
    }

    @IBAction func sendRequestButtonDidTapped(_ sender: Any) {
        var components = URLComponents(string: "http://127.0.0.1:8002/process_json")!
        components.queryItems = [
            URLQueryItem(name: "example", value: "urlrequest")
        ]

        let requestDto = Demo(demo: "Demo") 

        var request = URLRequest(url: components.url!)
        request.httpBody = try! JSONEncoder().encode(requestDto)
        request.httpMethod = "POST"
        request.addValue("Example", forHTTPHeaderField: "type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        URLSession.proxied.dataTask(with: request) { data, response, error in
            guard let responseData = String(data: data!, encoding: .utf8) else { return }
            print(responseData)
            DispatchQueue.main.async {
                self.dataLabel.text = responseData
            }
        } completionDataTask: { task in
            task?.resume()
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.present(TemplatesListModuleBuilder().build(), animated: true)
//            self.present(ResponseBreakpointViewController(displayData: ResponseBreakpointViewController.DisplayData()), animated: true)
        }
    }
}
