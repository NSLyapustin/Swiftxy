//
//  TemplatesListPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import Foundation

final class TemplatesListPresenter {

    // MARK: Internal properties

    weak var view: TemplatesListViewInput?

    // MARK: Lifecycle
}

extension TemplatesListPresenter: TemplatesListViewOutput {
    func viewDidLoad() {
        guard let templates = UserDefaults.standard.array(forKey: LibraryKeys.proxiedTemplatesKey) as? [String] else { return }
        view?.set(templates: templates)
    }

    func addButtonTapped() {
        view?.present(TemplateAddingModuleBuilder().build())
    }

    func closeButtonTapped() {
        view?.close()
    }
}
