//
//  BreakpointRule.swift
//  Swiftxy
//
//  Created by n.lyapustin on 12.03.2023.
//

import Foundation

struct BreakpointRule {
    let id: UUID?
    let name: String
    let template: String
    let requestBody: String?
    let responseBody: String?
}
