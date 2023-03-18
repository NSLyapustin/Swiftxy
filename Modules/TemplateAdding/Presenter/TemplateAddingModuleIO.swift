//
//  TemplateAddingModuleIO.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import Foundation

protocol TemplateAddingModuleInput: AnyObject {}

protocol TemplateAddingModuleOutput: AnyObject {
    func moduleDidFinish()
}
