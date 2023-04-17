//
//  TemplateAddingModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import UIKit

final class TemplateAddingModuleBuilder {

    // MARK: Private properties

    private let output: TemplateAddingModuleOutput
    private let displayData: TemplateAddingViewController.DisplayData?

    // MARK: Lifecycle

    init(displayData: TemplateAddingViewController.DisplayData? = nil, output: TemplateAddingModuleOutput) {
        self.output = output
        self.displayData = displayData
    }

    // MARK: Internal methods

    func build() -> UIViewController {
        let presenter = TemplateAddingPresenter(output: output)
        let view = TemplateAddingViewController(displayData: displayData, output: presenter)
        presenter.view = view

        return view
    }
}
