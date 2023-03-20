//
//  RequestBreakpointModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

final class RequestBreakpointModuleBuilder {

    // MARK: Internal methods

    func build() -> UIViewController {
        let presenter = RequestBreakpointPresenter()
        let view = RequestBreakpointViewController(output: presenter)
        presenter.view = view

        return view
    }
}
