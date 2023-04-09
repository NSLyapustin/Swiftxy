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
        let breakpoints = try! localStorage?.fetchBreakpoints().map { TemplateListTableViewCell.DisplayData(name: $0.name, template: $0.template) } ?? []
        view?.set(breakpoints: breakpoints)
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

    func deleteButtonTapped(at index: Int) {
        try! localStorage?.delete(at: index)
    }
}

extension TemplatesListPresenter: TemplateAddingModuleOutput {
    func moduleDidFinish() {
        reloadData()
    }
}
