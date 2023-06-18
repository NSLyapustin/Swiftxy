//
//  RequestBreakpointViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

public final class RequestBreakpointViewController: UIViewController {

    // MARK: Nested Types

    public struct DisplayData {
        let url: String?
        let queryParameters: [String: String]?
        let headers: [String: String]?
        let body: String?
        let forUrlComponents: Bool
        let template: BreakpointRule
    }

    // MARK: Internal properties

    var onConfiguredWithURLComponents: ((URLComponents, Bool) -> Void)?
    var onConfiguredWithURLRequest: ((URLRequest, Bool) -> Void)?
    var customDataTask: URLSessionDataTask?
    var isForUrlComponents = false

    // MARK: Private properties

    private let output: RequestBreakpointViewOutput

    private let contentView = UIView()
    private let scrollView = UIScrollView()

    private let requestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Request"
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "URL"
        return label
    }()

    private let urlTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
    }()

    private let queryParametersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Query parameters"
        return label
    }()

    private let queryParametersTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let headersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Headers"
        return label
    }()

    private let headersTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Body"
        return label
    }()

    private let bodyTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let toResponseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("To response", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: Lifecycle

    init(output: RequestBreakpointViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        output.viewDidLoad()
    }

    // MARK: Private methods

    @objc private func closeButtonTapped() { self.dismiss(animated: true) }

    @objc private func sendButtonTapped() {
        if isForUrlComponents {
            processUrlComponents()
        } else {
            processUrlRequest()
        }
    }

    @objc private func toResponseButtonTapped() {
        if isForUrlComponents {
            processUrlComponentsForResponse()
        } else {
            processUrlRequestForResponse()
        }
    }

    private func processUrlComponents() {
        let url = urlTextField.text
        let query = parseQueryString(queryParametersTextField.text)

        var components = URLComponents(string: url!)!
        components.queryItems = query

        onConfiguredWithURLComponents?(components, false)
        self.dismiss(animated: true)
    }

    private func processUrlComponentsForResponse() {
        let url = urlTextField.text
        let query = parseQueryString(queryParametersTextField.text)

        var components = URLComponents(string: url!)!
        components.queryItems = query

        onConfiguredWithURLComponents?(components, true)
    }

    private func processUrlRequest() {
        let url = urlTextField.text ?? ""
        let query = parseQueryString(queryParametersTextField.text)
        let data = bodyTextField.text.data(using: .utf8)
        let headers = parseStringToDict(headersTextField.text)

        var components = URLComponents(string: url)
        components?.queryItems = query

        var request = URLRequest(url: components!.url!)
        request.httpBody = data
        request.httpMethod = "POST"
        headers?.forEach({ (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        })
        onConfiguredWithURLRequest?(request, false)
        self.dismiss(animated: true)
    }

    private func processUrlRequestForResponse() {
        let url = urlTextField.text ?? ""
        let query = parseQueryString(queryParametersTextField.text)
        let data = bodyTextField.text.data(using: .utf8)
        let headers = parseStringToDict(headersTextField.text)

        var components = URLComponents(string: url)
        components?.queryItems = query

        var request = URLRequest(url: components!.url!)
        request.httpBody = data
        request.httpMethod = "POST"
        headers?.forEach({ (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        })
        onConfiguredWithURLRequest?(request, true)
    }

    private func parseQueryString(_ queryString: String) -> [URLQueryItem] {
        var queries: [URLQueryItem] = []
        let components = queryString.components(separatedBy: "\n")

        for component in components {
            let keyValuePair = component.components(separatedBy: "=")
            if keyValuePair.count == 2 {
                let key = keyValuePair[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let value = keyValuePair[1].trimmingCharacters(in: .whitespacesAndNewlines)
                queries.append(URLQueryItem(name: key, value: value))
            }
        }

        return queries
    }

    private func parseStringToDict(_ string: String) -> [String: String]? {
        var result: [String: String] = [:]
        let components = string.components(separatedBy: "\n")

        for component in components {
            let keyValuePair = component.components(separatedBy: " = ")
            if keyValuePair.count == 2 {
                let key = keyValuePair[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let value = keyValuePair[1].trimmingCharacters(in: .whitespacesAndNewlines)
                result[key] = value
            }
        }

        return result
    }

    func setupScrollView(){
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        // URL

        contentView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
        ])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        contentView.addSubview(urlLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlLabel, attribute: .top, relatedBy: .equal, toItem: closeButton, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(urlTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlTextField, attribute: .leading, relatedBy: .equal, toItem: urlLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: urlTextField, attribute: .top, relatedBy: .equal, toItem: urlLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: urlTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 32)
        ])

        // Query parameters

        contentView.addSubview(queryParametersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersLabel, attribute: .top, relatedBy: .equal, toItem: urlTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: queryParametersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(queryParametersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersTextField, attribute: .leading, relatedBy: .equal, toItem: queryParametersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .top, relatedBy: .equal, toItem: queryParametersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 96)
        ])

        // Headers

        contentView.addSubview(headersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersLabel, attribute: .top, relatedBy: .equal, toItem: queryParametersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(headersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersTextField, attribute: .leading, relatedBy: .equal, toItem: headersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: headersTextField, attribute: .top, relatedBy: .equal, toItem: headersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: headersTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 96)
        ])

        // Body

        contentView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyLabel, attribute: .top, relatedBy: .equal, toItem: headersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(bodyTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyTextField, attribute: .leading, relatedBy: .equal, toItem: bodyLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: bodyTextField, attribute: .top, relatedBy: .equal, toItem: bodyLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: bodyTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 320)
        ])

        contentView.addSubview(sendButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: sendButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: sendButton, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)

        // Title

        contentView.addSubview(requestLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: requestLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: requestLabel, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])

        // To response button

        contentView.addSubview(toResponseButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: toResponseButton, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: toResponseButton, attribute: .top, relatedBy: .equal, toItem: bodyTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyTextField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -48)
        ])
        toResponseButton.addTarget(self, action: #selector(toResponseButtonTapped), for: .touchUpInside)
    }

    private func convertDictionaryToString(_ dictionary: [String: String]?) -> String {
        guard let dictionary else { return "" }

        var string = ""
        for (key, value) in dictionary {
            string += "\(key) = \(value)\n"
        }
        return string
    }
}

extension RequestBreakpointViewController: RequestBreakpointViewInput {
    func set(displayData: DisplayData) {
        urlTextField.text = displayData.url
        queryParametersTextField.text = convertDictionaryToString(displayData.queryParameters)
        isForUrlComponents = displayData.forUrlComponents

        if displayData.forUrlComponents {
            bodyLabel.isHidden = true
            bodyTextField.isHidden = true
            headersTextField.isHidden = true
            headersLabel.isHidden = true
        } else {
            bodyTextField.text = displayData.template.requestBody == nil ? displayData.body : displayData.template.requestBody
            headersTextField.text = convertDictionaryToString(displayData.headers)
        }
    }
}
