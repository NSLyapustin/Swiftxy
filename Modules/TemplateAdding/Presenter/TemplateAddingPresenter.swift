//
//  TemplateAddingPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import Foundation

final class TemplateAddingPresenter {

    // MARK: Internal properties

    weak var view: TemplateAddingViewInput?

    // MARK: Private properties

    private weak var output: TemplateAddingModuleOutput?
    private let localStorage = CoreDataStorage()
    private let displayData: RequestBreakpointViewController.DisplayData

    // MARK: Lifecycle

    init(output: TemplateAddingModuleOutput) {
        self.output = output
    }
}

// MARK: TemplateAddingViewOutput

extension TemplateAddingPresenter: TemplateAddingViewOutput {
    func saveBreakpoint(name: String, template: String) {
        try! localStorage?.save(BreakpointRule(name: name, template: template))
        view?.dismiss()
        output?.moduleDidFinish()
    }

    func viewWantsToDismiss() {
        view?.dismiss()
    }
}
