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
}

// MARK: TemplateAddingViewOutput

extension TemplateAddingPresenter: TemplateAddingViewOutput {
    func viewDidLoad() {
    }
}
