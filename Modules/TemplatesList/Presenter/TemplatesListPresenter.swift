//
//  TemplatesListPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import CoreData
import Foundation

final class TemplatesListPresenter {

    // MARK: Internal properties

    weak var view: TemplatesListViewInput?

    // MARK: Private properties

    private let localStorage = CoreDataStorage()

    // MARK: Lifecycle

    private func reloadData() {
        let templates = try! localStorage?.fetchBreakpoints().map { $0.template }
        view?.set(templates: templates!)
    }
}

extension TemplatesListPresenter: TemplatesListViewOutput {
    func viewDidLoad() {
        reloadData()
    }

    func addButtonTapped() {
        view?.present(TemplateAddingModuleBuilder(output: self).build())
    }

    func closeButtonTapped() {
        view?.close()
    }
}

extension TemplatesListPresenter: TemplateAddingModuleOutput {
    func moduleDidFinish() {
        reloadData()
    }
}
