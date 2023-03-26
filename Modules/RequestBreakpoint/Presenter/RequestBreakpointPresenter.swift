//
//  RequestBreakpointPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

final class RequestBreakpointPresenter {

    // MARK: Private properties

    private let displayData: RequestBreakpointViewController.DisplayData?

    // MARK: Internal properties

    weak var view: RequestBreakpointViewInput?

    // MARK: Lifecycle

    init(displayData: RequestBreakpointViewController.DisplayData?) {
        self.displayData = displayData
    }
}

extension RequestBreakpointPresenter: RequestBreakpointViewOutput {
    func viewDidLoad() {
        guard let displayData else { return }
        view?.set(displayData: displayData)
    }
}

extension RequestBreakpointPresenter: RequestBreakpointModuleInput {}
