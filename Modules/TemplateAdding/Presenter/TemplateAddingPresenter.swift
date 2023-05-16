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

    // MARK: Lifecycle

    init(output: TemplateAddingModuleOutput?) {
        self.output = output
    }
}

// MARK: TemplateAddingViewOutput

extension TemplateAddingPresenter: TemplateAddingViewOutput {
    func saveBreakpoint(breakpoint: BreakpointRule) {
        try! localStorage?.save(breakpoint)
        view?.dismiss()
        output?.moduleDidFinish()
    }

    func updateBreakpoint(breakpoint: BreakpointRule) {
        try! localStorage?.update(breakpoint)
        view?.dismiss()
        output?.moduleDidFinish()
    }

    func viewWantsToDismiss() {
        view?.dismiss()
    }
}
