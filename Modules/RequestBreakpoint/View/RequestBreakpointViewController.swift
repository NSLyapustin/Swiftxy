//
//  RequestBreakpointViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

final class RequestBreakpointViewController: UIViewController {


    // MARK: Private properties

    private let output: RequestBreakpointViewOutput


    // MARK: Lifecycle

    init(output: RequestBreakpointViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setupViews() {
        view.backgroundColor = .systemBackground


    }
}

extension RequestBreakpointViewController: RequestBreakpointViewInput {}
