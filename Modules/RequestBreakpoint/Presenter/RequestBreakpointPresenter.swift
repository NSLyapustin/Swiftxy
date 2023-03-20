//
//  RequestBreakpointPresenter.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

final class RequestBreakpointPresenter {

    // MARK: Internal properties

    weak var view: RequestBreakpointViewInput?
}

extension RequestBreakpointPresenter: RequestBreakpointViewOutput {}

extension RequestBreakpointPresenter: RequestBreakpointModuleInput {}
