//
//  TemplatesListModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import UIKit

public class TemplatesListModuleBuilder {

    public init() {}

    public func build() -> UIViewController {
        let presenter = TemplatesListPresenter()
        let view = TemplatesListViewController(output: presenter)
        presenter.view = view

        return view
    }
}
