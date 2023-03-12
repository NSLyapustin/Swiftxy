//
//  TemplatesListVIewIO.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import UIKit

protocol TemplatesListViewInput: AnyObject {
    func set(templates: [String])
    func close()
    func present(_ viewController: UIViewController)
}

protocol TemplatesListViewOutput: AnyObject {
    func viewDidLoad()
    func addButtonTapped()
    func closeButtonTapped()
}
