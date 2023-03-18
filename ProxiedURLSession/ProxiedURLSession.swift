//
//  ProxiedURLSession.swift
//  Swiftxy
//
//  Created by n.lyapustin on 19.02.2023.
//

import Foundation

public class ProxiedURLSession {

    // MARK: Private properties

    private let session = URLSession.shared
    private let userDefaults = UserDefaults.standard
    private let localStorage = CoreDataStorage()

    // MARK: Public methods

    open func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        // Getting all proxied templates
//        guard let templates = userDefaults.array(forKey: LibraryKeys.proxiedTemplatesKey) as? [String] else {
//            return session.dataTask(with: request, completionHandler: completionHandler)
//        }

        guard let optionalTemplates = (try? localStorage?.fetchBreakpoints().map { $0.template }),
              let templates = optionalTemplates
        else {
            return session.dataTask(with: request, completionHandler: completionHandler)
        }

        // Getting url in string format
        guard let urlString = request.url?.absoluteString else {
            return session.dataTask(with: request, completionHandler: completionHandler)
        }

        // Check if url matches template
        for template in templates {
            if URL.compareURL(urlString, with: template) {
                print(request.url)
                print(request.httpBody)
                print(request.httpMethod)
            }
        }

        return session.dataTask(with: request, completionHandler: completionHandler)
    }

    open func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // Getting all proxied templates
        guard let optionalTemplates = (try? localStorage?.fetchBreakpoints().map { $0.template }),
              let templates = optionalTemplates
        else {
            return session.dataTask(with: url, completionHandler: completionHandler)
        }


        // Check if url matches template
        for template in templates {
            if URL.compareURL(url.absoluteString, with: template) {
                print(url)
            }
        }

        return session.dataTask(with: url, completionHandler: completionHandler)
    }

    public func addTemplate(_ template: String) {
        if let array = userDefaults.array(forKey: LibraryKeys.proxiedTemplatesKey) as? [String] {
            var updatedArray = array
            updatedArray.append(template)
            userDefaults.set(updatedArray, forKey: LibraryKeys.proxiedTemplatesKey)
        } else {
            userDefaults.set([template], forKey: LibraryKeys.proxiedTemplatesKey)
        }
    }
}
