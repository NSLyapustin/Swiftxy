//
//  TemplateAddingPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import Foundation

final class TemplateAddingPresenter {

    let coreData = CoreDataStorage()

    // MARK: Internal properties

    weak var view: TemplateAddingViewInput?
}

// MARK: TemplateAddingViewOutput

extension TemplateAddingPresenter: TemplateAddingViewOutput {
    func saveBreakpoint(name: String?, template: String?) {
        guard let name = name, let template = template else { return }
        try! coreData?.save(BreakpointRule(name: name, template: template))
    }
}
