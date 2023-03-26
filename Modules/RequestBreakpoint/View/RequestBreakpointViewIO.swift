//
//  RequestBreakpointViewIO.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

protocol RequestBreakpointViewInput: AnyObject {
    func set(displayData: RequestBreakpointViewController.DisplayData)
}

protocol RequestBreakpointViewOutput: AnyObject {
    func viewDidLoad()
}
