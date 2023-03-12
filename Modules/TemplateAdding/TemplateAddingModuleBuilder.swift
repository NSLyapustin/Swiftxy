//
//  TemplateAddingModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import UIKit

final class TemplateAddingModuleBuilder {
    func build() -> UIViewController {
        let presenter = TemplateAddingPresenter()
        let view = TemplateAddingViewController(output: presenter)
        presenter.view = view

        return view
    }
}
