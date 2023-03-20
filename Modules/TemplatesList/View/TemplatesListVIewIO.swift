//
//  TemplatesListVIewIO.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import UIKit

protocol TemplatesListViewInput: AnyObject {
    func set(breakpoints: [TemplateListTableViewCell.DisplayData])
    func close()
    func present(_ viewController: UIViewController)
}

protocol TemplatesListViewOutput: AnyObject {
    func viewDidLoad()
    func addButtonTapped()
    func closeButtonTapped()
}
