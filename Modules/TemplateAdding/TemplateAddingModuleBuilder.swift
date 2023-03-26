//
//  TemplateAddingModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import UIKit

final class TemplateAddingModuleBuilder {

    // MARK:

    typealias RequestDisplayData = RequestBreakpointViewController.DisplayData

    // MARK: Private properties

    private let output: TemplateAddingModuleOutput

    // MARK: Lifecycle

    init(displayData: RequestDisplayData? = nil, output: TemplateAddingModuleOutput) {
        self.output = output
    }

    // MARK: Internal methods

    func build() -> UIViewController {
        let presenter = TemplateAddingPresenter(output: output)
        let view = TemplateAddingViewController(output: presenter)
        presenter.view = view

        return view
    }
}
