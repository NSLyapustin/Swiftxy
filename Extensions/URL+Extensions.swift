//
//  String+Extensions.swift
//  Swiftxy
//
//  Created by n.lyapustin on 19.02.2023.
//

import Foundation

extension URL {
    static func compareURL(_ url: String, with pattern: String) -> Bool {
        let urlComponents = URLComponents(string: url)
        let patternComponents = URLComponents(string: pattern)

        // If either the URL or the pattern cannot be parsed into URL components, return false
        guard let urlComponents = urlComponents, let patternComponents = patternComponents else {
            return false
        }

        // Compare the scheme, host, and port
        if urlComponents.scheme != patternComponents.scheme ||
            urlComponents.host != patternComponents.host ||
            urlComponents.port != patternComponents.port {
            return false
        }

        // Compare each path component, skipping any component in the pattern that is an asterisk
        let urlPathComponents = urlComponents.path.components(separatedBy: "/").filter { !$0.isEmpty }
        let patternPathComponents = patternComponents.path.components(separatedBy: "/").filter { !$0.isEmpty }

        var patternIndex = 0

        for urlComponent in urlPathComponents {
            if patternIndex >= patternPathComponents.count {
                // If there are no more components in the pattern to match, return false
                return false
            }

            let patternComponent = patternPathComponents[patternIndex]

            if patternComponent == "*" {
                // If the current pattern component is an asterisk, skip to the next pattern component
                patternIndex += 1
                continue
            }

            if urlComponent != patternComponent {
                // If the current URL component does not match the current pattern component, return false
                return false
            }

            // Move on to the next pattern component
            patternIndex += 1
        }

        // If there are still pattern components left to match, and the last pattern component is not an asterisk, return false
        if patternIndex < patternPathComponents.count && patternPathComponents[patternIndex] != "*" {
            return false
        }

        // All components match
        return true
    }
}
