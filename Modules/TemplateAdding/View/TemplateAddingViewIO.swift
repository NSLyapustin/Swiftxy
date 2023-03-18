//
//  TemplateAddingViewIO.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import Foundation

protocol TemplateAddingViewInput: AnyObject {
    func dismiss()
}

protocol TemplateAddingViewOutput: AnyObject {
    func saveBreakpoint(name: String, template: String)
    func viewWantsToDismiss()
}
