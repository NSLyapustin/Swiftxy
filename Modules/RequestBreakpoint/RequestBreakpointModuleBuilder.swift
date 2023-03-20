//
//  RequestBreakpointModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

public final class RequestBreakpointModuleBuilder {

    // MARK: Public methods

    public init() {}

    public func build() -> UIViewController {
        let presenter = RequestBreakpointPresenter()
        let view = RequestBreakpointViewController(output: presenter)
        presenter.view = view

        return view
    }
}
