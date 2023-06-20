//
//  DeepLinkHandler.swift
//  Swiftxy
//
//  Created by n.lyapustin on 24.04.2023.
//

import Foundation

public class DeepLinkHandler {

    public init() {}

    public func handle(url: URL) {
        let name = url.valueOf("name")
        let template = url.valueOf("template")
        let requestBody = url.valueOf("requestBody")
        let responseBody = url.valueOf("responseBody")

        guard let name, let template else { fatalError() }

        let breakpoint = BreakpointRule(id: nil, name: name, template: template, requestBody: requestBody, responseBody: responseBody)
        UIApplication.shared.keyWindow?.rootViewController?.present(TemplateAddingModuleBuilder.init(
            displayData: .init(id: nil, name: name, template: template, requestBody: pretty(requestBody), responseBody: pretty(responseBody)),
            output: nil
        ).build(), animated: true)
        print(breakpoint)
    }

    private func pretty(_ string: String?) -> String {
        guard let data = string?.data(using: .utf8) else { return "" }

        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            return ""
        }
    }
}

private extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value?.removingPercentEncoding?.removingPercentEncoding
    }
}
