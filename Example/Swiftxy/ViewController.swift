//
//  ViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 07.02.2023.
//

import UIKit
import Swiftxy

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()

        print(1)

        var components = URLComponents(string: "http://api.weatherapi.com/v1/current.json")!
        components.queryItems = [
            URLQueryItem(name: "key", value: "5b4dfd35ac534755878113939232801"),
            URLQueryItem(name: "q", value: "Paris")
        ]

        print(components.url!)

        let task = URLSession.proxied.dataTask(with: components.url!) {(data, response, error) in
            guard let httpReponse = response as? HTTPURLResponse else { return }
            guard let weather = String(data: data!, encoding: .utf8) else { return }
            print(weather)
        }

        task.resume()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.present(TemplatesListModuleBuilder().build(), animated: true)
        }
    }
}
