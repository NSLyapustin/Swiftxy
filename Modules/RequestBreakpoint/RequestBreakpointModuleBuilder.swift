//
//  RequestBreakpointModuleBuilder.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

public final class RequestBreakpointModuleBuilder {

    private let displayData: RequestBreakpointViewController.DisplayData?

    // MARK: Public methods

    public init(displayData: RequestBreakpointViewController.DisplayData? = nil) {
        self.displayData = displayData
    }

    public func build() -> RequestBreakpointViewController {
        let presenter = RequestBreakpointPresenter(displayData: displayData)
        let view = RequestBreakpointViewController(output: presenter)
        presenter.view = view

        return view
    }
}
